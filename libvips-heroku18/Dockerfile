FROM heroku/heroku:18

# useful build tools ... we need gtk-doc to build orc, since they don't ship
# pre-baked tarballs
RUN apt-get update \
	&& apt-get install -y \
		build-essential \
		unzip \
		wget \
		cmake \
		git \
		pkg-config 

# heroku:18 includes some libraries, like tiff and jpeg, as part of the
# run-time platform, and we want to use those libs if we can
#
# see https://devcenter.heroku.com/articles/stack-packages
#
# libgsf needs libxml2
RUN apt-get install -y \
	glib-2.0-dev \
	libexpat-dev \
	librsvg2-dev \
	libpng-dev \
	libjpeg-dev \
	libtiff5-dev \
	libexif-dev \
	liblcms2-dev \
	libxml2-dev \
	libfftw3-dev 

WORKDIR /usr/local/src

# build to this prefix
ARG PREFIX /usr/local/vips
ENV PKG_CONFIG_PATH $PREFIX/lib/pkgconfig

ARG ORC_VERSION=0.4.32
ARG ORC_URL=https://gstreamer.freedesktop.org/src/orc

RUN wget ${ORC_URL}/orc-$ORC_VERSION.tar.xz \
	&& tar xf orc-${ORC_VERSION}.tar.xz \
	&& cd orc-${ORC_VERSION} \
	&& ./configure --prefix=$PREFIX --disable-gtk-doc \
	&& make \
	&& make install

ARG GSF_VERSION=1.14.42
ARG GSF_URL=http://ftp.gnome.org/pub/GNOME/sources/libgsf

RUN wget ${GSF_URL}/${GSF_VERSION%.*}/libgsf-$GSF_VERSION.tar.xz \
	&& tar xf libgsf-${GSF_VERSION}.tar.xz \
	&& cd libgsf-${GSF_VERSION} \
	&& ./configure --prefix=$PREFIX --disable-gtk-doc \
	&& make \
	&& make install

# extract libpdfium built for heroku
COPY libpdfium-master-linux-x64.tar.gz /usr/local/src
RUN cd $PREFIX \
	&& tar xf /usr/local/src/libpdfium-master-linux-x64.tar.gz 

# use cgif for GIF write
ARG CGIF_VERSION=0.2.0
ARG CGIF_URL=https://github.com/dloebl/cgif/archive/refs/tags

ARG CGIF_URL=https://github.com/dloebl/cgif/archive/refs/tags/V0.2.0.tar.gz

RUN wget ${CGIF_URL}/v${CGIF_VERSION}/vips-${CGIF_VERSION}.tar.gz \
	&& tar xf libgsf-${GSF_VERSION}.tar.xz \
	&& cd libgsf-${GSF_VERSION} \
	&& ./configure --prefix=$PREFIX --disable-gtk-doc \
	&& make \
	&& make install


ARG VIPS_VERSION=8.12.2
ARG VIPS_URL=https://github.com/libvips/libvips/releases/download

RUN wget ${VIPS_URL}/v${VIPS_VERSION}/vips-${VIPS_VERSION}.tar.gz \
	&& tar xzf vips-${VIPS_VERSION}.tar.gz \
	&& cd vips-${VIPS_VERSION} \
	&& ./configure --prefix=$PREFIX \
	&& make \
	&& make install

# clean the build area ready for packaging
RUN cd /usr/local/vips \
	&& rm bin/gif* bin/orc* bin/gsf* bin/batch_* bin/vips-8.7 \
	&& rm bin/vipsprofile bin/light_correct bin/shrink_width \
	&& strip lib/*.a lib/lib*.so* \
	&& rm -rf share/gtk-doc \
	&& rm -rf share/man \
	&& rm -rf share/thumbnailers 
