export MOZJPEG_VERSION=4.0.3

MOZJPEG_URL=https://github.com/mozilla/mozjpeg/archive

cd /usr/local/src
wget -N ${MOZJPEG_URL}/v${MOZJPEG_VERSION}.tar.gz -O mozjpeg-${MOZJPEG_VERSION}.tar.gz
tar xzf mozjpeg-${MOZJPEG_VERSION}.tar.gz
cd mozjpeg-${MOZJPEG_VERSION}
CFLAGS="${CFLAGS} -O3" LDFLAGS=${LDFLAGS/\$/} cmake -G"Unix Makefiles" \
  -DCMAKE_TOOLCHAIN_FILE=/packaging/Toolchain.cmake \
  -DCMAKE_INSTALL_PREFIX=${PREFIX} \
  -DCMAKE_INSTALL_LIBDIR=${PREFIX}/lib \
  -DENABLE_STATIC=TRUE \
  -DENABLE_SHARED=FALSE \
  -DWITH_JPEG8=1 \
  -DWITH_TURBOJPEG=FALSE \
  -DPNG_SUPPORTED=FALSE
make install/strip