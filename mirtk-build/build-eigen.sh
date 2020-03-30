#!/bin/bash

set -e

EIGEN_RELEASE_VERSION=3.3
EIGEN_MICRO_VERSION=7
EIGEN_VERSION=$EIGEN_RELEASE_VERSION.$EIGEN_MICRO_VERSION
EIGEN_URL=https://gitlab.com/libeigen/eigen/-/archive

if [ x$PREFIX == x ]; then
	echo PREFIX not set
	exit 1
fi

if [ ! -f downloads/$EIGEN_VERSION.tar.bz2 ]; then 
	echo download eigen ...
	( cd downloads;  \
	  wget $EIGEN_URL/$EIGEN_VERSION/eigen-$EIGEN_VERSION.tar.bz2 )
fi

if [ ! -d eigen-$EIGEN_VERSION ]; then
	echo unpack eigen ...
	tar xf downloads/eigen-$EIGEN_VERSION.tar.bz2
fi

EIGEN_SOURCE_DIR="$PWD/eigen-$EIGEN_VERSION"
cd $EIGEN_SOURCE_DIR

mkdir -p build

cd build

echo configure eigen ...
cmake \
	-D CMAKE_BUILD_TYPE=$BUILD_TYPE \
	-D CMAKE_INSTALL_PREFIX:PATH=$PREFIX ..

echo build eigen ...
make -j 8 

echo install eigen ...
make install
