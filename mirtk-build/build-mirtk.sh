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
# git checkout v2.0.0
# git checkout revise-registration-cfg
git submodule update --init

mkdir -p build

cd build

echo configure MIRTK ...
cmake \
	-D WITH_VTK=ON \
	-D WITH_PNG=ON \
	-D WITH_TBB=ON \
	-D MODULE_Deformable=ON \
	-D MODULE_DrawEM=ON \
	-D MODULE_Mapping=ON \
	-D MODULE_PointSet=ON \
	-D MODULE_Scripting=ON \
	-D MODULE_Viewer=ON \
  -D DEPENDS_VTK_DIR:PATH=$PREFIX/lib/cmake/vtk-8.1 \
	-D CMAKE_BUILD_TYPE=$BUILD_TYPE \
	-D CMAKE_INSTALL_PREFIX:PATH=$PREFIX \
  ..

echo build MIRTK ...
make -j 8 

echo install MIRTK ...
make install
