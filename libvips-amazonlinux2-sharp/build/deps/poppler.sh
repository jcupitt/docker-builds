export POPPLER_VERSION=21.04.0

POPPLER_URL=https://poppler.freedesktop.org

cd /usr/local/src
wget -N ${POPPLER_URL}/poppler-${POPPLER_VERSION}.tar.xz
tar Jxf poppler-${POPPLER_VERSION}.tar.xz
cd poppler-${POPPLER_VERSION}
sed -i'.bak' '/.*pdf-fullrewrite[ _].*/d' test/CMakeLists.txt
mkdir -p build
cd build
LDFLAGS=${LDFLAGS/\$/} cmake .. \
  -DCMAKE_TOOLCHAIN_FILE=/packaging/Toolchain.cmake -DCMAKE_INSTALL_PREFIX=${PREFIX} -DCMAKE_INSTALL_LIBDIR=${PREFIX}/lib \
  -DBUILD_GTK_TESTS=OFF -DBUILD_QT5_TESTS=OFF -DBUILD_QT6_TESTS=OFF -DBUILD_CPP_TESTS=OFF -DENABLE_SPLASH=OFF -DENABLE_UTILS=OFF \
  -DENABLE_CPP=OFF -DENABLE_GTK_DOC=OFF -DENABLE_QT5=OFF -DENABLE_QT6=OFF -DBUILD_SHARED_LIBS=OFF -DCMAKE_BUILD_TYPE=release
sed -i'.bak' '/-lpoppler/i Requires.private: libopenjp2' ../poppler.pc.cmake
make install/strip
