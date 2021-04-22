export GDKPIXBUF_VERSION=2.42.6

GDKPIXBUF_URL=https://download.gnome.org/sources/gdk-pixbuf/${GDKPIXBUF_VERSION%.[[:digit:]]*}

cd /usr/local/src
wget -N ${GDKPIXBUF_URL}/gdk-pixbuf-${GDKPIXBUF_VERSION}.tar.xz
tar Jxf gdk-pixbuf-${GDKPIXBUF_VERSION}.tar.xz
cd gdk-pixbuf-${GDKPIXBUF_VERSION}
sed -i'.bak' "/subdir('tests')/{N;d;}" meson.build
sed -i'.bak' "/post-install/{N;N;N;N;d;}" meson.build
sed -i'.bak' "/'bmp':/{N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;d;}" gdk-pixbuf/meson.build
sed -i'.bak' "/'pnm':/{N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;N;d;}" gdk-pixbuf/meson.build
sed -i'.bak' "/gdk-pixbuf-csource/{N;N;d;}" gdk-pixbuf/meson.build
sed -i'.bak' "/loaders_cache = custom/{N;N;N;N;N;N;N;N;N;c\\
  loaders_cache = []\\
  loaders_dep = declare_dependency()
}" gdk-pixbuf/meson.build
sed -i'.bak' "s/has_header('jpeglib.h')/has_header('jpeglib.h', args: '-I\/target\/include')/g" meson.build
sed -i'.bak' "s/cc.find_library('jpeg'/dependency('libjpeg'/g" meson.build
LDFLAGS=${LDFLAGS/\$/} meson setup _build \
  ${MESON} \
  --default-library=static \
  --buildtype=release \
  --prefix=${PREFIX} \
  -Dtiff=false \
  -Dintrospection=disabled \
  -Dinstalled_tests=false \
  -Dgio_sniffing=false \
  -Dman=false \
  -Dbuiltin_loaders=png,jpeg
ninja -C _build
ninja -C _build install
#sed -i'.bak' "s/^\(Requires:.*\)/\1 libjpeg, libpng16/" ${PREFIX}/lib/pkgconfig/gdk-pixbuf-2.0.pc