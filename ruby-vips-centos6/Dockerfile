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

# stuff we need to build our own libvips ... this is a pretty random selection
# of dependencies, you'll want to adjust these
RUN yum install -y \
	libpng-devel \
	glib2-devel \
	libjpeg-devel \
	expat-devel \
	zlib-devel \
	openjpeg-devel \
	libtiff-devel \
	gdk-pixbuf2-devel \
	sqlite-devel \
	cairo-devel 

# build latest ruby by default
ARG RUBY_VERSION=2.5.1
ARG RUBY_URL=https://cache.ruby-lang.org/pub/ruby/2.5

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
RUN yum install -y \
	ruby \
	rubygems
RUN gem install ruby-vips

WORKDIR /data
