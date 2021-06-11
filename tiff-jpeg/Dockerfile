FROM ubuntu:focal

ENV DEBIAN_FRONTEND=noninteractive


# libvips installs to /usr/local by default .. /usr/local/bin is on the
# default path in ubuntu, but /usr/local/lib is not
ENV LD_LIBRARY_PATH /usr/local/lib

# basic build tools
RUN apt-get update \
  && apt-get install -y \
    build-essential \
    autoconf \
    libtool \
    automake \
    nasm \
    unzip \
    wget \
    git \
    cmake \
    pkg-config 

# for mozjpeg
RUN apt-get install -y \
  zlib1g-dev

WORKDIR /usr/local/src 

ARG MOZJPEG_VERSION=4.0.3
ARG MOZJPEG_URL=https://github.com/mozilla/mozjpeg/archive/refs/tags

RUN wget ${MOZJPEG_URL}/v${MOZJPEG_VERSION}.tar.gz 

RUN tar xzf v${MOZJPEG_VERSION}.tar.gz \
  && cd mozjpeg-${MOZJPEG_VERSION} \
  && mkdir build \
  && cd build \
  && cmake -DPNG_SUPPORTED=0 -DCMAKE_INSTALL_PREFIX=/usr/local .. \
  && make \
  && make install

ENV PKG_CONFIG_PATH /usr/local/lib/pkgconfig

# we need libtiff master, plus two patches from Even, see 
# https://gitlab.com/libtiff/libtiff/-/issues/266

ARG TIFF_VERSION=master
ARG TIFF_URL=https://gitlab.com/libtiff/libtiff.git

RUN git config --global user.email "jcupitt@gmail.com" \
  && git config --global user.name "John Cupitt"

RUN git clone ${TIFF_URL} \
  && cd libtiff \
#  && git pull origin 1a432d0769d9603c555a0b8205c1713115f35233 \
#  && git pull origin 6438425ae911ec97a08b47b87cfac9e5a9b9b047 \
  && ./autogen.sh \
  && ./configure \
  && make \
  && make install

# we must not use any packages which depend directly or indirectly on libjpeg,
# since we want to use our own mozjpeg build 
RUN apt-get install -y \
  libglib2.0-dev \
  libexpat-dev \
  libpng-dev \
  libgif-dev \
  libexif-dev \
  liblcms2-dev \
  liborc-dev 

ARG VIPS_VERSION=8.11.0
ARG VIPS_URL=https://github.com/libvips/libvips/releases/download

RUN wget ${VIPS_URL}/v${VIPS_VERSION}/vips-${VIPS_VERSION}.tar.gz 
RUN tar xzf vips-${VIPS_VERSION}.tar.gz \
  && cd vips-${VIPS_VERSION} \
  && CFLAGS=-g CXXFLAGS=-g ./configure \
  && make V=0 \
  && make install

# the dir we share with the host
WORKDIR /data
