FROM fedora:28

# general build stuff
RUN yum update -y \
	&& yum groupinstall -y "Development Tools" \
	&& yum install -y wget tar gcc-c++

# stuff we need to build our own libvips ... this is a pretty basic selection
# of dependencies, you'll want to adjust these
RUN yum install -y \
	libpng-devel \
	glib2-devel \
	libjpeg-devel \
	expat-devel \
	pango-devel \
	zlib-devel 

ARG VIPS_VERSION=8.7.3
ARG VIPS_URL=https://github.com/libvips/libvips/releases/download

RUN cd /usr/local/src \
	&& wget ${VIPS_URL}/v${VIPS_VERSION}/vips-${VIPS_VERSION}.tar.gz \
	&& tar xzf vips-${VIPS_VERSION}.tar.gz \
	&& cd vips-${VIPS_VERSION} \
	&& ./configure \
	&& make \
	&& make install

ARG NIP2_VERSION=8.7.0
ARG NIP2_URL=https://github.com/libvips/nip2/releases/download

# stuff we need to build our own nip2 
RUN yum install -y \
	gtk2-devel \
	libxml2-devel \
	bison \
	flex 

RUN cd /usr/local/src \
	&& wget ${NIP2_URL}/v${NIP2_VERSION}/nip2-${NIP2_VERSION}.tar.gz \
	&& tar xzf nip2-${NIP2_VERSION}.tar.gz \
	&& cd nip2-${NIP2_VERSION} \
	&& export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig \
	&& CFLAGS=-g ./configure \
	&& make \
	&& make install


