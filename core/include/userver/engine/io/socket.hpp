#pragma once

/// @file userver/engine/io/socket.hpp
/// @brief @copybrief engine::io::Socket

#include <sys/socket.h>
#include <sys/uio.h>

#include <userver/engine/deadline.hpp>
#include <userver/engine/io/common.hpp>
#include <userver/engine/io/exception.hpp>
#include <userver/engine/io/fd_control_holder.hpp>
#include <userver/engine/io/sockaddr.hpp>
#include <userver/utils/clang_format_workarounds.hpp>

USERVER_NAMESPACE_BEGIN

namespace engine::io {

/// Socket type
enum class SocketType {
  kStream = SOCK_STREAM,  ///< Stream socket (e.g. TCP)
  kDgram = SOCK_DGRAM,    ///< Datagram socket (e.g. UDP)

  kTcp = kStream,
  kUdp = kDgram,
};

/// Socket representation.
class USERVER_NODISCARD Socket final : public ReadableBase {
 public:
  struct RecvFromResult {
    size_t bytes_received{0};
    Sockaddr src_addr;
  };

  /// Constructs an invalid socket.
  Socket() = default;

  /// Constructs a socket for the address domain of specified type.
  Socket(AddrDomain, SocketType);

  /// @brief Adopts an existing socket for specified address domain.
  /// @note File descriptor will be silently forced to nonblocking mode.
  explicit Socket(int fd, AddrDomain domain = AddrDomain::kUnspecified);

  /// Whether the socket is valid.
  explicit operator bool() const { return IsValid(); }

  /// Whether the socket is valid.
  bool IsValid() const override;

  /// @brief Connects the socket to a specified endpoint.
  /// @note Sockaddr domain must match the socket's domain.
  void Connect(const Sockaddr&, Deadline);

  /// @brief Binds the socket to the specified endpoint.
  /// @note Sockaddr domain must match the socket's domain.
  void Bind(const Sockaddr&);

  /// Starts listening for connections on a specified socket (must be bound).
  void Listen(int backlog = SOMAXCONN);

  /// Suspends current task until the socket has data available.
  [[nodiscard]] bool WaitReadable(Deadline) override;

  /// Suspends current task until the socket can accept more data.
  [[nodiscard]] bool WaitWriteable(Deadline);

  /// @brief Receives at least one byte from the socket.
  /// @returns 0 if connnection is closed on one side and no data could be
  /// received any more, received bytes count otherwise.
  [[nodiscard]] size_t RecvSome(void* buf, size_t len, Deadline deadline);

  /// @brief Receives exactly len bytes from the socket.
  /// @note Can return less than len if socket is closed by peer.
  [[nodiscard]] size_t RecvAll(void* buf, size_t len, Deadline deadline);

  /// @brief Sends exactly N buffers to the socket.
  /// @note Can return less than len if socket is closed by peer.
  template <std::size_t N>
  [[nodiscard]] size_t SendAll(std::pair<const void*, std::size_t>(&&data)[N],
                               Deadline deadline);

  /// @brief Sends exactly n buffers to the socket.
  /// @note Can return less than len if socket is closed by peer.
  [[nodiscard]] size_t SendAll(struct iovec* list, std::size_t n,
                               Deadline deadline);

  /// @brief Sends exactly len bytes to the socket.
  /// @note Can return less than len if socket is closed by peer.
  [[nodiscard]] size_t SendAll(const void* buf, size_t len, Deadline deadline);

  /// @brief Accepts a connection from a listening socket.
  /// @see engine::io::Listen
  [[nodiscard]] Socket Accept(Deadline);

  /// @brief Receives at least one byte from the socket, returning source
  /// address.
  /// @returns 0 in bytes_sent if connnection is closed on one side and no data
  /// could be received any more, received bytes count otherwise + source
  /// address.
  [[nodiscard]] RecvFromResult RecvSomeFrom(void* buf, size_t len,
                                            Deadline deadline);

  /// @brief Sends exactly len bytes to the specified address via the socket.
  /// @note Can return less than len in bytes_sent if socket is closed by peer.
  /// @note Sockaddr domain must match the socket's domain.
  /// @note Not for SocketType::kStream connections, see `man sendto`.
  [[nodiscard]] size_t SendAllTo(const Sockaddr& dest_addr, const void* buf,
                                 size_t len, Deadline deadline);

  /// File descriptor corresponding to this socket.
  int Fd() const;

  /// Address of a remote peer.
  const Sockaddr& Getpeername();

  /// Local socket address.
  const Sockaddr& Getsockname();

  /// Releases file descriptor and invalidates the socket.
  [[nodiscard]] int Release() && noexcept;

  /// @brief Closes and invalidates the socket.
  /// @warning You should not call Close with pending I/O. This may work okay
  /// sometimes but it's loosely predictable.
  void Close();

  /// Retrieves a socket option.
  int GetOption(int layer, int optname) const;

  /// Sets a socket option.
  void SetOption(int layer, int optname, int optval);

  /// @brief Receives at least one byte from the socket.
  /// @returns 0 if connnection is closed on one side and no data could be
  /// received any more, received bytes count otherwise.
  [[nodiscard]] size_t ReadSome(void* buf, size_t len,
                                Deadline deadline) override {
    return RecvSome(buf, len, deadline);
  }

  /// @brief Receives exactly len bytes from the socket.
  /// @note Can return less than len if socket is closed by peer.
  [[nodiscard]] size_t ReadAll(void* buf, size_t len,
                               Deadline deadline) override {
    return RecvAll(buf, len, deadline);
  }

 private:
  AddrDomain domain_{AddrDomain::kUnspecified};

  impl::FdControlHolder fd_control_;
  Sockaddr peername_;
  Sockaddr sockname_;
};

template <std::size_t N>
size_t Socket::SendAll(std::pair<const void*, std::size_t>(&&data)[N],
                       Deadline deadline) {
  static_assert(N > 0, "Attempt to SendAll is empty");
  struct iovec list[N];
  for (auto i = 0; i < N; ++i) {
    // NOLINTNEXTLINE(cppcoreguidelines-pro-type-const-cast)
    list[i].iov_base = const_cast<void*>(data[i].first);
    list[i].iov_len = data[i].second;
  }
  return SendAll(list, N, deadline);
}

}  // namespace engine::io

USERVER_NAMESPACE_END
