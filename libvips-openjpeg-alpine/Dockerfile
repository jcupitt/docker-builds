FROM alpine:latest

RUN apk update && apk upgrade

RUN apk add build-base \
	cmake \
	autoconf \
	automake \
	libtool \
	bc \
	zlib-dev \
	libxml2-dev \
	jpeg-dev \
	tiff-dev \
	glib-dev \
	gdk-pixbuf-dev \
	sqlite-dev \
	libjpeg-turbo-dev \
	libexif-dev \
	lcms2-dev \
	fftw-dev \
	giflib-dev \
	libpng-dev \
	libwebp-dev \
	orc-dev \
	poppler-dev \
	librsvg-dev \
	libgsf-dev \
	openexr-dev \
	gtk-doc

WORKDIR /usr/local/src

# build latest openjpeg .. alpine has 2.3.0-r3

ARG OPENJPEG_VERSION=2.3.1
ARG OPENJPEG_URL=https://github.com/uclouvain/openjpeg/archive

RUN wget ${OPENJPEG_URL}/v${OPENJPEG_VERSION}.tar.gz \
	&& tar xf v${OPENJPEG_VERSION}.tar.gz \
	&& cd openjpeg-${OPENJPEG_VERSION} \
	&& mkdir build \
	&& cd build \
	&& cmake .. \
	&& make \
	&& make install 

# we have to build our own imagemagick to get jp2 support

ARG MAGICK_VERSION=7.0.8-46
ARG MAGICK_URL=https://github.com/ImageMagick/ImageMagick/archive

RUN wget ${MAGICK_URL}/${MAGICK_VERSION}.tar.gz \
	&& tar xf ${MAGICK_VERSION}.tar.gz \
	&& cd ImageMagick-${MAGICK_VERSION} \
	&& ./configure \
	&& make V=0 \
	&& make install 

ARG VIPS_VERSION=8.8.0
ARG VIPS_URL=https://github.com/libvips/libvips/releases/download

RUN wget ${VIPS_URL}/v${VIPS_VERSION}/vips-${VIPS_VERSION}.tar.gz \
	&& tar xf vips-${VIPS_VERSION}.tar.gz \
	&& cd vips-${VIPS_VERSION} \
	&& ./configure \
	&& make V=0 \
	&& make install 

WORKDIR /data
