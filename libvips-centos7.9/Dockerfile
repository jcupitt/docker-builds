FROM centos:7

# yum-plugin-ovl helps yum work with the docker overlay filesystem 
# not needed for centos8, but 7 requires it
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
	zlib-devel \
	libexif-devel

# install this, but then ask libvips to ignore it
RUN yum install -y \
	fftw-devel

WORKDIR /usr/local/src

ARG VIPS_VERSION=8.13.0
ARG VIPS_URL=https://github.com/libvips/libvips/releases/download

RUN wget ${VIPS_URL}/v${VIPS_VERSION}/vips-${VIPS_VERSION}.tar.gz \
	&& tar xzf vips-${VIPS_VERSION}.tar.gz \
	&& cd vips-${VIPS_VERSION} \
	&& ./configure --without-fftw \
	&& make \
	&& make install

RUN ldd /usr/local/bin/vips 
