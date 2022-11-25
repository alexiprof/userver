#include <userver/cache/impl/hash.hpp>

USERVER_NAMESPACE_BEGIN

namespace cache::impl::tools {
size_t NextPowerOfTwo(size_t n) {
  UASSERT(n > 0);
  n--;
  n |= n >> 1;
  n |= n >> 2;
  n |= n >> 4;
  n |= n >> 8;
  n |= n >> 16;
  n++;
  return n;
}
}  // namespace cache::impl::tools

USERVER_NAMESPACE_END