#!/bin/bash

export PREFIX=~/mirtk
# export BUILD_TYPE=Debug
export BUILD_TYPE=Release

export MIRTK_ROOT=$PREFIX
export PATH="$MIRTK_ROOT/bin:$PATH"
export LD_LIBRARY_PATH="$MIRTK_ROOT/lib:$LD_LIBRARY_PATH"

mkdir -p downloads

./build-eigen.sh \
  && ./build-vtk.sh \
	&& ./build-mirtk.sh
