export FFI_VERSION=3.3

FFI_URL=https://github.com/libffi/libffi/releases/download/v${FFI_VERSION}

cd /usr/local/src
wget -N ${FFI_URL}/libffi-${FFI_VERSION}.tar.gz
tar xzf libffi-${FFI_VERSION}.tar.gz
cd libffi-${FFI_VERSION}
./configure --host=${CHOST} --prefix=${PREFIX} --enable-static --disable-shared --disable-dependency-tracking \
  --disable-builddir --disable-multi-os-directory --disable-raw-api --disable-structs
make install-strip