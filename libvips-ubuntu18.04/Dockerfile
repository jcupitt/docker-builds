FROM ubuntu:bionic

RUN apt-get update 
RUN apt-get install -y \
	software-properties-common \
	build-essential \
	unzip \
	wget 

# add the libheif PPA -- it includes AVIF and HEIC support
RUN add-apt-repository ppa:strukturag/libde265 \
	&& add-apt-repository ppa:strukturag/libheif \
	&& apt-get update

# stuff we need to build our own libvips ... this is a pretty random selection
# of dependencies, you'll want to adjust these
# the libheif-dev in ubuntu 18.04 is too old, you'd need to build that from
# source
RUN apt-get install -y \
	glib-2.0-dev \
	libheif-dev \
	libexpat-dev \
	librsvg2-dev \
	libpng-dev \
	libgif-dev \
	libjpeg-dev \
	libtiff-dev \
	libexif-dev \
	liblcms2-dev \
	liborc-dev \
	libffi-dev

ARG VIPS_VERSION=8.11.1
ARG VIPS_URL=https://github.com/libvips/libvips/releases/download

WORKDIR /usr/local/src

RUN wget ${VIPS_URL}/v${VIPS_VERSION}/vips-${VIPS_VERSION}.tar.gz \
	&& tar xzf vips-${VIPS_VERSION}.tar.gz \
	&& cd vips-${VIPS_VERSION} \
	&& ./configure \
	&& make V=0 \
	&& make install \
	&& ldconfig

# pyvips 
RUN apt-get install -y \
	python3-pip 
RUN pip3 install pyvips

