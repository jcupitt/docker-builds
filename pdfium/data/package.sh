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
mkdir -p "${TARGET_PDFIUM}/lib/pdfium-obj"
mkdir -p "${TARGET_PDFIUM}/include"

find ${BUILD_RES} -name '*.a' -not -path "**/testing/*" -not -path "**/build/*" -not -name 'libtest_support.a' -exec cp {} ${TARGET_PDFIUM}/lib/pdfium-obj \;

cp public/*.h ${TARGET_PDFIUM}/include

if [ -d ${BUILD_PKG} ]; then
    rm -rf ${BUILD_PKG}
fi

mkdir -p ${BUILD_PKG}

cd ${TARGET_PDFIUM}

tar czf ${BUILD_PKG}/libpdfium-${VERSION_PDFIUM}-${PLATFORM}.tar.gz include lib
