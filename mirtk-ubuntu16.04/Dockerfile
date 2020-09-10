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

COPY build-eigen.sh /usr/local/src/
RUN ./build-eigen.sh 

COPY build-itk.sh /usr/local/src/
RUN ./build-itk.sh 

COPY build-mirtk.sh /usr/local/src/
RUN apt-get install -y libtbb-dev libboost-dev libpng-dev \
	&& ./build-mirtk.sh


