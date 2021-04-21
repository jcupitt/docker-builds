LCMS2_VERSION=2.12
LCMS2_URL=https://downloads.sourceforge.net/project/lcms/lcms/${LCMS2_VERSION}

cd /usr/local/src
wget -N ${LCMS2_URL}/lcms2-${LCMS2_VERSION}.tar.gz
tar xzf lcms2-${LCMS2_VERSION}.tar.gz
cd lcms2-${LCMS2_VERSION}
CFLAGS="${CFLAGS} -O3" ./configure --host=${CHOST} --prefix=${PREFIX} --enable-static --disable-shared --disable-dependency-tracking
make V=0
make install