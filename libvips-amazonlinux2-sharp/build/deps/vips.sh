VIPS_VERSION=master
VIPS_URL=https://github.com/libvips/libvips.git

cd /usr/local/src
git clone ${VIPS_URL}
cd libvips
git checkout ${VIPS_VERSION}
printf "{\n\
local:\n\
    g_param_spec_types;\n\
};" > vips.map
PKG_CONFIG="pkg-config --static" CFLAGS="${CFLAGS} -O3" CXXFLAGS="${CXXFLAGS} -O3" ./autogen.sh --prefix ${PREFIX} --enable-shared --disable-static --disable-dependency-tracking \
  --disable-debug --disable-deprecated --disable-introspection --without-analyze --without-cfitsio \
  --without-matio --without-nifti --without-OpenEXR \
  --without-openslide --without-ppm --without-radiance
sed -i'.bak' 's|^hardcode_libdir_flag_spec=.*|hardcode_libdir_flag_spec=""|g' libtool
make -C 'libvips' install LDFLAGS="-static $LDFLAGS"
make -C 'cplusplus' install LDFLAGS="$LDFLAGS -Wl,-Bsymbolic-functions -Wl,--version-script=/usr/local/src/libvips/vips.map"