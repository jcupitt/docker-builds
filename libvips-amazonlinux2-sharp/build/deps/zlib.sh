ZLIB_VERSION=2.0.2
ZLIB_URL=https://github.com/zlib-ng/zlib-ng/archive/

cd /usr/local/src
wget -N ${ZLIB_URL}/${ZLIB_VERSION}.tar.gz -O zlib-${ZLIB_VERSION}.tar.gz
tar xzf zlib-${ZLIB_VERSION}.tar.gz
cd zlib-ng-${ZLIB_VERSION}
CFLAGS="${CFLAGS} -O3" LDFLAGS=${LDFLAGS/\$/} cmake -G"Unix Makefiles" \
  -DCMAKE_TOOLCHAIN_FILE=/packaging/Toolchain.cmake \
  -DCMAKE_INSTALL_PREFIX=${PREFIX} \
  -DBUILD_SHARED_LIBS=FALSE \
  -DZLIB_COMPAT=TRUE
make V=0
make install