#!/bin/bash

PLATFORM=linux-x64
LIBNAME="libpdfium-dev"
VERSION_PDFIUM=master

git=$(which git)

BASE=$(pwd)
BUILD_DIR="${BASE}/build"
PATCH_DIR="${BASE}/patches"
BUILD_PKG="${BASE}/package"

BUILD_RES="out/Release_${PLATFORM}"

TARGET_PDFIUM="${BASE}/target"
