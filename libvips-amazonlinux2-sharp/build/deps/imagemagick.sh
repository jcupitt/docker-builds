IMAGEMAGICK_VERSION=7.0.11-8
IMAGEMAGICK_URL=https://imagemagick.org/download/

cd /usr/local/src
wget -N ${IMAGEMAGICK_URL}/ImageMagick.tar.xz -O imagemagick-${IMAGEMAGICK_VERSION}.tar.xz
tar Jxf imagemagick-${IMAGEMAGICK_VERSION}.tar.xz
cd ImageMagick-${IMAGEMAGICK_VERSION}
CFLAGS="${CFLAGS} -O3" ./configure --prefix=${PREFIX} --sysconfdir=${PREFIX}/etc --enable-hdri --with-gslib --with-rsvg --disable-static
make V=0
make install