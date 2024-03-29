FROM alpine:3.14

RUN apk update && apk upgrade

# basic packages libvips likes
RUN apk add \
	build-base \
	meson \
	zlib-dev \
	expat-dev \
	jpeg-dev \
	tiff-dev \
	glib-dev \
	libjpeg-turbo-dev \
	libexif-dev \
	lcms2-dev \
	fftw-dev \
	libpng-dev \
	libwebp-dev \
	libarchive-dev 

# add these if you like for text rendering, PDF rendering, SVG rendering, 
# but they will pull in loads of other stuff
RUN apk add \
	gdk-pixbuf-dev \
	poppler-dev \
	librsvg-dev 

# there are other optional deps you can add for openslide / openexr /
# imagmagick support / Matlab support etc etc

WORKDIR /usr/local/src

ARG VIPS_VERSION=8.15.1
ARG VIPS_URL=https://github.com/libvips/libvips/releases/download

RUN wget ${VIPS_URL}/v${VIPS_VERSION}/vips-${VIPS_VERSION}.tar.xz

RUN tar xf vips-${VIPS_VERSION}.tar.xz \
	&& cd vips-${VIPS_VERSION} \
	&& meson setup build \
	&& cd build \
	&& meson compile \
	&& meson install

# stuff for pyvips
RUN apk add \
	python3-dev \
	py3-pip
RUN pip3 install wheel
RUN pip3 install pyvips

WORKDIR /data
