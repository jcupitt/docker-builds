export FONTCONFIG_VERSION=2.13.93

FONTCONFIG_URL=https://www.freedesktop.org/software/fontconfig/release

cd /usr/local/src
wget -N ${FONTCONFIG_URL}/fontconfig-${FONTCONFIG_VERSION}.tar.xz
tar Jxf fontconfig-${FONTCONFIG_VERSION}.tar.xz
cd fontconfig-${FONTCONFIG_VERSION}
./configure \
  --prefix=${PREFIX} \
  --enable-static --disable-shared \
  --disable-dependency-tracking \
  --with-expat-includes=${PREFIX}/include \
  --with-expat-lib=${PREFIX}/lib \
  --disable-docs
make install-strip