FROM ubuntu:focal

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
	&& apt-get install -y \
		build-essential \
		software-properties-common \
		ninja-build \
		python3-pip \
		wget 

# we need meson for libvips build
RUN pip3 install meson

# we use cgif for GIF write
RUN add-apt-repository ppa:lovell/cgif \
	&& apt-get update \
	&& apt-get install -y libcgif-dev

# stuff we need to build our own libvips ... this is a pretty random selection
# of dependencies, you'll want to adjust these
RUN apt-get install -y \
	glib-2.0-dev \
	libexpat-dev \
	librsvg2-dev \
	libpng-dev \
	libjpeg-turbo8-dev \
	libtiff-dev \
	libexif-dev \
	liblcms2-dev \
	libheif-dev \
	libpango1.0-dev \
	liborc-dev

WORKDIR /usr/local/src

# build the head of the stable 8.15 branch
ARG VIPS_BRANCH=8.15
ARG VIPS_URL=https://github.com/libvips/libvips/tarball

RUN mkdir libvips-${VIPS_BRANCH} \
        && cd libvips-${VIPS_BRANCH} \
        && wget ${VIPS_URL}/${VIPS_BRANCH} -O - | tar xfz - --strip-components 1

# we don't need GOI
# ldconfig forces a rebuild of the library cache
RUN cd libvips-${VIPS_BRANCH} \
        && rm -rf build \
        && meson build -Dintrospection=disabled \
        && cd build \
        && ninja \
        && ninja test \
        && ninja install \
        && ldconfig 

# pyvips .. handy for testing
RUN pip3 install pyvips

