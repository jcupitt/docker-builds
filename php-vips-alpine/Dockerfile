# build with
#    docker pull alpine:latest
#    docker build -t php-vips-alpine:latest .

# run with
#    docker run -it php-vips-alpine irb

FROM alpine:latest

ARG VIPS_VERSION=8.8.3
ARG VIPS_URL=https://github.com/libvips/libvips/releases/download

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

RUN wget -O- ${VIPS_URL}/v${VIPS_VERSION}/vips-${VIPS_VERSION}.tar.gz | tar xzC /tmp
RUN cd /tmp/vips-${VIPS_VERSION} \
	&& ./configure --prefix=/usr --disable-static --disable-debug \
	&& make V=0 \
	&& make install 

# there are other optional deps you can add for openslide / openexr /
# imagmagick support / Matlab support etc etc

# php7 dev environment .. you need openssl so pecl can download packages
RUN apk add \
	php7-dev \
	php7-pear \
	php7-openssl

RUN PKG_CONFIG_PATH=/usr/local/lib/pkgconfig pecl install vips

# and enable
RUN echo "extension=vips.so" > /etc/php7/conf.d/00_vips.ini
