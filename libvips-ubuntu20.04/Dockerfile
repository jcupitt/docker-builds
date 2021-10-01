FROM ubuntu:focal

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update 
RUN apt-get install -y \
	build-essential \
	unzip \
	wget 

# stuff we need to build our own libvips ... this is a pretty random selection
# of dependencies, you'll want to adjust these
RUN apt-get install -y \
	glib-2.0-dev \
	libexpat-dev \
	librsvg2-dev \
	libpng-dev \
	libgif-dev \
	libjpeg-turbo8-dev \
	libtiff-dev \
	libexif-dev \
	liblcms2-dev \
	libheif-dev \
	liborc-dev

ARG VIPS_VERSION=8.9.2
ARG VIPS_URL=https://github.com/libvips/libvips/releases/download

WORKDIR /usr/local/src

RUN wget ${VIPS_URL}/v${VIPS_VERSION}/vips-${VIPS_VERSION}.tar.gz \
	&& tar xzf vips-${VIPS_VERSION}.tar.gz \
	&& cd vips-${VIPS_VERSION} \
	&& ./configure \
	&& make V=0 \
	&& make install \
	&& ldconfig

# pyvips .. handy for testing
RUN apt-get install -y \
	python3-pip 
RUN pip3 install pyvips

