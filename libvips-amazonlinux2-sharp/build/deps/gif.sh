export GIF_VERSION=5.1.4

GIF_URL=https://downloads.sourceforge.net/project/giflib

cd /usr/local/src
wget -N ${GIF_URL}/giflib-${GIF_VERSION}.tar.gz
tar xzf giflib-${GIF_VERSION}.tar.gz
cd giflib-${GIF_VERSION}
CFLAGS="${CFLAGS} -O3" ./configure --host=${CHOST} --prefix=${PREFIX} --enable-static --disable-shared --disable-dependency-tracking
make install-strip