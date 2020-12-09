#!/bin/bash

set -e

if [ x$PREFIX == x ]; then
	echo PREFIX not set
	exit
fi

if [ ! -d MIRTK ]; then 
	git clone https://github.com/BioMedIA/MIRTK.git
fi

MIRTK_SOURCE_DIR="$PWD/MIRTK"
cd $MIRTK_SOURCE_DIR

git pull
git checkout master
git submodule update --init

mkdir -p build

cd build

echo configure MIRTK ...

# libtbb hates being forced to use our libstdc++
#  -D WITH_TBB=ON \
cmake \
	-D WITH_ITK=ON \
	-D WITH_VTK=ON \
	-D WITH_PNG=ON \
	-D WITH_GiftiCLib=ON \
	-D WITH_TBB=OFF \
	-D MODULE_Deformable=ON \
	-D MODULE_DrawEM=ON \
 	-D MODULE_Mapping=ON \
 	-D MODULE_PointSet=ON \
	-D MODULE_Scripting=ON \
	-D MODULE_Viewer=OFF \
	-D CMAKE_BUILD_TYPE=Debug \
	-D CMAKE_INSTALL_PREFIX:PATH=$PREFIX \
  ..

echo build MIRTK ...
# this will fail in drawem in atlas copy, see:
# https://github.com/MIRTK/DrawEM/issues/32
# unzip the atlas by hand and installation will work
make 

echo install MIRTK ...
make install
