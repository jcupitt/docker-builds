export HEIF_VERSION=1.9.1

HEIF_URL=https://github.com/strukturag/libheif/releases/download

cd /usr/local/src
wget -N ${HEIF_URL}/v${HEIF_VERSION}/libheif-${HEIF_VERSION}.tar.gz
tar xzf libheif-${HEIF_VERSION}.tar.gz
cd libheif-${HEIF_VERSION}
./autogen.sh
./configure
make install-strip