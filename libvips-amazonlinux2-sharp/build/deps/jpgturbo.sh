export JPGTURBO_VERSION=2.0.90

JPGTURBO_URL=https://github.com/libjpeg-turbo/libjpeg-turbo/archive

cd /usr/local/src
wget -N ${JPGTURBO_URL}/${JPGTURBO_VERSION}.tar.gz -O jpgturbo-${JPGTURBO_VERSION}.tar.gz
tar xzf jpgturbo-${JPGTURBO_VERSION}.tar.gz
cd libjpeg-turbo-${JPGTURBO_VERSION}
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