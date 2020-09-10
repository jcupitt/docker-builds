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
git checkout v2.0.0
git submodule update --init

mkdir -p build

cd build

echo configure MIRTK ...
# MIRTK2 mapping needs pointset, and pointset needs vtk
#	-D MODULE_Mapping=ON \
#	-D MODULE_PointSet=ON \
# -D MODULE_Deformable=ON \

cmake \
	-D WITH_VTK=OFF \
	-D WITH_PNG=ON \
	-D WITH_TBB=ON \
	-D MODULE_Deformable=OFF \
	-D MODULE_DrawEM=ON \
 	-D MODULE_Mapping=OFF \
 	-D MODULE_PointSet=OFF \
	-D MODULE_Scripting=ON \
	-D MODULE_Viewer=OFF \
	-D CMAKE_BUILD_TYPE=$BUILD_TYPE \
	-D CMAKE_INSTALL_PREFIX:PATH=$PREFIX ..

echo build MIRTK ...
make -j 8 

echo install MIRTK ...
make install
