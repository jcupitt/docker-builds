FROM ubuntu:focal

# non-interactive debconf
ENV DEBIAN_FRONTEND=noninteractive

# basic stuff ... we build libvips from git master, so we need more packages
# than just a tarball
RUN apt-get update \
  && apt-get install -y \
    build-essential \
    nasm \
    wget \
    pkg-config 

RUN apt-get update \
  && apt-get install -y 

# build everything to this prefix
ENV PREFIX=/usr/local/vips

ENV PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig \
  LD_LIBRARY_PATH=$PREFIX/lib \
  PATH=$PATH:$PREFIX/bin \
  WORKDIR=/usr/local/src

WORKDIR $WORKDIR

ARG PDFIUM_VERSION=4290 
ARG PDFIUM_URL=https://github.com/bblanchon/pdfium-binaries/releases/download/chromium

RUN mkdir pdfium-$PDFIUM_VERSION \
  && cd pdfium-$PDFIUM_VERSION \
  && wget $PDFIUM_URL/$PDFIUM_VERSION/pdfium-linux.tgz

RUN mkdir -p $PREFIX/lib/pkgconfig \
  && cd $PREFIX \
  && tar xf $WORKDIR/pdfium-$PDFIUM_VERSION/pdfium-linux.tgz \
  && echo "prefix=$PREFIX" >> lib/pkgconfig/pdfium.pc \
  && echo "exec_prefix=\${prefix}" >> lib/pkgconfig/pdfium.pc \
  && echo "libdir=\${exec_prefix}/lib" >> lib/pkgconfig/pdfium.pc \
  && echo "includedir=\${prefix}/include" >> lib/pkgconfig/pdfium.pc \
  && echo "Name: pdfium" >> lib/pkgconfig/pdfium.pc \
  && echo "Description: pdfium" >> lib/pkgconfig/pdfium.pc \
  && echo "Version: $PDFIUM_VERSION" >> lib/pkgconfig/pdfium.pc \
  && echo "Requires: " >> lib/pkgconfig/pdfium.pc \
  && echo "Libs: -L\${libdir} -lpdfium" >> lib/pkgconfig/pdfium.pc \
  && echo "Cflags: -I\${includedir}" >> lib/pkgconfig/pdfium.pc

# stuff we need to build our own libvips ... this is a pretty random selection
# of dependencies, you'll want to adjust these
RUN apt-get install -y \
  # needed by pdfium ... libc++-dev is the clang c++ runtime
  libicu-dev \
  libc++-dev \
  libc++abi-dev \
  # direct libvips deps
  glib-2.0-dev \
  libexpat-dev \
  librsvg2-dev \
  libpng-dev \
  libjpeg-dev \
  libexif-dev \
  liblcms2-dev \
  libheif-dev \
  liborc-dev 

ARG VIPS_VERSION=8.12.2
ARG VIPS_URL=https://github.com/libvips/libvips/releases/download

RUN wget $VIPS_URL/v$VIPS_VERSION/vips-$VIPS_VERSION.tar.gz \
  && tar xf vips-$VIPS_VERSION.tar.gz \
  && cd vips-$VIPS_VERSION \
  && ./configure --prefix $PREFIX \
  && make V=0 \
  && make install

RUN vips -l pdfload_base
