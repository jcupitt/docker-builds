FROM heroku/heroku:20

# generic build tools  ... libgsf needs intltool
RUN apt-get update \
	&& apt-get install -y \
		build-essential \
		wget \
		python3-pip \
		ninja-build \
		intltool \
		pkg-config 

RUN pip3 install meson

# use the heroku platform libraries when we can
#
# see https://devcenter.heroku.com/articles/stack-packages
#
# libgsf needs libxml2
RUN apt-get install -y \
	glib-2.0-dev \
	libexpat-dev \
	libpoppler-glib-dev \
	libpango1.0-dev \
	librsvg2-dev \
	libpng-dev \
	libheif-dev \
	libimagequant-dev \
	libwebp-dev \
	libjpeg-turbo8-dev \
	libtiff5-dev \
	libexif-dev \
	liblcms2-dev \
	libxml2-dev \
	libfftw3-dev 

WORKDIR /usr/local/src

# build to this prefix
ARG PREFIX=/usr/local/vips
ENV PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig

ARG ORC_VERSION=0.4.32
ARG ORC_URL=https://gstreamer.freedesktop.org/src/orc

RUN wget ${ORC_URL}/orc-$ORC_VERSION.tar.xz \
	&& tar xf orc-${ORC_VERSION}.tar.xz \
	&& cd orc-${ORC_VERSION} \
	&& meson build --prefix=${PREFIX} --libdir=lib \
	&& cd build \
	&& ninja \
	&& ninja install

ARG GSF_VERSION=1.14.48
ARG GSF_URL=http://ftp.gnome.org/pub/GNOME/sources/libgsf

RUN wget ${GSF_URL}/${GSF_VERSION%.*}/libgsf-$GSF_VERSION.tar.xz \
	&& tar xf libgsf-${GSF_VERSION}.tar.xz \
	&& cd libgsf-${GSF_VERSION} \
	&& ./configure --prefix=$PREFIX --disable-gtk-doc \
	&& make \
	&& make install

# use cgif for GIF write
ARG CGIF_VERSION=0.2.0
ARG CGIF_URL=https://github.com/dloebl/cgif/archive/refs/tags

RUN wget ${CGIF_URL}/V${CGIF_VERSION}.tar.gz \
	&& tar xf V${CGIF_VERSION}.tar.gz \
	&& cd cgif-${CGIF_VERSION} \
	&& meson build --prefix=${PREFIX} --libdir=lib \
	&& cd build \
	&& ninja \
	&& ninja install

# use libspng for PNG load (libvips 8.13 will support PNG save as well, but
# for now it's only load)
ARG SPNG_VERSION=0.7.2
ARG SPNG_URL=https://github.com/randy408/libspng/archive/refs/tags

RUN wget ${SPNG_URL}/v${SPNG_VERSION}.tar.gz \
	&& tar xf v${SPNG_VERSION}.tar.gz \
	&& cd libspng-${SPNG_VERSION} \
	&& meson build --prefix=${PREFIX} --libdir=lib \
	&& cd build \
	&& ninja \
	&& ninja install

ARG VIPS_VERSION=8.12.2
ARG VIPS_URL=https://github.com/libvips/libvips/releases/download

RUN wget ${VIPS_URL}/v${VIPS_VERSION}/vips-${VIPS_VERSION}.tar.gz \
	&& tar xzf vips-${VIPS_VERSION}.tar.gz \
	&& cd vips-${VIPS_VERSION} \
	&& ./configure --prefix=$PREFIX \
		--disable-deprecated \
		--without-radiance \
		--without-analyze \
	&& make V=0 \
	&& make install

# clean the install area ready for packaging
RUN cd $PREFIX \
	&& rm bin/orc* bin/gsf* bin/batch_* bin/vips-8.* \
	&& rm bin/vipsprofile bin/light_correct bin/shrink_width \
	&& rm lib/*.a \
	&& strip lib/lib*.so* \
	&& rm -rf share/gtk-doc \
	&& rm -rf share/man \
	&& rm -rf share/thumbnailers 

# install and test ruby-vips to confirm we can pick up the libraries
# correctly ... this needs 
# 1. add $PREFIX/lib to LD_LIBRARY_PATH, or
# 2. add $PREFIX/lib to /etc/ld.so.conf.d and run ldconfig
# we need ruby-dev to install ruby-ffi
ENV LD_LIBRAY_PATH=$PREFIX/lib
RUN apt-get install -y ruby-dev
RUN gem install ruby-vips
RUN ruby -e 'require "vips"; puts "ruby-vips: libvips #{Vips::LIBRARY_VERSION}"'
