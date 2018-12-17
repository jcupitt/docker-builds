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

# version of 11 dec 2018 that seems to build OK
# git fetch origin 407a081da693b7ed877e85be24c3eac9fe831315
# git fetch origin 1ccf890a09a33b8e49d92f8f8f565645be82fb6b
# git fetch origin 385bf2e0481230b1f5e50a2627063383bd297451

# Change pdfium library from static to shared
sed -i.bak 's/^jumbo_static_library("pdfium")/jumbo_component("pdfium")/' BUILD.gn

# Fix symbol visibility – files are built with -fvisiblity=hidden
sed -i.bak 's/^#define FPDF_EXPORT$/#define FPDF_EXPORT  __attribute__((visibility("default")))/' public/fpdfview.h

# # git master pdfium built with gcc has several warnings
# treat_warnings_as_errors = false 
# is_debug = false 
# pdf_enable_v8 = false 
# pdf_enable_xfa = false 
# pdf_use_skia = false 
# pdf_use_skia_paths = false 
# pdf_is_standalone = true 
# is_component_build = false 
# clang_use_chrome_plugins = false 
# # build with gcc ... makes linking simpler
# is_clang = false 
# # don't use c++14 features
# use_cxx11 = true

# for some reason we only get a static library out of it :( I'm sure this used
# to work

gn gen "${BUILD_RES}" --args='treat_warnings_as_errors = false is_debug = false pdf_enable_v8 = false pdf_enable_xfa = false pdf_use_skia = false pdf_use_skia_paths = false pdf_is_standalone = true is_component_build = false clang_use_chrome_plugins = false is_clang = false use_cxx11 = true'

ninja -C "${BUILD_RES}"
