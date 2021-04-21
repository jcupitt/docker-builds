ORC_VERSION=0.4.32
ORC_URL=https://gstreamer.freedesktop.org/data/src/orc

cd /usr/local/src
wget -N ${ORC_URL}/orc-${ORC_VERSION}.tar.xz
tar Jxf orc-${ORC_VERSION}.tar.xz
cd orc-${ORC_VERSION}
CFLAGS="${CFLAGS} -O3" LDFLAGS=${LDFLAGS/\$/} meson setup _build --default-library=static --buildtype=release --strip --prefix=${PREFIX} ${MESON} \
  -Dorc-test=disabled -Dbenchmarks=disabled -Dexamples=disabled -Dgtk_doc=disabled -Dtests=disabled -Dtools=disabled
ninja -C _build
ninja -C _build install