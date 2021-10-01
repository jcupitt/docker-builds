export AOM_VERSION=3.0.0

AOM_URL=https://storage.googleapis.com/aom-releases

cd /usr/local/src
mkdir -p libaom-${AOM_VERSION}
wget -N ${AOM_URL}/libaom-${AOM_VERSION}.tar.gz
tar xzf libaom-${AOM_VERSION}.tar.gz -C /usr/local/src/libaom-${AOM_VERSION}
cd libaom-${AOM_VERSION}
mkdir -p aom_build
cd aom_build
AOM_AS_FLAGS="${FLAGS}" LDFLAGS=${LDFLAGS/\$/} cmake -G"Unix Makefiles" \
  -DCMAKE_TOOLCHAIN_FILE=/packaging/Toolchain.cmake -DCMAKE_INSTALL_PREFIX=${PREFIX} -DCMAKE_INSTALL_LIBDIR=lib \
  -DBUILD_SHARED_LIBS=FALSE -DENABLE_DOCS=0 -DENABLE_TESTS=0 -DENABLE_TESTDATA=0 -DENABLE_TOOLS=0 -DENABLE_EXAMPLES=0 \
  -DCONFIG_PIC=1 -DENABLE_NASM=1 \
  -DCONFIG_AV1_HIGHBITDEPTH=0 -DCONFIG_WEBM_IO=0 \
  ..
make install/strip