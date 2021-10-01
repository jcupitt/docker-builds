export SVG_VERSION=2.51.1

SVG_URL=https://download.gnome.org/sources/librsvg/${SVG_VERSION%.[[:digit:]]*}

cd /usr/local/src
wget -N ${SVG_URL}/librsvg-${SVG_VERSION}.tar.xz
tar Jxf librsvg-${SVG_VERSION}.tar.xz
cd librsvg-${SVG_VERSION}
sed -i'.bak' "s/^\(Requires:.*\)/\1 cairo-gobject pangocairo/" librsvg.pc.in
sed -i'.bak' "s/, \"rlib\"//" Cargo.toml
sed -i'.bak' "/SCRIPTS = /d" Makefile.in
./configure \
  --prefix=${PREFIX} \
  --enable-static --disable-shared \
  --disable-dependency-tracking \
  --disable-introspection \
  --disable-tools \
  --disable-pixbuf-loader \
  --disable-nls \
  --without-libiconv-prefix \
  --without-libintl-prefix
make install-strip