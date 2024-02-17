FROM ubuntu:23.10

ENV DEBIAN_FRONTEND=noninteractive

# libvips installs to /usr/local by default .. /usr/local/bin is on the
# default path in ubuntu, but /usr/local/lib is not
ENV LD_LIBRARY_PATH /usr/local/lib

WORKDIR /usr/local/src

# basic build tools
RUN apt-get update \
  && apt-get install -y \
    python3-pip \
    meson \
    ninja-build \
    build-essential \
    nasm \
    cmake \
    unzip \
    wget \
    git \
    pkg-config 

ARG MOZJPEG_VERSION=4.1.1
ARG MOZJPEG_URL=https://github.com/mozilla/mozjpeg/archive

# needed by mozjpeg
RUN apt-get install -y \
  libpng-dev \
  zlib1g-dev

RUN wget ${MOZJPEG_URL}/v${MOZJPEG_VERSION}.tar.gz \
  && tar xf v${MOZJPEG_VERSION}.tar.gz 

# mozjpeg installs to /opt/mozjpeg by default
RUN cd mozjpeg-${MOZJPEG_VERSION} \
  && mkdir build \
  && cd build \
  && cmake -DCMAKE_INSTALL_PREFIX=/usr/local .. \
  && make \
  && make install

# we need our own libtiff, since the system one won't be using mozjpeg
ARG LIBTIFF_VERSION=4.6.0
ARG LIBTIFF_URL=http://download.osgeo.org/libtiff
RUN wget ${LIBTIFF_URL}/tiff-${LIBTIFF_VERSION}.tar.xz \
  && tar xf tiff-${LIBTIFF_VERSION}.tar.xz

RUN cd tiff-4.6.0/build \
  && cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local -G Ninja \
  && ninja \
  && ninja install

ARG VIPS_VERSION=8.15.1
ARG VIPS_URL=https://github.com/libvips/libvips/releases/download

# we must not use any packages which depend directly or indirectly on libjpeg,
# since we want to use our own mozjpeg build 
# if you need eg. imagemagick, you'll need to build it from source
RUN apt-get install -y \
  libglib2.0-dev \
  libexpat-dev \
  libpng-dev \
  libexif-dev \
  liblcms2-dev \
  liborc-dev 

RUN wget ${VIPS_URL}/v${VIPS_VERSION}/vips-${VIPS_VERSION}.tar.xz 

# libvips is marked up for auto-vectorisation ... -O3 is the optimisation
# level that enables this for gcc
RUN tar xf vips-${VIPS_VERSION}.tar.xz \
  && cd vips-${VIPS_VERSION} \
  && meson setup build --libdir=lib -Dintrospection=disabled \
  && cd build \
  && ninja \
  && ninja install

WORKDIR /data
