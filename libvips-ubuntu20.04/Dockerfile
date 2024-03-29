FROM ubuntu:focal

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
	&& apt-get install -y \
		build-essential \
		software-properties-common \
		ninja-build \
		python3-pip \
		bc \
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
	liborc-dev

WORKDIR /usr/local/src

# build the head of the stable 8.13 branch
ARG VIPS_BRANCH=8.13
ARG VIPS_URL=https://github.com/libvips/libvips/tarball

RUN mkdir libvips-${VIPS_BRANCH} \
        && cd libvips-${VIPS_BRANCH} \
        && wget ${VIPS_URL}/${VIPS_BRANCH} -O - | tar xfz - --strip-components 1

# "--libdir lib" makes it put the library in /usr/local/lib
# we don't need GOI
RUN cd libvips-${VIPS_BRANCH} \
        && rm -rf build \
        && meson build --libdir lib -Dintrospection=false --buildtype release \
        && cd build \
        && ninja \
        && ninja test \
        && ninja install

# pyvips .. handy for testing
RUN pip3 install pyvips

