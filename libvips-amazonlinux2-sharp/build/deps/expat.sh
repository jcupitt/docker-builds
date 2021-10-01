export EXPAT_VERSION=2.3.0

EXPAT_URL=https://github.com/libexpat/libexpat/releases/download/R_

cd /usr/local/src
wget -N ${EXPAT_URL}${EXPAT_VERSION//./_}/expat-${EXPAT_VERSION}.tar.xz
tar Jxf expat-${EXPAT_VERSION}.tar.xz
cd expat-${EXPAT_VERSION}
./configure \
  --prefix=${PREFIX} \
  --enable-static --disable-shared \
  --disable-dependency-tracking \
  --without-xmlwf \
  --without-docbook \
  --without-getrandom \
  --without-sys-getrandom \
  --without-libbsd \
  --without-examples \
  --without-tests
make install-strip