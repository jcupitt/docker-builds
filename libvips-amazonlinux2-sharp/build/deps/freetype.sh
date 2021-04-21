FREETYPE_VERSION=2.10.4
FREETYPE_URL=https://download.savannah.gnu.org/releases/freetype

cd /usr/local/src
wget -N ${FREETYPE_URL}/freetype-${FREETYPE_VERSION}.tar.xz
tar Jxf freetype-${FREETYPE_VERSION}.tar.xz
cd freetype-${FREETYPE_VERSION}
./configure \
  --prefix=${PREFIX} \
  --enable-static --disable-shared \
  --disable-dependency-tracking \
  --without-bzip2 \
  --without-png
make V=0
make install