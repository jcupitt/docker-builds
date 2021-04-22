export IMAGEQUANT_VERSION=2.4.1

IMAGEQUANT_URL=https://github.com/lovell/libimagequant/archive

cd /usr/local/src
wget -N ${IMAGEQUANT_URL}/v${IMAGEQUANT_VERSION}.tar.gz -O libimagequant-${IMAGEQUANT_VERSION}.tar.gz
tar xzf libimagequant-${IMAGEQUANT_VERSION}.tar.gz
cd libimagequant-${IMAGEQUANT_VERSION}
CFLAGS="${CFLAGS} -O3" meson setup _build --default-library=static --buildtype=release --strip --prefix=${PREFIX} ${MESON}
ninja -C _build
ninja -C _build install