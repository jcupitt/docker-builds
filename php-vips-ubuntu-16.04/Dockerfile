FROM ubuntu:xenial

RUN apt-get update \
    && apt-get install -y \
        build-essential \
        unzip \
        wget \
        pkg-config 

# web server stuff
RUN apt-get install -y \
    nginx 

# php layers 
RUN apt-get install -y \
    php7.0-dev \
    php-pear \
    composer

# stuff we need to build our own libvips 
# glib and expat are the only required ones, the others are optional and
# enable features like jpeg load etc.
# there are other optional dependencies for things like PDF load, see the
# libvips README
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

# build in /build, install to /usr
# the version packaged for 16.04 is too old
WORKDIR /build
COPY install-vips.sh /build
RUN ./install-vips.sh 8 7 4

# install the php extension that links it to libvips
RUN pecl install vips

# enable the vips.so extension at the cli so composer can find it
RUN echo "extension=vips.so" > /etc/php/7.0/mods-available/vips.ini \
    && ln -s /etc/php/7.0/mods-available/vips.ini \
		/etc/php/7.0/cli/conf.d/20-vips.ini

WORKDIR /data
