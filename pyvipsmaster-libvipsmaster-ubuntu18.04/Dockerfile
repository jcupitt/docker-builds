FROM ubuntu:bionic

RUN apt-get update \
	&& apt-get install -y 

# stuff we need to build our own libvips ... this is a pretty random selection
# of dependencies, you'll want to adjust these
RUN apt-get install -y \
	glib-2.0-dev \
	libexpat-dev \
	librsvg2-dev \
	libpng-dev \
	libgif-dev \
	libjpeg-dev \
	libexif-dev \
	liblcms2-dev \
	liborc-dev 

# we need some extra packages to build from git master
RUN apt-get install -y \
	build-essential \
	autoconf \
	automake \
	libtool \
	unzip \
	wget \
	git \
	pkg-config \
	gtk-doc-tools \
	swig \
	gobject-introspection

WORKDIR /usr/local/src
ARG VIPS_URL=https://github.com/libvips/libvips/archive
RUN wget ${VIPS_URL}/master.zip 
RUN unzip -qq master.zip \
	&& rm master.zip \
	&& cd libvips-master \
	&& CFLAGS=-O3 CXXFLAGS=-O3 ./autogen.sh \
		--disable-static --disable-debug --disable-introspection \
	&& make V=0 \
	&& make install 

RUN apt-get install -y \
	python3-pip

ARG PYVIPS_URL=https://github.com/libvips/pyvips/archive
RUN wget ${PYVIPS_URL}/master.zip 
RUN unzip -qq master.zip \
	&& rm master.zip \
	&& cd pyvips-master \
	&& pip3 install -e . 


