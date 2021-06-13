FROM lambci/lambda:build-ruby2.7

# general build stuff
RUN yum update -y \
	&& yum groupinstall -y "Development Tools" \
	&& yum install -y \
		wget \
		mercurial 

WORKDIR /build

ENV WORKDIR="/build"
ENV INSTALLDIR="/opt"
ENV PKG_CONFIG_PATH=/usr/local/lib/pkgconfig 

ARG PTOOLS_URL=http://mirror.centos.org/centos/8/PowerTools/x86_64/os/Packages
ARG NASM_VERSION=2.15.03-3
RUN curl $PTOOLS_URL/nasm-$NASM_VERSION.el8.x86_64.rpm --output nasm.rpm \
	&& yum install -y nasm.rpm

RUN hg clone http://hg.videolan.org/x265
RUN cd ./x265/build/linux \
	&& cmake -G "Unix Makefiles" ../../source \
	&& make -j6 \
	&& make install \
	&& ldconfig

ARG HEIF_URL=https://github.com/strukturag/libheif/releases/download
ARG HEIF_VERSION=1.9.1

RUN curl -L $HEIF_URL/v$HEIF_VERSION/libheif-$HEIF_VERSION.tar.gz | tar xz \
	&& cd libheif-$HEIF_VERSION \
	&& ./autogen.sh \
	&& ./configure \
	&& make V=0 \
	&& make install

ARG VIPS_VERSION=8.11.0
ARG VIPS_URL=https://github.com/libvips/libvips/releases/download

# selection of packages for libvips -- you might want to expand this
RUN yum install -y \
	expat-devel \
	glib2-devel \
	lcms2-devel \
	libexif-devel \
	libgsf-devel \
	libjpeg-turbo-devel \
	libpng-devel \
	libtiff-devel \
	orc-devel 

RUN wget $VIPS_URL/v$VIPS_VERSION/vips-$VIPS_VERSION.tar.gz \
	&& tar xzf vips-$VIPS_VERSION.tar.gz \
	&& cd vips-$VIPS_VERSION \
	&& ./configure \
	&& make V=0 \
	&& make install

# test ruby-vips
RUN gem install ruby-vips \
	&& ruby -e 'require "vips"; puts "success!"'

