#!/bin/bash

set -e

ANTS_RELEASE_VERSION=2.3
ANTS_MICRO_VERSION=5
ANTS_VERSION=$ANTS_RELEASE_VERSION.$ANTS_MICRO_VERSION

ANTS_URL=https://github.com/ANTsX/ANTs/archive

if [ x$PREFIX == x ]; then
	echo PREFIX not set
	exit 1
fi

if [ ! -f downloads/ants-$ANTS_VERSION.tar.gz ]; then 
	echo download ANTs ...
	( cd downloads; \
	  wget $ANTS_URL/v$ANTS_VERSION.tar.gz;
    mv v$ANTS_VERSION.tar.gz ANTs-$ANTS_VERSION.tar.gz )
fi

if [ ! -d ANTs-$ANTS_VERSION ]; then
	echo unpack ANTs ...
	tar xf downloads/ANTs-$ANTS_VERSION.tar.gz
fi

ANTS_SOURCE_DIR="$PWD/ANTs-$ANTS_VERSION"
cd $ANTS_SOURCE_DIR

mkdir -p build

cd build

echo configure ANTs ...
cmake \
	-D USE_VTK=ON \
	-D USE_SYSTEM_VTK=ON \
	-D VTK_DIR=$PREFIX/lib/cmake/vtk-9.0 \
	-D USE_SYSTEM_ITK=ON \
	-D ITK_DIR=$PREFIX/lib/cmake/ITK-5.1 \
	-D CMAKE_BUILD_TYPE=$BUILD_TYPE \
	-D CMAKE_INSTALL_PREFIX:PATH=$PREFIX ..

echo build ANTs ...
make -j 8 

echo install ANTs ...
make install
