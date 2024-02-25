FROM debian:buster

RUN apt-get -y update && apt-get -y install \
  build-essential \
  pkg-config \
  ninja-build \
  python3-pip \
  wget 

RUN pip3 install meson

RUN apt-get -y install \
  fftw3-dev \
  glib2.0-dev \
  libarchive-dev \
  libexif-dev \
  libexpat1-dev \
  libfftw3-dev \
  libimagequant-dev \
  libjpeg62-turbo-dev \
  liblcms2-dev \
  liborc-0.4-dev \
  libpango1.0-dev \
  libpng-dev \
  libpoppler-glib-dev \
  librsvg2-dev \
  libtiff5-dev \
  libwebp-dev 

ENV VIPS_VERSION=8.15.1
ARG VIPS_URL=https://github.com/libvips/libvips/releases/download

WORKDIR /usr/local/src

ENV LD_LIBRARY_PATH /lib:/usr/lib:/usr/local/lib

RUN wget ${VIPS_URL}/v${VIPS_VERSION}/vips-${VIPS_VERSION}.tar.xz 

RUN tar xf vips-${VIPS_VERSION}.tar.xz \
  && cd vips-${VIPS_VERSION} \
  && meson build --buildtype=release --libdir=lib \
  && cd build \
  && ninja \
  && ninja install

WORKDIR /data
