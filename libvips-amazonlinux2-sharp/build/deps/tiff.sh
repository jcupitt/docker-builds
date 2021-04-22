export TIFF_VERSION=4.2.0

TIFF_URL=https://download.osgeo.org/libtiff

cd /usr/local/src
wget -N ${TIFF_URL}/tiff-${TIFF_VERSION}.tar.gz
tar xzf tiff-${TIFF_VERSION}.tar.gz
cd tiff-${TIFF_VERSION}
if [ -n "${CHOST}" ]; then autoreconf -fiv; fi
./configure --host=${CHOST} --prefix=${PREFIX} --enable-static --disable-shared --disable-dependency-tracking \
  --disable-mdi --disable-pixarlog --disable-old-jpeg --disable-cxx --disable-lzma --disable-zstd \
  --with-jpeg-include-dir=${PREFIX}/include --with-jpeg-lib-dir=${PREFIX}/lib
make install-strip
