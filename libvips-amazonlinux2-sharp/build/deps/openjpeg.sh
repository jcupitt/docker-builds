export OPENJPEG_VERSION=2.4.0

OPENJPEG_URL=https://github.com/uclouvain/openjpeg/archive/refs/tags

cd /usr/local/src
wget -N ${OPENJPEG_URL}/v${OPENJPEG_VERSION}.tar.gz -O openjpeg-${OPENJPEG_VERSION}.tar.gz
tar xzf openjpeg-${OPENJPEG_VERSION}.tar.gz
cd openjpeg-${OPENJPEG_VERSION}
mkdir -p build
cd build
LDFLAGS=${LDFLAGS/\$/} cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=${PREFIX} \
  -DCMAKE_TOOLCHAIN_FILE=/packaging/Toolchain.cmake -DBUILD_SHARED_LIBS=OFF -DBUILD_CODEC=OFF
make install/strip