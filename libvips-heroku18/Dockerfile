FROM heroku/heroku:18

# useful build tools ... we need gtk-doc to build orc, since they don't ship
# pre-baked tarballs
RUN apt-get update && apt-get install -y \
	build-essential \
	autoconf \
	automake \
	libtool \
	intltool \
	gtk-doc-tools \
	unzip \
	wget \
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

ARG GIFLIB_VERSION=5.1.4
ARG GIFLIB_URL=http://downloads.sourceforge.net/project/giflib

RUN cd /usr/src \
	&& wget ${GIFLIB_URL}/giflib-$GIFLIB_VERSION.tar.bz2 \
	&& tar xf giflib-${GIFLIB_VERSION}.tar.bz2 \
	&& cd giflib-${GIFLIB_VERSION} \
	&& ./configure --prefix=/usr/src/vips \
	&& make \
	&& make install

ARG ORC_VERSION=0.4.28
ARG ORC_URL=http://cgit.freedesktop.org/gstreamer/orc/snapshot

RUN cd /usr/src \
	&& wget ${ORC_URL}/orc-$ORC_VERSION.tar.gz \
	&& tar xf orc-${ORC_VERSION}.tar.gz \
	&& cd orc-${ORC_VERSION} \
	&& ./autogen.sh \
	&& ./configure --prefix=/usr/src/vips --disable-gtk-doc \
	&& make \
	&& make install

ARG GSF_VERSION=1.14.42
ARG GSF_URL=http://ftp.gnome.org/pub/GNOME/sources/libgsf

RUN cd /usr/src \
	&& wget ${GSF_URL}/${GSF_VERSION%.*}/libgsf-$GSF_VERSION.tar.xz \
	&& tar xf libgsf-${GSF_VERSION}.tar.xz \
	&& cd libgsf-${GSF_VERSION} \
	&& ./configure --prefix=/usr/src/vips --disable-gtk-doc \
	&& make \
	&& make install

# extract libpdfium built for heroku
COPY libpdfium-master-linux-x64.tar.gz /usr/src
RUN cd /usr/src/vips \
	&& tar xf ../libpdfium-master-linux-x64.tar.gz 

ARG VIPS_VERSION=8.7.1
ARG VIPS_URL=https://github.com/libvips/libvips/releases/download

RUN cd /usr/src \
	&& wget ${VIPS_URL}/v${VIPS_VERSION}/vips-${VIPS_VERSION}.tar.gz \
	&& tar xzf vips-${VIPS_VERSION}.tar.gz \
	&& cd vips-${VIPS_VERSION} \
	&& export PKG_CONFIG_PATH=/usr/src/vips/lib/pkgconfig \
	&& ./configure --prefix=/usr/src/vips --disable-gtk-doc \
	&& make \
	&& make install

# clean the build area ready for packaging
RUN cd /usr/src/vips \
	&& rm bin/gif* bin/orc* bin/gsf* bin/batch_* bin/vips-8.7 \
	&& rm bin/vipsprofile bin/light_correct bin/shrink_width \
	&& strip lib/*.a lib/lib*.so* \
	&& rm -rf share/gtk-doc \
	&& rm -rf share/man \
	&& rm -rf share/thumbnailers 
