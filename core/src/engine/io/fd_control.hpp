#pragma once

#include <sys/uio.h>
#include <atomic>
#include <cerrno>

#include <userver/engine/deadline.hpp>
#include <userver/engine/io/exception.hpp>
#include <userver/engine/io/fd_control_holder.hpp>
#include <userver/engine/mutex.hpp>
#include <userver/engine/task/cancel.hpp>
#include <userver/logging/log.hpp>
#include <userver/utils/assert.hpp>

#include <engine/ev/watcher.hpp>
#include <engine/task/task_context.hpp>
#include <userver/engine/impl/wait_list_fwd.hpp>

USERVER_NAMESPACE_BEGIN

namespace engine::io::impl {

/// I/O operation transfer mode
enum class TransferMode {
  kPartial,  ///< operation may complete after transferring any amount of data
  kWhole,    ///< operation may complete only after the whole buffer is
             ///< transferred
  kOnce,     ///< operation will complete after the first successful transfer
};

enum class ErrorMode {
  kProcessed,
  kCancel,
};

class FdControl;

class Direction final {
 public:
  enum class Kind { kRead, kWrite };

  class Lock final {
   public:
    explicit Lock(Direction& dir) : impl_(dir.mutex_) {}

   private:
    std::lock_guard<Mutex> impl_;
  };

  Direction(const Direction&) = delete;
  Direction(Direction&&) = delete;
  Direction& operator=(const Direction&) = delete;
  Direction& operator=(Direction&&) = delete;
  ~Direction();

  explicit operator bool() const { return IsValid(); }
  bool IsValid() const { return is_valid_; }

  int Fd() const { return fd_; }

  [[nodiscard]] bool Wait(Deadline);

  // (IoFunc*)(int, void*, size_t), e.g. read
  template <typename IoFunc, typename... Context>
  size_t PerformIo(Lock& lock, IoFunc&& io_func, void* buf, size_t len,
                   TransferMode mode, Deadline deadline,
                   const Context&... context);

  template <typename IoFunc, typename... Context>
  size_t PerformIoV(Lock& lock, IoFunc&& io_func, struct iovec* list,
                    std::size_t size, TransferMode mode, Deadline deadline,
                    const Context&... context);

 private:
  friend class FdControl;
  explicit Direction(Kind kind);

  engine::impl::TaskContext::WakeupSource DoWait(Deadline);

  void Reset(int fd);
  void StopWatcher();
  void WakeupWaiters();

  // does not notify
  void Invalidate();

  template <typename... Context>
  ErrorMode ErrorProcessing(int code_error, size_t count, TransferMode mode,
                            Deadline deadline, Context&... context);

  static void IoWatcherCb(struct ev_loop*, ev_io*, int) noexcept;

  int fd_{-1};
  const Kind kind_;
  std::atomic<bool> is_valid_;
  Mutex mutex_;
  engine::impl::FastPimplWaitList waiters_;
  ev::Watcher<ev_io> watcher_;
};

class FdControl final {
 public:
  // fd will be silently forced to nonblocking mode
  static FdControlHolder Adopt(int fd);

  FdControl();
  ~FdControl();

  explicit operator bool() const { return IsValid(); }
  bool IsValid() const { return read_.IsValid(); }

  int Fd() const { return read_.Fd(); }

  Direction& Read() {
    UASSERT(IsValid());
    return read_;
  }
  Direction& Write() {
    UASSERT(IsValid());
    return write_;
  }

  void Close();

  // does not close, must have no waiting in progress
  void Invalidate();

 private:
  Direction read_;
  Direction write_;
};

template <typename... Context>
ErrorMode Direction::ErrorProcessing(int code_error, size_t processed_bytes,
                                     TransferMode mode, Deadline deadline,
                                     Context&... context) {
  if (code_error == EINTR) {
    return ErrorMode::kProcessed;
  } else if (code_error == EWOULDBLOCK || code_error == EAGAIN) {
    if (processed_bytes != 0 && mode != TransferMode::kWhole) {
      return ErrorMode::kCancel;
    }
    if (current_task::ShouldCancel()) {
      throw(IoCancelled(/*bytes_transferred =*/processed_bytes)
            << ... << context);
    }
    if (DoWait(deadline) ==
        engine::impl::TaskContext::WakeupSource::kDeadlineTimer) {
      throw(IoTimeout(/*bytes_transferred =*/processed_bytes)
            << ... << context);
    }
    if (!IsValid()) {
      throw((IoException() << "Fd closed during ") << ... << context);
    }
  } else {
    IoSystemError ex(code_error, "Direction::PerformIo");
    ex << "Error while ";
    (ex << ... << context);
    ex << ", fd=" << fd_;
    auto log_level = logging::Level::kError;
    if (code_error == ECONNRESET || code_error == EPIPE) {
      log_level = logging::Level::kWarning;
    }
    LOG(log_level) << ex;
    if (processed_bytes != 0) {
      return ErrorMode::kCancel;
    }
    throw std::move(ex);
  }
  return ErrorMode::kProcessed;
}

template <typename IoFunc, typename... Context>
size_t Direction::PerformIoV(Lock&, IoFunc&& io_func, struct iovec* list,
                             std::size_t size, TransferMode mode,
                             Deadline deadline, const Context&... context) {
  std::size_t processed_bytes = 0;
  do {
    auto chunk_size = io_func(fd_, list, size);

    if (chunk_size > 0) {
      processed_bytes += chunk_size;
      if (mode == TransferMode::kOnce) {
        break;
      }
      auto offset = chunk_size;
      do {
        if (auto len = list->iov_len; offset >= len) {
          ++list;
          offset -= len;
          --size;
          UASSERT(size != 0 || offset == 0);
        } else {
          list->iov_len -= offset;
          list->iov_base = static_cast<char*>(list->iov_base) + offset;
          offset = 0;
        }
      } while (offset != 0);
    } else if (!chunk_size) {
      break;
    } else {
      if (auto status = ErrorProcessing(errno, processed_bytes, mode, deadline,
                                        context...);
          status == ErrorMode::kCancel) {
        break;
      } else if (status == ErrorMode::kProcessed) {
        continue;
      }
    }
  } while (size != 0);
  return processed_bytes;
}

template <typename IoFunc, typename... Context>
size_t Direction::PerformIo(Lock&, IoFunc&& io_func, void* buf, size_t len,
                            TransferMode mode, Deadline deadline,
                            const Context&... context) {
  char* const begin = static_cast<char*>(buf);
  char* const end = begin + len;

  char* pos = begin;

  while (pos < end) {
    auto chunk_size = io_func(fd_, pos, end - pos);

    if (chunk_size > 0) {
      pos += chunk_size;
      if (mode == TransferMode::kOnce) {
        break;
      }
    } else if (!chunk_size) {
      break;
    } else {
      if (auto status =
              ErrorProcessing(errno, pos - begin, mode, deadline, context...);
          status == ErrorMode::kProcessed) {
        continue;
      } else if (status == ErrorMode::kCancel) {
        break;
      }
    }
  }
  return pos - begin;
}

}  // namespace engine::io::impl

USERVER_NAMESPACE_END
