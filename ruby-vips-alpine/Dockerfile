# build with
#    docker build -t ruby-vips-alpine:latest .

# run with
#    docker run -it ruby-vips-alpine irb

FROM alpine:latest

ARG VIPS_VERSION=8.7.0
ARG VIPS_URL=https://github.com/libvips/libvips/releases/download

RUN apk update && apk upgrade

# basic packages libvips likes
RUN apk add \
	build-base \
	autoconf \
	automake \
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

# there are other optional deps you can add for openslide / openexr /
# imagmagick support / Matlab support etc etc

RUN wget -O- ${VIPS_URL}/v${VIPS_VERSION}/vips-${VIPS_VERSION}.tar.gz | tar xzC /tmp
RUN cd /tmp/vips-${VIPS_VERSION} \
	&& ./configure --prefix=/usr --disable-static --disable-debug \
	&& make V=0 \
	&& make install 

RUN apk add \
	ruby-dev \
	ruby-irb

# for some reason rdoc install fails ... ignore the error
RUN gem install rdoc || exit 0

# and now ruby-vips can go on
RUN gem install ruby-vips
