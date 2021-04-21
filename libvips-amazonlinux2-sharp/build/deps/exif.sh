EXIF_VERSION=0.6.22
EXIF_URL=https://github.com/libexif/libexif/releases/download/libexif-${EXIF_VERSION//./_}-release

cd /usr/local/src
wget -N ${EXIF_URL}/libexif-${EXIF_VERSION}.tar.xz
tar Jxf libexif-${EXIF_VERSION}.tar.xz
cd libexif-${EXIF_VERSION}
autoreconf -fiv
./configure --host=${CHOST} --prefix=${PREFIX} --enable-static --disable-shared --disable-dependency-tracking
make V=0
make install