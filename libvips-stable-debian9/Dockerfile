FROM debian:9.11

RUN apt-get update && apt-get install -y \
	build-essential \
	ninja-build \
	wget \
	pkg-config 

# deb9 meson is too old (0.37, libvips needs 0.56+)
RUN apt-get install -y \
	python3-pip

RUN pip3 install meson

# stuff we need to build our own libvips ... this is a pretty random selection
# of dependencies, you'll want to adjust these
RUN apt-get install -y --no-install-recommends \
	glib-2.0-dev \
	libexpat-dev \
	librsvg2-dev \
	libpng-dev \
	libjpeg-dev \
	libexif-dev \
	liblcms2-dev \
	liborc-dev 

WORKDIR /usr/local/src

# build the head of the stable 8.13 branch
ARG VIPS_BRANCH=8.13
ARG VIPS_URL=https://github.com/libvips/libvips/tarball

RUN mkdir libvips-${VIPS_BRANCH} \
	&& cd libvips-${VIPS_BRANCH} \
	&& wget ${VIPS_URL}/${VIPS_BRANCH} -O - | tar xfz - --strip-components 1

# "ninja test" needs bc for float arithmetic
RUN apt-get install -y --no-install-recommends \
	bc

# "--libdir lib" makes it put the library in /usr/local/lib
# we don't need GOI
RUN cd libvips-${VIPS_BRANCH} \
	&& rm -rf build \
	&& meson build --libdir lib -Dintrospection=false --buildtype release \
	&& cd build \
	&& ninja \
	&& ninja test \
	&& ninja install
