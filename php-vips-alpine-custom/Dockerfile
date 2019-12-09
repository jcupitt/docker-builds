# build with
#    docker pull alpine:latest
#    docker build -t php-vips-alpine:latest .

# run with
#    docker run -it --rm php-vips-alpine 

FROM alpine:latest

RUN apk update && apk upgrade

# basic packages libvips likes
RUN apk add \
	build-base \
	libtool \
	bc \
	zlib-dev \
	expat-dev \
	jpeg-dev \
	tiff-dev \
	glib-dev \
	libjpeg-turbo-dev \
	libexif-dev \
	lcms2-dev \
	fftw-dev \
	giflib-dev \
	libpng-dev \
	libwebp-dev \
	orc-dev \
	libgsf-dev 

# add these if you like for text rendering, PDF rendering, SVG rendering, 
# but they will pull in loads of other stuff
RUN apk add \
	gdk-pixbuf-dev \
	poppler-dev \
	librsvg-dev 

ARG VIPS_VERSION=8.8.4
#ARG VIPS_URL=https://github.com/libvips/libvips/releases/download/v${VIPS_VERSION}
ARG VIPS_URL=http://www.rollthepotato.net/~john

RUN wget -O- ${VIPS_URL}/vips-${VIPS_VERSION}.tar.gz | tar xzC /tmp
RUN cd /tmp/vips-${VIPS_VERSION} \
	&& ./configure --prefix=/usr \
	&& make V=0 \
	&& make install 

# there are other optional deps you can add for openslide / openexr /
# imagmagick support / Matlab support etc etc

# php7 dev environment 
RUN apk add \
	gdb \
	php7-dev \
	autoconf

ARG PHP_VIPS_VERSION=1.0.10

RUN wget -O- https://pecl.php.net/get/vips-$PHP_VIPS_VERSION.tgz | tar xzC /tmp

RUN cd /tmp/vips-$PHP_VIPS_VERSION \
	&& phpize7 \
	&& ./configure --prefix=/usr --with-php-config=php-config7 \
	&& make \
	&& NO_INTERACTION=1 REPORT_EXIT_STATUS=1 SKIP_ONLINE_TESTS=1 make test

# and enable
RUN echo "extension=vips.so" > /etc/php7/conf.d/00_vips.ini
