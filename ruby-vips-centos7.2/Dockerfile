FROM centos:centos7.2.1511

# yum-plugin-ovl helps yum work with the docker overlay filesystem 
RUN yum update -y \
  && yum -y install yum-plugin-ovl 

# general build stuff 
RUN yum groupinstall -y "Development Tools" \
	&& yum install -y wget tar

# stuff we need to build our own libvips ... this is a pretty basic selection
# of dependencies, you'll want to adjust these
RUN yum install -y \
	libpng-devel \
	glib2-devel \
	libjpeg-devel \
	expat-devel \
	zlib-devel \
	libexif-devel \
	libgsf-devel

ARG VIPS_VERSION=8.7.1
ARG VIPS_URL=https://github.com/libvips/libvips/releases/download

RUN cd /usr/local/src \
	&& wget ${VIPS_URL}/v${VIPS_VERSION}/vips-${VIPS_VERSION}.tar.gz \
	&& tar xzf vips-${VIPS_VERSION}.tar.gz \
	&& cd vips-${VIPS_VERSION} \
	&& ./configure \
	&& make \
	&& make install

# centos7.2 has ruby2.0, which is rather old
RUN yum install -y \
	ruby-devel

# install the gem
RUN gem install ruby-vips

WORKDIR /usr/local/src
