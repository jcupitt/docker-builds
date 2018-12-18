FROM amazonlinux:2018.03

# general build stuff
RUN yum update -y \
  && yum groupinstall -y "Development Tools" \
  && yum install -y wget tar

# stuff we need to build our own libvips ... this is a pretty basic selection
# of dependencies, you'll want to adjust these
RUN yum install -y \
  libpng-devel \
  glib2-devel \
  libjpeg-devel \
  expat-devel \
  zlib-devel 

ARG VIPS_VERSION=8.7.2
ARG VIPS_URL=https://github.com/libvips/libvips/releases/download

RUN cd /usr/local/src \
  && wget ${VIPS_URL}/v${VIPS_VERSION}/vips-${VIPS_VERSION}.tar.gz \
  && tar xzf vips-${VIPS_VERSION}.tar.gz \
  && cd vips-${VIPS_VERSION} \
  && echo -n "GCC version "; gcc --version \
  && ./configure \
  && make \
  && make install

RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash \
  && . ~/.nvm/nvm.sh \
  && nvm install 8.10.0 

RUN cd /usr/local/src \
  && . ~/.nvm/nvm.sh \
  && npm install sharp 
