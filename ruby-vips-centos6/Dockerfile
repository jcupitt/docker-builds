FROM centos:6

# general build stuff
RUN yum update -y \
	&& yum groupinstall -y "Development Tools" \
	&& yum install -y wget tar

# have to build our own ruby since centos6 ships with ruby1.8 and ruby-vips
# needs 1.9+

# stuff for a ruby build
RUN yum install -y \
	libxslt-devel \
	libyaml-devel \
	libxml2-devel \
	gdbm-devel\
	libffi-devel \
	zlib-devel \
	openssl-devel \
	libyaml-devel \
	readline-devel\
	curl-devel \
	openssl-devel \
	pcre-devel git \
	memcached-devel \
	valgrind-devel \
	mysql-devel 

ARG RUBY_VERSION=2.6.1
ARG RUBY_URL=https://cache.ruby-lang.org/pub/ruby/2.6

RUN cd /usr/local/src \
	&& wget ${RUBY_URL}/ruby-${RUBY_VERSION}.tar.gz \
	&& tar xf ruby-${RUBY_VERSION}.tar.gz \
	&& cd ruby-${RUBY_VERSION} \
	&& ./configure \
	&& make \
	&& make install

# stuff we need to build our own libvips ... this is a pretty random selection
# of dependencies, you'll want to adjust these

# the centos6 packages for lcms, librsvg, liborc are all too old,
# unfortunately

RUN yum install -y \
	libpng-devel \
	glib2-devel \
	libjpeg-devel \
	expat-devel \
	zlib-devel \
	fftw3-devel \
	openexr-devel \
	giflib-devel \
	libexif-devel \
	openjpeg-devel \
	libtiff-devel \
	gdk-pixbuf2-devel \
	sqlite-devel \
	cairo-devel 

# centos6 ships with libgsf-devel 1.14.15-5, but that's too old and crashy for
# libvips (needed for dzsave), so we have to build our own 

# 1_14_45 needs a newer glib than centos6 has, so use an older but known-good
# version

# 1_14_27 is not shipped as a "make dist" tarball and has an autogen.sh that
# fails on centos6 ... we include our own 1.14.27 tarball

# 1.14.27 is missing zip64 write support, sadly

ARG LIBGSF_VERSION=1.14.27
COPY libgsf-${LIBGSF_VERSION}.tar.bz2 /usr/local/src

RUN cd /usr/local/src \
	&& tar xf libgsf-${LIBGSF_VERSION}.tar.bz2 \
	&& cd libgsf-${LIBGSF_VERSION} \
	&& ./configure \
	&& make \
	&& make install

# libvips needs to be able to find the libgsf-1.pc in /usr/local/lib/pkgconfig

ENV PKG_CONFIG_PATH /usr/local/lib/pkgconfig

ARG VIPS_VERSION=8.7.4
ARG VIPS_URL=https://github.com/libvips/libvips/releases/download

RUN cd /usr/local/src \
	&& wget ${VIPS_URL}/v${VIPS_VERSION}/vips-${VIPS_VERSION}.tar.gz \
	&& tar xf vips-${VIPS_VERSION}.tar.gz \
	&& cd vips-${VIPS_VERSION} \
	&& ./configure \
	&& make V=0 \
	&& make install

RUN gem install ruby-vips

WORKDIR /data
