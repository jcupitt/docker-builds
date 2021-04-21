GLIB_VERSION=2.68.1
GLIB_URL=https://download.gnome.org/sources/glib/${GLIB_VERSION%.[[:digit:]]*}

cd /usr/local/src
wget -N ${GLIB_URL}/glib-${GLIB_VERSION}.tar.xz
tar Jxf glib-${GLIB_VERSION}.tar.xz
cd glib-${GLIB_VERSION}
LDFLAGS=${LDFLAGS/\$/} meson setup _build \
  ${MESON} \
  --default-library=static \
  --prefix=${PREFIX} \
  -Dinternal_pcre=true \
  -Dtests=false \
  -Dinstalled_tests=false \
  -Dlibmount=disabled \
  -Dlibelf=disabled
ninja -C _build
ninja -C _build install