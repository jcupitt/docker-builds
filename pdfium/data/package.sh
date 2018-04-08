#!/usr/bin/env bash

# set -x
set -e

PLATFORM=linux-x64
VERSION_PDFIUM=master

BASE=$(pwd)
BUILD_DIR="${BASE}/build"
PATCH_DIR="${BASE}/patches"
BUILD_PKG="${BASE}/package"

BUILD_RES="out/Release_${PLATFORM}"

TARGET_PDFIUM="${BASE}/target"

cd ${BUILD_DIR}/pdfium

if [ -d ${TARGET_PDFIUM} ]; then
    rm -rf ${TARGET_PDFIUM}
fi

mkdir -p ${TARGET_PDFIUM}
mkdir -p "${TARGET_PDFIUM}/lib"
mkdir -p "${TARGET_PDFIUM}/lib/pdfium-obj"
mkdir -p "${TARGET_PDFIUM}/include"

find ${BUILD_RES} -name '*.a' -not -path "**/testing/*" -not -path "**/build/*" -not -name 'libtest_support.a' -exec cp {} ${TARGET_PDFIUM}/lib/pdfium-obj \;

# there are a couple of shared support libs we need too
cp ${BUILD_RES}/libicuuc.so ${TARGET_PDFIUM}/lib
cp ${BUILD_RES}/libicui18n.so ${TARGET_PDFIUM}/lib
cp ${BUILD_RES}/libc++.so ${TARGET_PDFIUM}/lib

cp public/*.h ${TARGET_PDFIUM}/include

if [ -d ${BUILD_PKG} ]; then
    rm -rf ${BUILD_PKG}
fi

mkdir -p ${BUILD_PKG}

cd ${TARGET_PDFIUM}

tar czf /${BUILD_PKG}/libpdfium-${VERSION_PDFIUM}-${PLATFORM}.tar.gz include lib
