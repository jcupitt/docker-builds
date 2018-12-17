#!/bin/bash

# set -x
set -e

. config.sh

cd ${BUILD_DIR}/pdfium

if [ -d ${TARGET_PDFIUM} ]; then
    rm -rf ${TARGET_PDFIUM}
fi

mkdir -p ${TARGET_PDFIUM}
mkdir -p "${TARGET_PDFIUM}/lib"
mkdir -p "${TARGET_PDFIUM}/lib/pkgconfig"
mkdir -p "${TARGET_PDFIUM}/include/pdfium"

# libpdfium is built as a thin archive, so it only contains paths to the
# objects ... repack as a full static library
base=out/Release_linux-x64/obj
llvm-ar -t $base/libpdfium.a | \
  xargs ar rvs ${TARGET_PDFIUM}/lib/libpdfium.a

cp public/*.h ${TARGET_PDFIUM}/include/pdfium

cp ../../libpdfium.pc.in /tmp/libpdfium.pc
# ahem not a real version number
sed -i.bak 's/@VERSION@/1.0/' /tmp/libpdfium.pc
cp /tmp/libpdfium.pc ${TARGET_PDFIUM}/lib/pkgconfig

if [ -d ${BUILD_PKG} ]; then
    rm -rf ${BUILD_PKG}
fi

mkdir -p ${BUILD_PKG}

cd ${TARGET_PDFIUM}

tar czf ${BUILD_PKG}/libpdfium-${VERSION_PDFIUM}-${PLATFORM}.tar.gz include lib
