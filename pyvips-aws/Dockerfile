FROM amazonlinux:2018.03.0.20180424

# general build stuff
RUN yum update -y \
	&& yum groupinstall -y "Development Tools" \
	&& yum install -y wget tar

# stuff we need to build our own libvips 
# this is a pretty minimal selection of dependencies, you'll probably want more
# especially consider orc, the runtime compiler, it can give libvips a 
# good speedup on many operations
RUN yum install -y \
	glib2-devel \
	expat-devel \
	zlib-devel \
	libpng-devel \
	libjpeg-devel \
	libtiff-devel 

ARG VIPS_VERSION=8.6.3
ARG VIPS_URL=https://github.com/jcupitt/libvips/releases/download

# the gcc7 that amazon defaults to has problems with mixed scalar and vector
# arithmetic ... we have to build with 4.8
# we need to ldconfig to get the loader to see the new library in /usr/lib
RUN cd /usr/local/src \
	&& wget ${VIPS_URL}/v${VIPS_VERSION}/vips-${VIPS_VERSION}.tar.gz \
	&& tar xzf vips-${VIPS_VERSION}.tar.gz \
	&& cd vips-${VIPS_VERSION} \
	&& CC="gcc48 -O3" CXX="g++48 -O3" ./configure --prefix=/usr \
	&& make V=0 \
	&& make install \
	&& ldconfig

# install latest pip
RUN cd /usr/local/src \
	&& curl -O https://bootstrap.pypa.io/get-pip.py \
	&& python get-pip.py

# install pyvips
RUN pip install pyvips

WORKDIR /data

