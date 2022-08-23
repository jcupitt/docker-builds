FROM centos:7

# yum-plugin-ovl helps yum work with the docker overlay filesystem 
# not needed for centos8, but 7 requires it
RUN yum update -y \
  && yum -y install yum-plugin-ovl 

# general build stuff 
RUN yum groupinstall -y "Development Tools" \
	&& yum install -y wget tar

WORKDIR /usr/local/src
ENV PKG_CONFIG_PATH /usr/local/lib/pkgconfig

# packages needed by libgsf
RUN yum install -y \
	glib2-devel \
	libxml2-devel

ARG LIBGSF_VERSION=1.14.45
ARG LIBGSF_URL=https://download.gnome.org/sources/libgsf/1.14

RUN wget ${LIBGSF_URL}/libgsf-${LIBGSF_VERSION}.tar.xz \
    && tar xf libgsf-${LIBGSF_VERSION}.tar.xz \
	&& cd libgsf-${LIBGSF_VERSION} \
	&& ./configure \
	&& make V=0 \
	&& make install

# packages for libvips ... adjust these
RUN yum install -y \
	libpng-devel \
	libjpeg-devel \
	expat-devel \
	zlib-devel \
	fftw-devel \
	libexif-devel

ARG VIPS_VERSION=8.13.0
ARG VIPS_URL=https://github.com/libvips/libvips/releases/download

RUN wget ${VIPS_URL}/v${VIPS_VERSION}/vips-${VIPS_VERSION}.tar.gz \
	&& tar xzf vips-${VIPS_VERSION}.tar.gz \
	&& cd vips-${VIPS_VERSION} \
	&& ./configure \
	&& make V=0 \
	&& make install

RUN ldd /usr/local/bin/vips 
