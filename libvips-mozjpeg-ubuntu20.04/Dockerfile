FROM ubuntu:focal

ENV DEBIAN_FRONTEND=noninteractive

# mozjpeg installs to /opt/mozjpeg ... we need that on PKG_CONFIG_PATH so
# that libvips configure can find it
ENV PKG_CONFIG_PATH /opt/mozjpeg/lib64/pkgconfig

# libvips installs to /usr/local by default .. /usr/local/bin is on the
# default path in ubuntu, but /usr/local/lib is not
ENV LD_LIBRARY_PATH /usr/local/lib

WORKDIR /usr/local/src

# basic build tools
RUN apt-get update \
  && apt-get install -y \
    build-essential \
    nasm \
    cmake \
    unzip \
    wget \
    git \
    pkg-config 

ARG MOZJPEG_VERSION=4.0.3
ARG MOZJPEG_URL=https://github.com/mozilla/mozjpeg/archive

# needed by mozjpeg
RUN apt-get install -y \
  libpng-dev \
  zlib1g-dev

RUN wget ${MOZJPEG_URL}/v${MOZJPEG_VERSION}.tar.gz \
  && tar xzf v${MOZJPEG_VERSION}.tar.gz 

# mozjpeg installs to /opt/mozjpeg by default
RUN cd mozjpeg-${MOZJPEG_VERSION} \
  && mkdir build \
  && cd build \
  && cmake -DCMAKE_INSTALL_PREFIX=/usr/local .. \
  && make \
  && make install

ARG VIPS_VERSION=8.11.0
ARG VIPS_URL=https://github.com/libvips/libvips/releases/download

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

RUN cd /usr/local/src \
  && wget ${VIPS_URL}/v${VIPS_VERSION}/vips-${VIPS_VERSION}.tar.gz \
  && tar xzf vips-${VIPS_VERSION}.tar.gz 

# libvips is marked up for auto-vectorisation ... -O3 is the optimisation
# level that enables this for gcc
RUN cd /usr/local/src/vips-${VIPS_VERSION} \
  && CFLAGS=-O3 CXXFLAGS=-O3 ./configure \
  && make V=0 \
  && make install

WORKDIR /data
ENTRYPOINT ["/usr/local/bin/vipsthumbnail"]
CMD ["--help"]
