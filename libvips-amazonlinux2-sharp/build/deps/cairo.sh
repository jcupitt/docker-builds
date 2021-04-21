CAIRO_URL=https://ftp.osuosl.org/pub/blfs/conglomeration/cairo
CAIRO_VERSION=1.16.0

cd /usr/local/src
wget -N ${CAIRO_URL}/cairo-${CAIRO_VERSION}.tar.xz
tar Jxf cairo-${CAIRO_VERSION}.tar.xz
cd cairo-${CAIRO_VERSION}
sed -i'.bak' "s/ boilerplate test perf//" Makefile.in
sed -i'.bak' "s/^\(Libs:.*\)/\1 @CAIRO_NONPKGCONFIG_LIBS@/" src/cairo.pc.in
CFLAGS="$CFLAGS -fno-function-sections -fno-data-sections" LDFLAGS="$LDFLAGS -Wl,--no-gc-sections" ./configure \
  --host=${CHOST} \
  --prefix=${PREFIX} --enable-static \
  --disable-shared \
  --disable-dependency-tracking \
  --disable-xlib \
  --disable-xcb \
  --disable-win32 \
  --disable-egl \
  --disable-glx \
  --disable-wgl \
  --disable-ps \
  --disable-trace \
  --disable-interpreter \
  --disable-quartz \
  LIBS="-lpixman-1 -lfreetype"
make V=0
make install