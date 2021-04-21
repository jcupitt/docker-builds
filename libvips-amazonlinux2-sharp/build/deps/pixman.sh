PIXMAN_URL=https://ftp.osuosl.org/pub/blfs/conglomeration/pixman
PIXMAN_VERSION=0.38.4

cd /usr/local/src
wget -N ${PIXMAN_URL}/pixman-${PIXMAN_VERSION}.tar.gz
tar xzf pixman-${PIXMAN_VERSION}.tar.gz
cd pixman-${PIXMAN_VERSION}
LDFLAGS=${LDFLAGS/\$/} ./configure  \
  --prefix=${PREFIX} \
  --enable-static --disable-shared \
  --with-sysroot=${PREFIX} \
  --disable-dependency-tracking \
  --disable-arm-iwmmxt
make V=0
make install