PANGO_VERSION=1.48.4
PANGO_URL=https://github.com/GNOME/pango/archive/refs/tags

cd /usr/local/src
wget -N ${PANGO_URL}/${PANGO_VERSION}.tar.gz -O pango-${PANGO_VERSION}.tar.gz
tar xzf pango-${PANGO_VERSION}.tar.gz
cd pango-${PANGO_VERSION}
sed -i'.bak' "/subdir('utils')/{N;N;N;d;}" meson.build
LDFLAGS=${LDFLAGS/\$/} meson setup _build \
  ${MESON} \
  --default-library=static \
  --buildtype=release \
  --prefix=${PREFIX} \
  -Dgtk_doc=false \
  -Dintrospection=disabled \
  -Dfontconfig=enabled
ninja -C _build
ninja -C _build install