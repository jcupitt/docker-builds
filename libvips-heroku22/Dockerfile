FROM heroku/heroku:22

# generic build tools 
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

# last updated 16sep23 ... the version number does not need to be exact, just
# >4800
ARG PDFIUM_VERSION=6002
ARG PDFIUM_URL=https://github.com/bblanchon/pdfium-binaries/releases/download/chromium

RUN wget $PDFIUM_URL/$PDFIUM_VERSION/pdfium-linux-x64.tgz \
  && mkdir pdfium \
  && cd pdfium \
  && tar xf ../pdfium-linux-x64.tgz \
  && cp lib/* $PREFIX/lib \
  && cp -r include/* $PREFIX/include

# make a pdfium.pc file libvips can use
RUN mkdir -p $PREFIX/lib/pkgconfig \
  && cd $PREFIX/lib/pkgconfig \
  && echo "prefix=$PREFIX" >> pdfium.pc \
  && echo "exec_prefix=\${prefix}" >> pdfium.pc \
  && echo "libdir=\${exec_prefix}/lib" >> pdfium.pc \
  && echo "includedir=\${prefix}/include" >> pdfium.pc \
  && echo "Name: pdfium" >> pdfium.pc \
  && echo "Description: pdfium" >> pdfium.pc \
  && echo "Version: $PDFIUM_VERSION" >> pdfium.pc \
  && echo "Requires: " >> pdfium.pc \
  && echo "Libs: -L\${libdir} -lpdfium" >> pdfium.pc \
  && echo "Cflags: -I\${includedir}" >> pdfium.pc

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
# correctly and that we can load a HEIC image
# we need ruby-dev to install ruby-ffi
ENV LD_LIBRAY_PATH=$PREFIX/lib
RUN apt-get install -y ruby-dev
RUN gem install ruby-vips
RUN wget http://www.rollthepotato.net/~john/demo.heic
RUN ruby -e 'require "vips"; puts "ruby-vips: libvips #{Vips::LIBRARY_VERSION}"'
RUN ruby -e 'require "vips"; Vips::Image.new_from_file("demo.heic")'

# install rails and set up a new project using ruby-vips
RUN apt install -y rails
RUN rails new x
RUN cd x \
  && bundle add ruby-vips 

# we need to run rails without spring to see the crash point, so we have to
# set up webpacker
RUN apt install -y npm
RUN npm install --global yarn
RUN rails webpacker:install

# now run the rails console and try to load a HEIC
RUN cd x \
  && echo 'require "vips"; Vips::Image.new_from_file("../demo.heic")' | \
     DISABLE_SPRING=1 bundle exec bin/rails c
