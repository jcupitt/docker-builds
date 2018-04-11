#!/bin/bash

if [ x$PREFIX == x ]; then
	echo PREFIX not set
	exit
fi

if [ ! -d MIRTK ]; then 
	git clone https://github.com/BioMedIA/MIRTK.git
fi

MIRTK_SOURCE_DIR="$PWD/MIRTK"
cd $MIRTK_SOURCE_DIR

git submodule update --init

mkdir -p build

cd build

echo configure MIRTK ...
cmake \
	-D WITH_VTK=ON \
	-D MODULE_Deformable=ON \
	-D MODULE_DrawEM=ON \
	-D MODULE_Mapping=ON \
	-D MODULE_PointSet=ON \
	-D MODULE_Scripting=ON \
	-D CMAKE_BUILD_TYPE=Release \
	-D DEPENDS_VTK_DIR:PATH=$PREFIX/lib/cmake/vtk-9.0 \
	-D CMAKE_INSTALL_PREFIX:PATH=$PREFIX ..
if [ ! $? ]; then
	echo failed
	exit 1
fi

echo build MIRTK ...
make -j 8 
if [ ! $? ]; then
	echo failed
	exit 1
fi

echo install MIRTK ...
make install
if [ ! $? ]; then
	echo failed
	exit 1
fi
