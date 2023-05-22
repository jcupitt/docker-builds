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
    python3-pip \
    ninja-build \
    build-essential \
    nasm \
    cmake \
    unzip \
    wget \
    git \
    pkg-config 

# libvips need meson 0.55 or newer, focal ships 0.53.2
RUN pip3 install meson 

ARG MOZJPEG_VERSION=4.1.1
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

ARG VIPS_VERSION=8.14.2
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
  && meson setup build --libdir=lib --buildtype release -Dintrospection=false \
  && cd build \
  && ninja \
  && ninja install

WORKDIR /data
ENTRYPOINT ["/usr/local/bin/vipsthumbnail"]
CMD ["--help"]
