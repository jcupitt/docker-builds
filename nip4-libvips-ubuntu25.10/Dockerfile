FROM ubuntu:25.10

ENV DEBIAN_FRONTEND=noninteractive

# libvips installs to /usr/local by default .. /usr/local/bin is on the
# default path in ubuntu, but /usr/local/lib is not
ENV LD_LIBRARY_PATH=/usr/local/lib

WORKDIR /usr/local/src

# build tools
RUN apt-get update \
  && apt-get install -y \
    meson \
    ninja-build \
    build-essential \
    wget \
    git \
    pkg-config 

ARG VIPS_VERSION=8.18.0
ARG VIPS_URL=https://github.com/libvips/libvips/releases/download

# just a few dependencies, you'll probably want more
RUN apt-get install -y \
  libglib2.0-dev \
  libexpat-dev \
  libpng-dev \
  libexif-dev \
  liblcms2-dev 

RUN wget ${VIPS_URL}/v${VIPS_VERSION}/vips-${VIPS_VERSION}.tar.xz 

RUN tar xf vips-${VIPS_VERSION}.tar.xz \
  && cd vips-${VIPS_VERSION} \
  && meson setup build --libdir=lib -Dintrospection=disabled \
  && cd build \
  && meson compile \
  && meson install

# you might need an ldconfig if you build a libvips dependency immediately
# after installing it

ARG NIP4_VERSION=9.0.17
ARG NIP4_URL=https://github.com/libvips/nip4/releases/download

# nip4 build requirements
RUN apt-get install -y \
  flex \
  bison 

# nip4 runtime requirements
RUN apt-get install -y \
  libgtk-4-dev \
  libxml2-dev \
  libgsl-dev

RUN wget ${NIP4_URL}/v${NIP4_VERSION}/nip4-${NIP4_VERSION}.tar.xz 

RUN tar xf nip4-${NIP4_VERSION}.tar.xz \
  && cd nip4-${NIP4_VERSION} \
  && meson setup build \
  && cd build \
  && meson compile \
  && meson install

WORKDIR /data
