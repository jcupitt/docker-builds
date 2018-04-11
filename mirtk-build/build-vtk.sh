#!/bin/bash

set -e

VTK_RELEASE_VERSION=8.1
VTK_MICRO_VERSION=0
VTK_VERSION=$VTK_RELEASE_VERSION.$VTK_MICRO_VERSION
VTK_URL=https://www.vtk.org/files/release/$VTK_RELEASE_VERSION

if [ x$PREFIX == x ]; then
	echo PREFIX not set
	exit 1
fi

if [ ! -f downloads/VTK-$VTK_VERSION.tar.gz ]; then 
	echo download VTK ...
	(cd downloads; wget $VTK_URL/VTK-$VTK_VERSION.tar.gz)
fi

if [ ! -d VTK-$VTK_VERSION ]; then
	echo unpack VTK ...
	tar xf downloads/VTK-$VTK_VERSION.tar.gz
fi

VTK_SOURCE_DIR="$PWD/VTK-$VTK_VERSION"
cd $VTK_SOURCE_DIR

mkdir -p build

cd build

echo configure VTK ...
cmake \
	-D CMAKE_BUILD_TYPE=$BUILD_TYPE \
	-D CMAKE_INSTALL_PREFIX:PATH=$PREFIX ..

echo build VTK ...
make -j 8 

echo install VTK ...
make install
