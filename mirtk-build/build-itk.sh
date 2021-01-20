#!/bin/bash

set -e

ITK_RELEASE_VERSION=5.1
ITK_MICRO_VERSION=2
ITK_VERSION=$ITK_RELEASE_VERSION.$ITK_MICRO_VERSION

ITK_URL=https://github.com/InsightSoftwareConsortium/ITK/releases/download

if [ x$PREFIX == x ]; then
	echo PREFIX not set
	exit 1
fi

if [ ! -f downloads/InsightToolkit-$ITK_VERSION.tar.gz ]; then 
	echo download ITK ...
	( cd downloads; \
	  wget $ITK_URL/v$ITK_VERSION/InsightToolkit-$ITK_VERSION.tar.gz )
fi

if [ ! -d InsightToolkit-$ITK_VERSION ]; then
	echo unpack ITK ...
	tar xf downloads/InsightToolkit-$ITK_VERSION.tar.gz
fi

ITK_SOURCE_DIR="$PWD/InsightToolkit-$ITK_VERSION"
cd $ITK_SOURCE_DIR

mkdir -p build

cd build

echo configure ITK ...
# GenericLabelInterpolator, ITKReview needed by ANTs
cmake \
  -D Module_GenericLabelInterpolator:BOOL=ON \
  -D Module_ITKReview:BOOL=ON \
	-D CMAKE_BUILD_TYPE=$BUILD_TYPE \
	-D CMAKE_INSTALL_PREFIX:PATH=$PREFIX ..

echo build ITK ...
make -j 8 

echo install ITK ...
make install
