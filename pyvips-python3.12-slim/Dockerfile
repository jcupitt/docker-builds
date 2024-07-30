# Use an official Python runtime as the base image
FROM python:3.12-slim

# Install 
RUN apt-get update && apt-get install -y \
        pkg-config \
        wget \
        build-essential \
        ninja-build

RUN pip3 install meson

# stuff we need to build our own libvips ... this is a pretty random selection
# of dependencies, you'll want to adjust these
RUN apt-get install -y --no-install-recommends \
    glib-2.0-dev \
    libexpat-dev \
    librsvg2-dev \
    libpng-dev \
    libspng-dev \
    libjpeg-dev \
    libexif-dev \
    liblcms2-dev \
    liborc-dev \
    libtiff5-dev \
    libexif-dev \
    libwebp-dev \
    libheif-dev \
    libpoppler-glib-dev \
    libfftw3-dev \
    libopenjp2-7-dev \
    libimagequant-dev \
    libpango1.0-dev \
    libcgif-dev \
#    libhwy-dev \   
    libarchive-dev \
    libjxl-dev

# can't install libhwy-dev since it's only 1.0.3 on Debian 12 and >=1.0.5 is needed to enable with libvips
# build highway independently from source if you want to include it

# use the precompiled libvips binaries packaged by kleis
ARG VIPS_VERSION=8.15.2
ARG VIPS_URL=https://github.com/libvips/libvips/releases/download

WORKDIR /usr/local/src

RUN wget ${VIPS_URL}/v${VIPS_VERSION}/vips-${VIPS_VERSION}.tar.xz

# "ninja test" needs bc for float arithmetic
RUN apt-get install -y --no-install-recommends \
    bc

# "--libdir lib" makes it put the library in /usr/local/lib
# we don't need GOI
RUN tar xf vips-${VIPS_VERSION}.tar.xz \
    && cd vips-${VIPS_VERSION} \
    && rm -rf build \
    && meson build --libdir lib -Dintrospection=disabled --buildtype release \
    && cd build \
    && ninja \
    && ninja test \
    && ninja install

ENV LD_LIBRARY_PATH=/usr/local/lib
ENV PKG_CONFIG_PATH=/usr/local/lib/pkgconfig

# pyvips will be installed in API (not ABI) mode
RUN pip install pyvips
