FROM alpine:latest

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

# we need some extra packages to build from git master
RUN apk add \
	gtk-doc \
	swig \
	gobject-introspection-dev

WORKDIR /usr/local/src
ARG VIPS_URL=https://github.com/libvips/libvips/archive
RUN wget ${VIPS_URL}/master.zip 
RUN unzip -qq master.zip \
	&& cd libvips-master \
	&& CFLAGS=-O3 CXXFLAGS=-O3 ./autogen.sh \
		--disable-static --disable-debug --disable-introspection \
	&& make V=0 \
	&& make install 

RUN apk add \
	python3-dev \
	py3-pip

# and now pyvips can go on
RUN pip3 install --upgrade pip \
  && pip3 install pyvips

WORKDIR /data
