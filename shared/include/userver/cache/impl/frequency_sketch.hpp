#pragma once

#include <cmath>
#include <cstdint>
#include <limits>
#include <vector>

#include <userver/cache/policy.hpp>

USERVER_NAMESPACE_BEGIN

namespace cache::impl {
template <typename T,
          FrequencySketchPolicy policy = FrequencySketchPolicy::Bloom>
class FrequencySketch {};

template <typename T>
class FrequencySketch<T, FrequencySketchPolicy::Bloom> {
  using freq_type = int;

 public:
  explicit FrequencySketch(std::size_t capacity);
  freq_type GetFrequency(const T& item);
  void RecordAccess(const T& item);

 private:
  std::vector<uint64_t> table_;
  freq_type access_count_{0};
  static constexpr std::size_t counter_size_ = 4;
  static constexpr int access_count_limit_rate_ = 10;
  static constexpr int num_hashes_ = 4;

  freq_type GetCount(const T& item, int step);
  uint32_t GetHash(const T& item);
  uint32_t GetHash(const T& item, int step);
  int GetIndex(uint32_t hash);
  int GetOffset(uint32_t hash, int step);

  bool TryIncrement(const T& item, int step);
  void Update();
};

template <typename T>
FrequencySketch<T, FrequencySketchPolicy::Bloom>::FrequencySketch(
    std::size_t capacity)
    : table_(capacity / sizeof(uint64_t) * counter_size_) {}

template <typename T>
int FrequencySketch<T, FrequencySketchPolicy::Bloom>::GetFrequency(
    const T& item) {
  auto freq = std::numeric_limits<freq_type>::max();
  for (int i = 0; i < num_hashes_; i++)
    freq = std::min(freq, GetCount(item, i));
  return freq;
}

template <typename T>
int FrequencySketch<T, FrequencySketchPolicy::Bloom>::GetCount(const T& item,
                                                               int step) {
  auto hash = GetHash(item, step);
  int index = GetIndex(hash);
  int offset = GetOffset(hash, step);
  return (table_[index] >> offset) & ((1 << counter_size_) - 1);
}

template <typename T>
uint32_t FrequencySketch<T, FrequencySketchPolicy::Bloom>::GetHash(
    const T& item) {
  const char* data = reinterpret_cast<const char*>(&item);
  uint32_t hash = 0;

  for (auto i = 0; i < static_cast<int>(sizeof item); ++i) {
    hash += data[i];
    hash += hash << 10;
    hash ^= hash >> 6;
  }

  hash += hash << 3;
  hash ^= hash >> 11;
  hash += hash << 15;

  return hash;
}

template <typename T>
uint32_t FrequencySketch<T, FrequencySketchPolicy::Bloom>::GetHash(
    const T& item, int step) {
  static constexpr uint64_t seeds[] = {0xc3a5c85c97cb3127L, 0xb492b66fbe98f273L,
                                       0x9ae16a3b2f90404fL,
                                       0xcbf29ce484222325L};
  uint64_t hash = seeds[step] * GetHash(item);
  hash += hash >> 32;
  return hash;
}

template <typename T>
int FrequencySketch<T, FrequencySketchPolicy::Bloom>::GetIndex(uint32_t hash) {
  return hash & (table_.size() - 1);
}

template <typename T>
int FrequencySketch<T, FrequencySketchPolicy::Bloom>::GetOffset(uint32_t hash,
                                                                int step) {
  return (((hash & 3) << 2) + step) << 2;
}

template <typename T>
void FrequencySketch<T, FrequencySketchPolicy::Bloom>::RecordAccess(
    const T& item) {
  auto was_added = false;
  for (int i = 0; i < num_hashes_; i++) was_added |= TryIncrement(item, i);
  if (was_added &&
      (++access_count_ == static_cast<freq_type>(table_.size() * access_count_limit_rate_)))
    Update();
}

template <typename T>
bool FrequencySketch<T, FrequencySketchPolicy::Bloom>::TryIncrement(
    const T& item, int step) {
  auto hash = GetHash(item, step);
  int index = GetIndex(hash);
  int offset = GetOffset(hash, step);
  if (GetCount(item, step) != ((1 << counter_size_) - 1)) {
    table_[index] += 1L << offset;
    return true;
  }
  return false;
}

template <typename T>
void FrequencySketch<T, FrequencySketchPolicy::Bloom>::Update() {
  for (auto& counters : table_)
    counters = (counters >> 1) & 0x7777777777777777L;
  access_count_ = (access_count_ >> 1);
}

}  // namespace cache::impl

USERVER_NAMESPACE_END