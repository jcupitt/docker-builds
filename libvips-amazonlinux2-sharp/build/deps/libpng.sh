PNG16_VERSION=1.6.37
PNG16_URL=https://ftp.osuosl.org/pub/blfs/conglomeration/libpng

cd /usr/local/src
wget -N ${PNG16_URL}/libpng-${PNG16_VERSION}.tar.xz
tar Jxf libpng-${PNG16_VERSION}.tar.xz
cd libpng-${PNG16_VERSION}
CFLAGS="${CFLAGS} -O3" ./configure --host=${CHOST} --prefix=${PREFIX} --enable-static --disable-shared --disable-dependency-tracking
make V=0
make install