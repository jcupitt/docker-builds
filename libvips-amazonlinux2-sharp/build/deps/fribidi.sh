export FRIBIDI_VERSION=1.0.9

FRIBIDI_URL=https://github.com/fribidi/fribidi/releases/download/v${FRIBIDI_VERSION}

cd /usr/local/src
wget -N ${FRIBIDI_URL}/fribidi-${FRIBIDI_VERSION}.tar.xz
tar Jxf fribidi-${FRIBIDI_VERSION}.tar.xz
cd fribidi-${FRIBIDI_VERSION}
sed -i'.bak' "/subdir('test')/d" meson.build
LDFLAGS=${LDFLAGS/\$/} meson setup _build \
  ${MESON} \
  --default-library=static \
  --buildtype=release \
  --prefix=${PREFIX} \
  -Ddocs=false
ninja -C _build
ninja -C _build install