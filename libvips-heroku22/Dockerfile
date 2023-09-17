FROM heroku/heroku:22

# generic build tools  ... libgsf needs intltool
RUN apt-get update \
	&& apt-get install -y \
		build-essential \
		wget \
		python3-pip \
		ninja-build \
		pkg-config 

RUN pip3 install meson

# use the heroku platform libraries when we can
#
# see https://devcenter.heroku.com/articles/stack-packages
#
# this should only pull in header files and should not create any extra run
# time dependencies
RUN apt-get install -y \
	glib-2.0-dev \
	libexpat1-dev \
	libpango1.0-dev \
	librsvg2-dev \
	libpng-dev \
	libwebp-dev \
	libjpeg-turbo8-dev \
	libtiff5-dev \
	libexif-dev \
	liblcms2-dev \
	libgsf-1-dev \
	liborc-0.4-dev \
	libimagequant-dev \
    libpoppler-glib-dev \
	libcgif-dev \
	libheif-dev \
	libfftw3-dev 

WORKDIR /usr/local/src

# build to this prefix 
#  - heroku has /usr/local/lib on the default ld.so.conf search path, so 
#    this is convenient
#  - heroku has a basic dir structure in /usr/local, but no files
ARG PREFIX=/usr/local
ENV PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig

# we can't use pdfium since their binaries use a different C++ compiler from
# the one that libheif builds with

# use libspng for PNG load and save
ARG SPNG_VERSION=0.7.4
ARG SPNG_URL=https://github.com/randy408/libspng/archive/refs/tags

RUN wget ${SPNG_URL}/v${SPNG_VERSION}.tar.gz \
	&& tar xf v${SPNG_VERSION}.tar.gz \
	&& cd libspng-${SPNG_VERSION} \
	&& meson build --prefix=${PREFIX} --libdir=lib \
	&& cd build \
	&& ninja \
	&& ninja install

ARG VIPS_VERSION=8.14.4
ARG VIPS_URL=https://github.com/libvips/libvips/releases/download

RUN wget ${VIPS_URL}/v${VIPS_VERSION}/vips-${VIPS_VERSION}.tar.xz \
	&& tar xf vips-${VIPS_VERSION}.tar.xz \
	&& cd vips-${VIPS_VERSION} \
	&& meson setup build \
		--prefix=$PREFIX \
		--libdir=lib \
		--buildtype=release \
		-Dradiance=false \
		-Danalyze=false \
		-Dmodules=disabled \
		-Dintrospection=false \
	&& cd build \
	&& meson compile \
	&& meson install

# clean and package
RUN cd $PREFIX \
	&& cp -r lib libvips-heroku22 \
	&& cd libvips-heroku22 \
	&& strip lib*.so* \
	&& rm -rf pkgconfig \
	&& rm -rf python* \
	&& tar cfz ../libvips-heroku22.tar.gz * \
	&& echo built libvips-heroku22.tar.gz \
 	&& ls -l $PREFIX/libvips-heroku22.tar.gz

# install and test ruby-vips to confirm we can pick up the libraries
# correctly 
# we need ruby-dev to install ruby-ffi
ENV LD_LIBRAY_PATH=$PREFIX/lib
RUN apt-get install -y ruby-dev
RUN gem install ruby-vips
RUN ruby -e 'require "vips"; puts "ruby-vips: libvips #{Vips::LIBRARY_VERSION}"'
