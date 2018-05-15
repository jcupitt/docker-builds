FROM ubuntu:xenial

RUN apt-get update && apt-get install -y \
	build-essential \
	unzip \
	wget \
	git \
	pkg-config 

# have to build our own ruby since centos6 ships with ruby1.8 and ruby-vips
# needs 1.9+

# stuff for a ruby build
RUN apt-get install -y \
	libxslt1-dev \
	libyaml-dev \
	libxml2-dev \
	libgdbm-dev\
	libffi-dev \
	libzip-dev \
	libssl-dev \
	libyaml-dev \
	libreadline-dev \
	libcurl4-openssl-dev \
	libpcre3-dev 

# stuff we need to build our own libvips ... this is a pretty random selection
# of dependencies, you'll want to adjust these
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

ARG RUBY_VERSION=2.3.4
ARG RUBY_URL=https://cache.ruby-lang.org/pub/ruby/2.3

RUN cd /usr/local/src \
	&& wget ${RUBY_URL}/ruby-${RUBY_VERSION}.tar.gz \
	&& tar xzf ruby-${RUBY_VERSION}.tar.gz \
	&& cd ruby-${RUBY_VERSION} \
	&& ./configure \
	&& make \
	&& make install

ARG VIPS_VERSION=8.6.3
ARG VIPS_URL=https://github.com/jcupitt/libvips/releases/download

RUN cd /usr/local/src \
	&& wget ${VIPS_URL}/v${VIPS_VERSION}/vips-${VIPS_VERSION}.tar.gz \
	&& tar xzf vips-${VIPS_VERSION}.tar.gz \
	&& cd vips-${VIPS_VERSION} \
	&& ./configure \
	&& make \
	&& make install

# install the gem
RUN gem install ruby-vips

WORKDIR /usr/local/src
