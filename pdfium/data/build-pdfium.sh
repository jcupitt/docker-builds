#!/bin/bash

# set -x
set -e

. config.sh

mkdir -p ${BUILD_DIR}
cd ${BUILD_DIR}

DEPOT_TOOLS="${BUILD_DIR}/depot_tools"

if [ ! -d "${DEPOT_TOOLS}" ]; then
    ${git} clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
fi

export PATH="${DEPOT_TOOLS}":"$PATH"

gclient config --unmanaged https://pdfium.googlesource.com/pdfium.git
gclient sync --no-history

cd pdfium

# Change pdfium library from static to shared
sed -i.bak 's/^jumbo_static_library("pdfium")/jumbo_component("pdfium")/' BUILD.gn

# Fix symbol visibility – files are built with -fvisiblity=hidden
sed -i.bak 's/^#define FPDF_EXPORT$/#define FPDF_EXPORT  __attribute__((visibility("default")))/' public/fpdfview.h

# see https://pdfium.googlesource.com/pdfium/
# and https://github.com/lukas-w/pdfium-build/blob/master/args.gn.linux

gn gen "${BUILD_RES}" --args='treat_warnings_as_errors = false is_debug = false pdf_enable_v8 = false pdf_enable_xfa = false pdf_use_skia = false pdf_use_skia_paths = false pdf_is_standalone = true is_component_build = false clang_use_chrome_plugins = false is_clang = false use_cxx11 = true'

ninja -C "${BUILD_RES}"
