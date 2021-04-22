#!/bin/bash

set -e

export FLAGS+=" -Os -fPIC"
export FLAGS+=" -D_GLIBCXX_USE_CXX11_ABI=1 -fno-asynchronous-unwind-tables -ffunction-sections -fdata-sections"

export PLATFORM="linux-x64"
export PACKAGE=/packaging

export PKG_CONFIG_PATH="${PREFIX}/lib64/pkgconfig:${PREFIX}/lib/pkgconfig:${PKG_CONFIG_PATH}"

export PATH="$HOME/.cargo/bin:${PATH}:${PREFIX}/bin"
export CPATH="${PREFIX}/include"
export LIBRARY_PATH="${PREFIX}/lib"
export LD_LIBRARY_PATH="${PREFIX}/lib"
export CFLAGS="${FLAGS}"
export CXXFLAGS="${FLAGS}"
export OBJCFLAGS="${FLAGS}"
export OBJCXXFLAGS="${FLAGS}"
export LDFLAGS="-L${PREFIX}/lib64 -L${PREFIX}/lib  -Wl,--gc-sections -Wl,-rpath='\$\$ORIGIN/'"

export MESON="--cross-file=/packaging/meson.ini"

export MAKEFLAGS="-j$(nproc)"

export CARGO_PROFILE_RELEASE_DEBUG=false
export CARGO_PROFILE_RELEASE_CODEGEN_UNITS=1
export CARGO_PROFILE_RELEASE_INCREMENTAL=false
export CARGO_PROFILE_RELEASE_LTO=true
export CARGO_PROFILE_RELEASE_OPT_LEVEL=z
export CARGO_PROFILE_RELEASE_PANIC=abort

mkdir -p ${PREFIX}/lib/pkgconfig

pushd `dirname $0` > /dev/null
BUILDPATH=`pwd`
popd > /dev/null

build () {
    source "${BUILDPATH}/deps/${1}.sh"
}

# http://www.linuxfromscratch.org/lfs/view/development/chapter06/zlib.html
# Dependencies:
#   - None
# Depended on by:
build zlib

# http://www.linuxfromscratch.org/blfs/view/svn/general/libffi.html
# Dependencies:
#   - None
# Depended on by:
#   - GLib
build ffi

# http://www.linuxfromscratch.org/blfs/view/svn/general/libpng.html
# Dependencies:
#   - None
# Depended on by:
#   - gdk-pixbuf
#   - pixman
#   - cairo
#   - openjpeg
#   - poppler
#   - ghostscript
build libpng

build spng

build imagequant

# http://www.linuxfromscratch.org/blfs/view/svn/general/nasm.html
# Dependencies:
#   - None
# Depended on by:
#   - libjpeg-turbo
#build nasm

# http://www.linuxfromscratch.org/blfs/view/svn/general/libexif.html
# Dependencies:
#   - None
# Depended on by:
#   - php
build exif

# http://www.linuxfromscratch.org/blfs/view/8.0/general/giflib.html
# Dependencies:
#   - None
# Depended on by:
#   - libwebp
build gif

# https://gstreamer.freedesktop.org/projects/orc.html
# Dependencies:
#   - None
# Depended on by:
build orc

# http://www.linuxfromscratch.org/blfs/view/svn/general/icu.html
# Dependencies:
#   - None
# Depended on by:
#   - HarfBuzz
#build icu

# http://www.linuxfromscratch.org/blfs/view/7.5/general/expat.html
# Dependencies:
#   - None
# Depended on by:
build expat

# http://www.linuxfromscratch.org/blfs/view/cvs/general/fftw.html
# Dependencies:
#   - None
# Depended on by:
#   - vips
build fftw3

# http://www.linuxfromscratch.org/blfs/view/svn/general/fribidi.html
# Dependencies:
#   - None
build fribidi

########################################################################################################################
#
# These have dependencies trees to satisfy
#
########################################################################################################################

# http://www.linuxfromscratch.org/blfs/view/svn/general/libxml2.html
# Dependencies:
#   - zlib
#   - icu
# Depended on by:
#   - libxslt
#   - libgsf
#   - fontconfig
#   - croco
build xml2

# http://www.linuxfromscratch.org/blfs/view/cvs/general/swig.html
# Dependencies:
#   - pcre
# Depended on by:
#   - vips
#build swig

# http://www.linuxfromscratch.org/blfs/view/svn/general/pixman.html
# Dependencies:
#   - LibPNG
# Depended on by:
#   - Cairo
build pixman

# http://www.linuxfromscratch.org/blfs/view/svn/general/libjpeg.html
# Dependencies:
#   - nasm
# Depended on by:
#   - gdk-pixbuf
#   - lcms2
#   - poppler
#   - ghostscript
build mozjpeg

# http://www.linuxfromscratch.org/blfs/view/svn/general/libjpeg.html
# Dependencies:
#   - nasm
# Depended on by:
#   - gdk-pixbuf
#   - lcms2
#   - poppler
#   - ghostscript
build jpgturbo

# http://www.linuxfromscratch.org/blfs/view/cvs/general/libtiff.html
# Dependencies:
#   - libjpeg-turbo
# Depended on by:
#   - lcms2
#   - openjpeg
#   - poppler
#   - ghostscript
build tiff

# http://www.linuxfromscratch.org/blfs/view/cvs/general/glib2.html
# Dependencies:
#   - libffi
#   - Python
# Depended on by:
#   - libgsf
#   - gdk-pixbuf
#   - HarfBuzz
#   - Cairo
#   - croco
build glib

# http://www.linuxfromscratch.org/blfs/view/svn/x/gdk-pixbuf.html
# Dependencies:
#   - GLib
#   - libjpeg-turbo
#   - libpng
# Depended on by:
#   - libsrvg
build gdkpixbuf

# http://www.linuxfromscratch.org/blfs/view/svn/general/libgsf.html
# Dependencies:
#   - GLib
#   - libxml2
#   - gdk-pixbuf
# Depended on by:
build gsf

# http://www.linuxfromscratch.org/blfs/view/cvs/general/lcms2.html
# Dependencies:
#   - libjpeg-turbo
#   - libtiff
# Depended on by:
#   - openjpeg
#   - poppler
#   - ghostscript
build lcms2

build aom

build heif

# http://www.linuxfromscratch.org/blfs/view/8.0/general/libwebp.html
# Dependencies:
#   - libjpeg-turbo
#   - libtiff
#   - libpng
#   - giflib
# Depended on by:
build webp

########################################################################################################################
#
#   HarfBuzz wants freetype before it is installed, and freetype wants harfbuz after it is installed. So we do this.
#
########################################################################################################################

# http://www.linuxfromscratch.org/blfs/view/svn/general/freetype2.html
# Dependencies:
#   - None
# Depended on by:
#   - HarfBuzz
build freetype

# http://www.linuxfromscratch.org/blfs/view/svn/general/fontconfig.html
# Dependencies:
#   - Freetype
#   - libxml
# Depended on by:
#   - harfbuzz
#   - Cairo
build fontconfig

# http://www.linuxfromscratch.org/blfs/view/8.0/x/cairo.html
# Dependencies:
#   - libpng
#   - pixman
#   - fontconfig
#   - glib
# Depended on by:
#   - harfbuzz
#   - pango
#   - poppler
#   - ghostscript
build cairo

# http://www.linuxfromscratch.org/blfs/view/svn/general/harfbuzz.html
# Dependencies:
#   - Freetype
# Depended on by:
#   - Freetype
build harfbuzz

# http://www.linuxfromscratch.org/blfs/view/svn/x/pango.html
# Dependencies:
#   - FontConfig
#   - Cairo
# Depended on by:
#   - libsrvg
build pango

# http://www.linuxfromscratch.org/blfs/view/svn/general/libcroco.html
# Dependencies:
#   - GLib
#   - libxml
# Depended on by:
#   - libsrvg
#build croco

# http://www.linuxfromscratch.org/blfs/view/svn/general/librsvg.html
# Dependencies:
#   - gdk-pixbuf
#   - croco
#   - pango
# Depended on by:
build svg

# http://www.linuxfromscratch.org/blfs/view/svn/general/openjpeg.html
# Dependencies:
#   - LCMS
#   - libpng
#   - libtiff
# Depended on by:
#   - poppler
build openjpeg

build pdfium

# http://www.linuxfromscratch.org/blfs/view/cvs/general/poppler.html
# Dependencies:
#   - fontconfig
#   - Cairo
#   - libjpeg
#   - libpng
#   - openjpeg
# Depended on by:
#   - vips
build poppler

# http://www.linuxfromscratch.org/blfs/view/cvs/general/poppler.html
# Dependencies:
#   - freetype
#   - libjpeg
#   - libpng
#   - libtiff
#   - lcms2
#   - cairo
#   - fontconfig
# Depended on by:
#   -
#build ghostscript

# http://www.linuxfromscratch.org/blfs/view/cvs/general/imagemagick.html
# Dependencies:
#   - curl
#   - fttw3
#   - lcms2
#   - libexif
#   - libjpeg-turbo
#   - libpng
#   - librsvg
#   - libtiff
#   - libwebp
#   - openjpeg
#   - pango
#   - ghostscript
# Depended on by:
#   - vips
build imagemagick

# https://github.com/jcupitt/libvips
# Dependencies:
#   - libjpeg
#   - libexif
#   - giflib
#   - librsvg
#   - libpoppler
#   - libgsf-1
#   - libtiff
#   - fftw3
#   - lcms2
#   - libpng
#   - ImageMagick
#   - pango
#   - orc
#   - libwebp
#   - swig
build vips

rm -rf ${PREFIX}/lib/{pkgconfig,.libs,*.la,cmake}

mkdir ${PREFIX}/lib-filtered
mv ${PREFIX}/lib/glib-2.0 ${PREFIX}/lib-filtered

function copydeps {
  local base=$1
  local dest_dir=$2

  cp -L $base $dest_dir/$base
  chmod 644 $dest_dir/$base

  local dependencies=$(readelf -d $base | grep NEEDED | awk '{ print $5 }' | tr -d '[]')

  for dep in $dependencies; do
    base_dep=$(basename $dep)

    [ ! -f "$PWD/$base_dep" ] && echo "$base_dep does not exist in $PWD" && continue
    echo "$base depends on $base_dep"

    if [ ! -f "$dest_dir/$base_dep" ]; then
      copydeps $base_dep $dest_dir
    fi
  done;
}

cd ${PREFIX}/lib
copydeps libvips-cpp.so.42 ${PREFIX}/lib-filtered

cd ${PREFIX}

printf "{\n\
  \"aom\": \"${AOM_VERSION}\",\n\
  \"cairo\": \"${CAIRO_VERSION}\",\n\
  \"exif\": \"${EXIF_VERSION}\",\n\
  \"expat\": \"${EXPAT_VERSION}\",\n\
  \"ffi\": \"${FFI_VERSION}\",\n\
  \"fontconfig\": \"${FONTCONFIG_VERSION}\",\n\
  \"freetype\": \"${FREETYPE_VERSION}\",\n\
  \"fribidi\": \"${FRIBIDI_VERSION}\",\n\
  \"gdkpixbuf\": \"${GDKPIXBUF_VERSION}\",\n\
  \"gettext\": \"${GETTEXT_VERSION}\",\n\
  \"gif\": \"${GIF_VERSION}\",\n\
  \"glib\": \"${GLIB_VERSION}\",\n\
  \"gsf\": \"${GSF_VERSION}\",\n\
  \"harfbuzz\": \"${HARFBUZZ_VERSION}\",\n\
  \"heif\": \"${HEIF_VERSION}\",\n\
  \"imagequant\": \"${IMAGEQUANT_VERSION}\",\n\
  \"lcms\": \"${LCMS2_VERSION}\",\n\
  \"mozjpeg\": \"${MOZJPEG_VERSION}\",\n\
  \"orc\": \"${ORC_VERSION}\",\n\
  \"pango\": \"${PANGO_VERSION}\",\n\
  \"pixman\": \"${PIXMAN_VERSION}\",\n\
  \"png\": \"${PNG16_VERSION}\",\n\
  \"svg\": \"${SVG_VERSION}\",\n\
  \"spng\": \"${SPNG_VERSION}\",\n\
  \"tiff\": \"${TIFF_VERSION}\",\n\
  \"vips\": \"${VIPS_VERSION}\",\n\
  \"webp\": \"${WEBP_VERSION}\",\n\
  \"xml\": \"${XML2_VERSION}\",\n\
  \"zlib-ng\": \"${ZLIB_VERSION}\",\n\
  \"poppler\": \"${POPPLER_VERSION}\",\n\
  \"openjpeg\": \"${OPENJPEG_VERSION}\",\n\
  \"imagemagick\": \"${IMAGEMAGICK_VERSION}\",\n\
  \"pdfium\": \"${PDFIUM_VERSION}\"\n\
}" >versions.json

printf "\"${PLATFORM}\"" >platform.json

ls -al lib
rm -rf lib
mv lib-filtered lib

tar chzf ${PACKAGE}/libvips-${VIPS_VERSION}-${PLATFORM}.tar.gz \
  include \
  lib \
  *.json

advdef --recompress --shrink-insane ${PACKAGE}/libvips-${VIPS_VERSION}-${PLATFORM}.tar.gz
rm -fr ${PACKAGE}/libvips-${VIPS_VERSION}-${PLATFORM}.tar.br
gunzip -c ${PACKAGE}/libvips-${VIPS_VERSION}-${PLATFORM}.tar.gz | brotli -o ${PACKAGE}/libvips-${VIPS_VERSION}-${PLATFORM}.tar.br
chmod 644 ${PACKAGE}/libvips-${VIPS_VERSION}-${PLATFORM}.tar.*
