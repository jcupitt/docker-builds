FROM ubuntu:20.10

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
	&& apt-get install -y \
    build-essential \
    cmake \
    git

WORKDIR /usr/local/src

# this works
ENV LD_LIBRARY_PATH /home/banana/lib

# add a colon at the end and linking fails
#ENV LD_LIBRARY_PATH /home/banana/lib:

# install the system brotli
RUN apt-get install -y \
  libbrotli-dev

RUN git clone --depth 1 --recursive https://gitlab.com/wg1/jpeg-xl.git \
  && cd jpeg-xl \
  && mkdir build \
  && cd build \
  && cmake -G "Unix Makefiles" \
    -DCMAKE_BUILD_TYPE=Debug \
    -DCMAKE_INSTALL_PREFIX=/usr/local \
    -DBUILD_TESTING=0 \
    -DJPEGXL_ENABLE_FUZZERS=0 \
    -DJPEGXL_ENABLE_MANPAGES=0 \
    -DJPEGXL_ENABLE_BENCHMARK=0 \
    -DJPEGXL_ENABLE_EXAMPLES=0 \
    -DJPEGXL_ENABLE_SKCMS=0 \
    .. \
  && make -j$(nproc) \
  && make install

RUN exit 1

RUN apt-get install -y \
	glib-2.0-dev \
	libexpat-dev \
	librsvg2-dev \
	libpng-dev \
	libgif-dev \
	libjpeg-dev \
	libexif-dev \
	liblcms2-dev \
	liborc-dev

RUN apt-get install -y \
    autoconf \
    libtool \
    gtk-doc-tools \
    gobject-introspection

RUN git clone --depth 1 https://github.com/libvips/libvips \
	&& cd libvips \
	&& ./autogen.sh \
	&& make V=0 \
	&& make install 

