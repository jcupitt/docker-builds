FROM ubuntu:xenial

RUN apt-get update && apt-get install -y \
	build-essential \
	unzip \
	wget \
	git \
	python \
	libssl-dev \
	pkg-config 

WORKDIR /usr/local/src

# ITK5 needs cmake 3.10+, xenial comes with 3.5
ENV CMAKE_VERSION 3.18.2
ENV CMAKE_URL https://github.com/Kitware/CMake/releases/download

RUN wget ${CMAKE_URL}/v$CMAKE_VERSION/cmake-$CMAKE_VERSION.tar.gz \
	&& tar xf cmake-${CMAKE_VERSION}.tar.gz \
	&& cd cmake-${CMAKE_VERSION} \
	&& ./configure \
	&& make V=0 \
	&& make install

ENV PREFIX /usr/local/mirtk
ENV BUILD_TYPE Release
# ENV BUILD_TYPE Debug
ENV MIRTK_ROOT $PREFIX
ENV PATH "$MIRTK_ROOT/bin:$PATH"
ENV LD_LIBRARY_PATH "$MIRTK_ROOT/lib:$LD_LIBRARY_PATH"
ENV PKG_CONFIG_PATH "$MIRTK_ROOT/lib/pkgconfig:$PKG_CONFIG_PATH"

# many imperial machines are missing libpng12.so.0
ARG PNG_VERSION=1.6.37
ARG PNG_URL=http://prdownloads.sourceforge.net/libpng

RUN wget ${PNG_URL}/libpng-${PNG_VERSION}.tar.gz?download -O libpng-${PNG_VERSION}.tar.gz \
	&& tar xf libpng-${PNG_VERSION}.tar.gz \
	&& cd libpng-${PNG_VERSION} \
	&& ./configure --prefix=${PREFIX} \
	&& make \
	&& make install

COPY build-eigen.sh /usr/local/src/
RUN ./build-eigen.sh 

COPY build-itk.sh /usr/local/src/
RUN ./build-itk.sh 

COPY build-mirtk.sh /usr/local/src/
RUN apt-get install -y libtbb-dev libboost-dev \
	&& ./build-mirtk.sh

# we need libstc++ in our libs as well, since many condor machines are
# missing the correct version, frustratingly
RUN cp /usr/lib/x86_64-linux-gnu/libstdc++* $PREFIX/lib

# workbench

RUN apt-get install -y \
	wget g++-5 git cmake unzip bc python python-contextlib2 \
	libtbb-dev libboost-dev zlib1g-dev libxt-dev libexpat1-dev \
	libgstreamer1.0-dev libqt4-dev dc libquazip5-dev libfreetype6-dev

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
