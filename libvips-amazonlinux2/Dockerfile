FROM amazoncorretto:19.0.2

# general build stuff
RUN yum update -y \
	&& yum groupinstall -y "Development Tools" \
	&& yum install -y \
		wget \
		tar \
		python3-devel

# stuff we need to build our own libvips ... this is a pretty basic selection
# of dependencies, you'll want to adjust these
# dzsave needs libgsf
RUN yum install -y \
	poppler-glib-devel \
	glib2-devel \
	libjpeg-devel \
	libtiff-devel \
	expat-devel \
	zlib-devel \
	orc-devel \
	lcms2-devel \
	libexif-devel \
	libgsf-devel

# openslide is in epel -- extra packages for enterprise linux
RUN yum install -y \
	https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN yum install -y \
	openslide-devel 

# get ninja thourgh pip (the distro one is too old)
RUN pip3 install meson ninja pytest

WORKDIR /usr/local/src
ENV PKG_CONFIG_PATH /usr/local/lib/pkgconfig
ENV LD_LIBRARY_PATH /usr/local/lib64

# use libspng for PNG load and save
ARG SPNG_VERSION=0.7.4
ARG SPNG_URL=https://github.com/randy408/libspng/archive/refs/tags

RUN wget ${SPNG_URL}/v${SPNG_VERSION}.tar.gz \
	&& tar xf v${SPNG_VERSION}.tar.gz \
	&& cd libspng-${SPNG_VERSION} \
	&& meson build \
	&& cd build \
	&& ninja \
	&& ninja install

ARG VIPS_VERSION=8.14.5
ARG VIPS_URL=https://github.com/libvips/libvips/releases/download

RUN wget ${VIPS_URL}/v${VIPS_VERSION}/vips-${VIPS_VERSION}.tar.xz \
	&& tar xf vips-${VIPS_VERSION}.tar.xz \
	&& cd vips-${VIPS_VERSION} \
	&& meson setup build \
		--buildtype release \
		-Dintrospection=false \
	&& cd build \
	&& ninja \
	&& ninja install \
	&& ninja test

RUN pip3 install pyvips 
