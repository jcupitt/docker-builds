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
mkdir -p "${TARGET_PDFIUM}/include"

cp out/Release_linux-x64/libpdfium.so  ${TARGET_PDFIUM}/lib
cp out/Release_linux-x64/libc++.so  ${TARGET_PDFIUM}/lib
cp out/Release_linux-x64/libicuuc.so  ${TARGET_PDFIUM}/lib

cp public/*.h ${TARGET_PDFIUM}/include

if [ -d ${BUILD_PKG} ]; then
    rm -rf ${BUILD_PKG}
fi

mkdir -p ${BUILD_PKG}

cd ${TARGET_PDFIUM}

tar czf ${BUILD_PKG}/libpdfium-${VERSION_PDFIUM}-${PLATFORM}.tar.gz include lib
