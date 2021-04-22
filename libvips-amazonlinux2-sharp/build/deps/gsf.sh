export GSF_VERSION=1.14.47

GSF_URL=https://download.gnome.org/sources/libgsf/${GSF_VERSION%.[[:digit:]]*}

cd /usr/local/src
wget -N ${GSF_URL}/libgsf-${GSF_VERSION}.tar.xz
tar Jxf libgsf-${GSF_VERSION}.tar.xz
cd libgsf-${GSF_VERSION}
sed -i'.bak' "s/ doc tools tests thumbnailer python//" Makefile.in
./configure --host=${CHOST} --prefix=${PREFIX} --enable-static --disable-shared --disable-dependency-tracking \
  --without-bz2 --without-gdk-pixbuf --with-zlib=${PREFIX}
make install-strip