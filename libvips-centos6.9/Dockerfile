FROM centos:centos6.9

# yum-plugin-ovl helps yum work with the docker overlay filesystem 
RUN yum update -y \
	&& yum -y install yum-plugin-ovl 

# general build stuff 
RUN yum groupinstall -y "Development Tools" \
	&& yum install -y wget tar

# stuff we need to build our own libvips ... this is a pretty basic selection
# of dependencies, you'll want to adjust these
RUN yum install -y \
	libpng-devel \
	glib2-devel \
	libjpeg-devel \
	expat-devel \
	libgsf-devel \
	zlib-devel 

# openslide is in epel
RUN yum install -y \
	https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
RUN yum install -y \
	openslide-devel 

WORKDIR /usr/local/src

# packages needed by libwebp
RUN yum install -y \
	libjpeg-devel \
	libpng-devel \
	libtiff-devel \
	libgif-devel 

ARG WEBP_VERSION=1.1.0
ARG WEBP_URL=https://storage.googleapis.com/downloads.webmproject.org/releases/webp

RUN wget ${WEBP_URL}/libwebp-${WEBP_VERSION}.tar.gz \
	&& tar xzf libwebp-${WEBP_VERSION}.tar.gz \
	&& cd libwebp-${WEBP_VERSION} \
	&& ./configure --enable-libwebpmux --enable-libwebpdemux \
	&& make V=0 \
	&& make install

ARG VIPS_VERSION=8.10.0
ARG VIPS_URL=https://github.com/libvips/libvips/releases/download

# so libvips picks up our new libwebp
ENV PKG_CONFIG_PATH /usr/local/lib/pkgconfig

RUN wget ${VIPS_URL}/v${VIPS_VERSION}/vips-${VIPS_VERSION}.tar.gz \
	&& tar xzf vips-${VIPS_VERSION}.tar.gz \
	&& cd vips-${VIPS_VERSION} \
	&& ./configure \
	&& make V=0 \
	&& make install

