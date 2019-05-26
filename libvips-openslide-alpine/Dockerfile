FROM alpine:latest

RUN apk update \
	&& apk upgrade

RUN apk add build-base \
	autoconf \
	automake \
	libtool \
	bc \
	zlib-dev \
	libxml2-dev \
	jpeg-dev \
	openjpeg-dev \
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

ARG OPENSLIDE_VERSION=3.4.1
ARG OPENSLIDE_URL=https://github.com/openslide/openslide/releases/download

COPY openslide-init.patch /usr/local/src
RUN wget ${OPENSLIDE_URL}/v${OPENSLIDE_VERSION}/openslide-${OPENSLIDE_VERSION}.tar.gz \
	&& tar xf openslide-${OPENSLIDE_VERSION}.tar.gz \
	&& patch -p0 <openslide-init.patch \
        && cd openslide-${OPENSLIDE_VERSION} \
	&& ./configure \
	&& make \
	&& make install 

ARG VIPS_VERSION=8.8.0
ARG VIPS_URL=https://github.com/libvips/libvips/releases/download

RUN wget ${VIPS_URL}/v${VIPS_VERSION}/vips-${VIPS_VERSION}.tar.gz \
	&& tar xf vips-${VIPS_VERSION}.tar.gz \
	&& cd vips-${VIPS_VERSION} \
	&& ./configure \
	&& make V=0 \
	&& make install 
