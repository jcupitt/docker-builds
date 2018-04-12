FROM ubuntu:xenial
MAINTAINER John Cupitt <jcupitt@gmail.com>

# install prerequsites
# - FSL
# - build tools

RUN apt-get update 
RUN apt-get install -y apt-utils wget 
RUN wget -O- http://neuro.debian.net/lists/artful.de-m.full | tee /etc/apt/sources.list.d/neurodebian.sources.list 
RUN apt-key adv --recv-keys --keyserver hkp://pool.sks-keyservers.net:80 0xA5D32F012649A5A9 
RUN apt-get update 
RUN apt-get install -y \
	fsl-complete \
	g++-5 git cmake unzip bc python python-contextlib2 \
	libtbb-dev libboost-dev zlib1g-dev libxt-dev libexpat1-dev \
	libgstreamer1.0-dev libqt4-dev

# Create a default, non-root 'build' user ... /data is the version
# subdirectory in this repo
RUN groupadd -r build && useradd -m -g build build
WORKDIR /data
USER build
