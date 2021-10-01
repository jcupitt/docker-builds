export WEBP_VERSION=1.0.2

WEBP_URL=https://storage.googleapis.com/downloads.webmproject.org/releases/webp

cd /usr/local/src
wget -N ${WEBP_URL}/libwebp-${WEBP_VERSION}.tar.gz
tar xzf libwebp-${WEBP_VERSION}.tar.gz
cd libwebp-${WEBP_VERSION}
./configure \
  --prefix=${PREFIX} \
  --enable-static --disable-shared \
  --enable-libwebpmux \
  --enable-libwebpdemux
make install-strip