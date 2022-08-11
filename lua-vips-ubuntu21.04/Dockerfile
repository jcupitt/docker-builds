FROM ubuntu:21.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
  && apt-get install -y \
    build-essential \
    python3-pip \
	ninja-build \
	pkg-config  \
    git

RUN pip3 install meson

WORKDIR /usr/local/src
ARG PREFIX=/usr/local
ENV PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig
ENV LD_LIBRARY_PATH $PREFIX/lib

RUN apt-get install -y \
    glib-2.0-dev \
    libexpat-dev \
    librsvg2-dev \
    libjpeg-dev \
    libexif-dev \
    liblcms2-dev \
    liborc-dev

# the main libimagequant is now gpl3 and we can't use it ... this is a 
# maintained fork of the old BSD-licensed version
ARG IMAGEQUANT_VERSION=main
ARG IMAGEQUANT_URL=https://github.com/lovell/libimagequant

RUN git clone $IMAGEQUANT_URL \
	&& cd libimagequant \
	&& git checkout $IMAGEQUANT_VERSION \
	&& meson build --prefix=${PREFIX} --libdir=lib \
	&& cd build \
	&& ninja \
	&& ninja install

# use libspng for PNG 
ARG SPNG_VERSION=0.7.2
ARG SPNG_URL=https://github.com/randy408/libspng/archive/refs/tags

RUN wget ${SPNG_URL}/v${SPNG_VERSION}.tar.gz \
	&& tar xf v${SPNG_VERSION}.tar.gz \
	&& cd libspng-${SPNG_VERSION} \
	&& meson build --prefix=${PREFIX} --libdir=lib \
	&& cd build \
	&& ninja \
	&& ninja install

# use cgif for GIF write
ARG CGIF_VERSION=0.2.0
ARG CGIF_URL=https://github.com/dloebl/cgif/archive/refs/tags

RUN wget ${CGIF_URL}/V${CGIF_VERSION}.tar.gz \
	&& tar xf V${CGIF_VERSION}.tar.gz \
	&& cd cgif-${CGIF_VERSION} \
	&& meson build --prefix=${PREFIX} --libdir=lib \
	&& cd build \
	&& ninja \
	&& ninja install

ARG VIPS_VERSION=8.13.0
ARG VIPS_URL=https://github.com/libvips/libvips/archive/refs/tags

RUN wget ${VIPS_URL}/V${VIPS_VERSION}.tar.gz \
	&& tar xf V${VIPS_VERSION}.tar.gz \
	&& cd vips-${VIPS_VERSION} \
    && meson build --prefix=${PREFIX} --libdir=lib \
    && cd build \
    && ninja \
    && ninja install

