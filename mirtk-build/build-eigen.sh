#!/bin/bash

EIGEN_RELEASE_VERSION=3.3
EIGEN_MICRO_VERSION=4
EIGEN_VERSION=$EIGEN_RELEASE_VERSION.$EIGEN_MICRO_VERSION
EIGEN_URL=http://bitbucket.org/eigen/eigen/get/$EIGEN_VERSION.tar.bz2

if [ x$PREFIX == x ]; then
	echo PREFIX not set
	exit 1
fi

if [ ! -f downloads/$EIGEN_VERSION.tar.bz2 ]; then 
	echo download eigen ...
	(cd downloads; wget $EIGEN_URL/$EIGEN_VERSION.tar.bz2)
	if [ ! $? ]; then
		echo failed
		exit 1
	fi
fi

if [ ! -d eigen-$EIGEN_VERSION ]; then
	echo unpack eigen ...
	tar xf downloads/$EIGEN_VERSION.tar.bz2
	# rename to something sensible
	mv eigen* eigen-$EIGEN_VERSION
fi

EIGEN_SOURCE_DIR="$PWD/eigen-$EIGEN_VERSION"
cd $EIGEN_SOURCE_DIR

mkdir -p build

cd build

echo configure eigen ...
cmake \
	-D CMAKE_BUILD_TYPE=Release \
	-D CMAKE_INSTALL_PREFIX:PATH=$PREFIX ..
if [ ! $? ]; then
	echo failed
	exit 1
fi

echo build eigen ...
make -j 8 
if [ ! $? ]; then
	echo failed
	exit 1
fi

echo install eigen ...
make install
if [ ! $? ]; then
	echo failed
	exit 1
fi
