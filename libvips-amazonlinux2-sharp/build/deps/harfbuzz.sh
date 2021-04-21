HARFBUZZ_VERSION=2.8.0
HARFBUZZ_URL=https://github.com/harfbuzz/harfbuzz/archive

cd /usr/local/src
wget -N ${HARFBUZZ_URL}/${HARFBUZZ_VERSION}.tar.gz -O harfbuzz-${HARFBUZZ_VERSION}.tar.gz
tar xzf harfbuzz-${HARFBUZZ_VERSION}.tar.gz
cd harfbuzz-${HARFBUZZ_VERSION}
sed -i'.bak' "/subdir('util')/d" meson.build
LDFLAGS=${LDFLAGS/\$/} meson setup _build \
  ${MESON} \
  --default-library=static \
  --buildtype=release \
  --prefix=${PREFIX} \
  -Dgobject=disabled \
  -Dicu=disabled \
  -Dtests=disabled \
  -Dintrospection=disabled \
  -Ddocs=disabled \
  -Dbenchmark=disabled
ninja -C _build
ninja -C _build install
