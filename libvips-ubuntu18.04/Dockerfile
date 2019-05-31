FROM ubuntu:bionic

RUN apt-get update \
	&& apt-get install -y 

# libvips dependences .. only the things we need to generate the docs
# - pandoc to reformat .md as docbook
# - libgirepository1.0-dev to make introspection files
# - libtool to build the introspection scanner
RUN apt-get install -y \
	gtk-doc-tools \
	pandoc \
	gobject-introspection \
  libgirepository1.0-dev \
  libtool \
	libglib2.0-dev \
	libexpat-dev 

ARG VIPS_VERSION=8.8.0
ARG VIPS_URL=https://github.com/libvips/libvips/releases/download

RUN apt-get install -y \
	wget

RUN cd /usr/local/src \
	&& wget ${VIPS_URL}/v${VIPS_VERSION}/vips-${VIPS_VERSION}.tar.gz \
	&& tar xzf vips-${VIPS_VERSION}.tar.gz \
	&& cd vips-${VIPS_VERSION} \
	&& ./configure --enable-gtk-doc \
	&& make \
	&& make install

