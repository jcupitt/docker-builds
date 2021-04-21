SPNG_VERSION=0.6.2
SPNG_URL=https://github.com/randy408/libspng/archive

cd /usr/local/src
wget -N ${SPNG_URL}/v${SPNG_VERSION}.tar.gz -O libspng-${SPNG_VERSION}.tar.gz
tar xzf libspng-${SPNG_VERSION}.tar.gz
cd libspng-${SPNG_VERSION}
CFLAGS="${CFLAGS} -O3" meson setup _build --default-library=static --buildtype=release --strip --prefix=${PREFIX} ${MESON} \
  -Dstatic_zlib=true
ninja -C _build
ninja -C _build install