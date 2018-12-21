FROM ubuntu:cosmic

# basic build tools
RUN apt-get update \
  && apt-get install -y \
    build-essential \
    autoconf \
    automake \
    libtool \
    nasm \
    unzip \
    wget \
    git \
    pkg-config 

ARG MOZJPEG_VERSION=3.3.1
ARG MOZJPEG_URL=https://github.com/mozilla/mozjpeg/archive

RUN cd /usr/local/src \
  && wget ${MOZJPEG_URL}/v${MOZJPEG_VERSION}.tar.gz \
  && tar xzf v${MOZJPEG_VERSION}.tar.gz 

RUN cd /usr/local/src/mozjpeg-${MOZJPEG_VERSION} \
  && aclocal \
  && autoconf \
  && autoheader \
  && libtoolize \
  && automake --add-missing \
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

ARG VIPS_VERSION=8.7.2
ARG VIPS_URL=https://github.com/libvips/libvips/releases/download

RUN cd /usr/local/src \
  && wget ${VIPS_URL}/v${VIPS_VERSION}/vips-${VIPS_VERSION}.tar.gz \
  && tar xzf vips-${VIPS_VERSION}.tar.gz 

# we must tell libvips to build against the libjpeg in /opt/mozjpeg
RUN cd /usr/local/src/vips-${VIPS_VERSION} \
  && export PKG_CONFIG_PATH=/opt/mozjpeg/lib64/pkgconfig:$PKG_CONFIG_PATH \
  && ./configure \
  && make \
  && make install



