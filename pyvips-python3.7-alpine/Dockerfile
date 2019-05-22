FROM alpine:latest

ARG VIPS_VERSION=8.8.0
ARG VIPS_URL=https://github.com/libvips/libvips/releases/download

ARG PYTHON_VERSION=3.7.3
ARG PYTHON_URL=https://www.python.org/ftp/python

RUN apk update && apk upgrade

# basic packages libvips likes
RUN apk add \
	build-base \
	autoconf \
	automake \
	libtool \
	bc \
	zlib-dev \
	expat-dev \
	jpeg-dev \
	tiff-dev \
	glib-dev \
	libjpeg-turbo-dev \
	libexif-dev \
	lcms2-dev \
	fftw-dev \
	giflib-dev \
	libpng-dev \
	libwebp-dev \
	orc-dev \
	libgsf-dev 

# add these if you like for text rendering, PDF rendering, SVG rendering, 
# but they will pull in loads of other stuff
RUN apk add \
	gdk-pixbuf-dev \
	poppler-dev \
	librsvg-dev 

# there are other optional deps you can add for openslide / openexr /
# imagmagick support / Matlab support etc etc

RUN wget -O- ${VIPS_URL}/v${VIPS_VERSION}/vips-${VIPS_VERSION}.tar.gz | tar xzC /tmp
RUN cd /tmp/vips-${VIPS_VERSION} \
	&& ./configure --disable-static --disable-debug \
	&& make V=0 \
	&& make install 

# packages for python
RUN apk add \
	openssl-dev 

RUN cd /tmp \
	&& wget ${PYTHON_URL}/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tar.xz \
	&& tar xf Python-${PYTHON_VERSION}.tar.xz \
	&& cd Python-${PYTHON_VERSION} \
	&& ./configure \
	&& make \
	&& make install 

# and now pyvips can go on
RUN pip3.7 install --upgrade pip \
	&& pip3.7 install pyvips

WORKDIR /data

