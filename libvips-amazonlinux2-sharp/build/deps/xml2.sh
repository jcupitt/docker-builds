export XML2_VERSION=2.9.10

XML2_URL=http://xmlsoft.org/sources

cd /usr/local/src
wget -N ${XML2_URL}/libxml2-${XML2_VERSION}.tar.gz
tar xzf libxml2-${XML2_VERSION}.tar.gz
cd libxml2-${XML2_VERSION}
./configure --host=${CHOST} --prefix=${PREFIX} --enable-static --disable-shared --disable-dependency-tracking \
  --with-minimum --with-reader --with-writer --with-valid --with-http --with-tree --with-regexps \
  --without-python --without-lzma --with-zlib=${PREFIX}
make install-strip