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

# see https://pdfium.googlesource.com/pdfium/

# is_debug = true  # Enable debugging features.
# pdf_use_skia = false  # Set true to enable experimental skia backend.
# pdf_use_skia_paths = false  
# pdf_enable_xfa = true  # Set false to remove XFA support (implies JS support).
# pdf_enable_v8 = true  # Set false to remove Javascript support.
# pdf_is_standalone = true  # Set for a non-embedded build.
# is_component_build = false # Disable component build (must be false)
# clang_use_chrome_plugins = false  # Currently must be false.

gn gen "${BUILD_RES}" --args='pdf_bundle_freetype = true pdf_enable_v8 = false pdf_enable_xfa = false pdf_use_skia = false pdf_use_skia_paths = false is_component_build = false pdf_is_complete_lib = true use_sysroot = false'

ninja -C "${BUILD_RES}"
