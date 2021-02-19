## Build for the Imperial Ubuntu image (16.04)

FROM ubuntu:xenial
MAINTAINER John Cupitt <jcupitt@gmail.com>
LABEL Description="HCP Workbench on Ubuntu 16.04" Vendor="BioMedIA"

RUN apt-get update --fix-missing
RUN apt-get install -y \
	wget g++-5 git cmake unzip bc python python-contextlib2 \
	libtbb-dev libboost-dev zlib1g-dev libxt-dev libexpat1-dev \
	libgstreamer1.0-dev libqt4-dev dc libquazip5-dev libfreetype6-dev

WORKDIR /usr/src

RUN git clone https://github.com/Washington-University/workbench.git

RUN cd workbench \
	&& git reset --hard v1.2.3 \
	&& rm -rf build \
	&& mkdir build \
	&& cd build \
	&& cmake -DCMAKE_CXX_STANDARD=11 -DCMAKE_CXX_STANDARD_REQUIRED=ON \
		-DCMAKE_CXX_EXTENSIONS=OFF \
		-DCMAKE_CXX_FLAGS="-std=c++11 -Wno-c++11-narrowing" \
		-DCMAKE_INSTALL_PREFIX=/usr/local/workbench \
		../src

RUN cd workbench/build \
	&& make \
	&& make install

	

