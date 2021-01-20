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

# drawem 1.2.1 is used for dhcp release3 and doesn't needs ANTs
# ANTs is a pain to build with vtk9
( cd Packages/DrawEM \
  && echo checking out drawem 121 \
  && git checkout v1.2.1 )

mkdir -p build

cd build

echo configure MIRTK ...
cmake \
	-D WITH_VTK=ON \
  -D DEPENDS_VTK_DIR:PATH=$PREFIX/lib/cmake/vtk-9.0 \
	-D WITH_ITK=ON \
  -D ITK_DIR=$PREFIX/lib/cmake/ITK-5.1 \
	-D WITH_PNG=ON \
	-D WITH_TBB=ON \
	-D MODULE_Deformable=ON \
	-D MODULE_DrawEM=ON \
	-D MODULE_Mapping=ON \
	-D MODULE_PointSet=ON \
	-D MODULE_Scripting=ON \
	-D MODULE_Viewer=ON \
  -D PYTHON_EXECUTABLE=/usr/bin/python3 \
	-D CMAKE_BUILD_TYPE=$BUILD_TYPE \
	-D CMAKE_INSTALL_PREFIX:PATH=$PREFIX \
  ..

echo build MIRTK ...
make -j 8 

echo install MIRTK ...
make install
