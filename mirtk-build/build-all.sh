#!/bin/bash

export PREFIX=$HOME/mirtk
# export BUILD_TYPE=Debug
# export BUILD_TYPE=Release
export BUILD_TYPE=Debug

export MIRTK_ROOT=$PREFIX
export PATH="$MIRTK_ROOT/bin:$PATH"
export LD_LIBRARY_PATH="$MIRTK_ROOT/lib:$LD_LIBRARY_PATH"

mkdir -p downloads

# git master drawem needs ants
#        && ./build-ants.sh \
# but ANTs is hard to build with vtk9
# stick with an earlier drawem for now (swee build-mirtk.sh)

./build-eigen.sh \
        && ./build-itk.sh \
        && ./build-vtk.sh \
        && ./build-mirtk.sh
