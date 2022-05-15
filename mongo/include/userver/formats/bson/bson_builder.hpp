#pragma once

/// @file userver/formats/bson/bson_builder.hpp
/// @brief Internal helpers for inline document build

#include <chrono>
#include <cstddef>
#include <string_view>

#include <userver/compiler/select.hpp>
#include <userver/formats/bson/types.hpp>
#include <userver/formats/bson/value.hpp>
#include <userver/utils/fast_pimpl.hpp>

USERVER_NAMESPACE_BEGIN

namespace formats::bson::impl {

class MutableBson;

class BsonBuilder {
 public:
  BsonBuilder();
  explicit BsonBuilder(const ValueImpl&);
  ~BsonBuilder();

  BsonBuilder(const BsonBuilder&);
  BsonBuilder(BsonBuilder&&) noexcept;
  BsonBuilder& operator=(const BsonBuilder&);
  BsonBuilder& operator=(BsonBuilder&&) noexcept;

  BsonBuilder& Append(std::string_view key, std::nullptr_t);
  BsonBuilder& Append(std::string_view key, bool);
  BsonBuilder& Append(std::string_view key, int32_t);
  BsonBuilder& Append(std::string_view key, int64_t);
  BsonBuilder& Append(std::string_view key, uint64_t);
// MAC_COMPAT: different typedefs for 64_t on MacOs or on x32
#if defined(__APPLE__) || !defined(__x86_64__)
  BsonBuilder& Append(std::string_view key, long);
  BsonBuilder& Append(std::string_view key, unsigned long);
#else
  BsonBuilder& Append(std::string_view key, long long);
  BsonBuilder& Append(std::string_view key, unsigned long long);
#endif
  BsonBuilder& Append(std::string_view key, double);
  BsonBuilder& Append(std::string_view key, const char*);
  BsonBuilder& Append(std::string_view key, std::string_view);
  BsonBuilder& Append(std::string_view key,
                      std::chrono::system_clock::time_point);
  BsonBuilder& Append(std::string_view key, const Oid&);
  BsonBuilder& Append(std::string_view key, const Binary&);
  BsonBuilder& Append(std::string_view key, const Decimal128&);
  BsonBuilder& Append(std::string_view key, MinKey);
  BsonBuilder& Append(std::string_view key, MaxKey);
  BsonBuilder& Append(std::string_view key, const Timestamp&);

  BsonBuilder& Append(std::string_view key, const Value&);

  BsonBuilder& Append(std::string_view key, const bson_t*);

  const bson_t* Get() const;
  bson_t* Get();

  BsonHolder Extract();

 private:
  void AppendInto(bson_t*, std::string_view key, const ValueImpl&);

  static constexpr std::size_t kSize = compiler::SelectSize()  //
                                           .ForX64(8)
                                           .ForX32(4);
  static constexpr std::size_t kAlignment = alignof(void*);
  utils::FastPimpl<MutableBson, kSize, kAlignment, utils::kStrictMatch> bson_;
};

}  // namespace formats::bson::impl

USERVER_NAMESPACE_END
