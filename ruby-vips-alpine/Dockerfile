# build with
#    docker pull alpine:latest
#    docker build -t ruby-vips-alpine:latest .

# run with
#    docker run -it --rm -v $PWDG

FROM alpine:latest

ARG VIPS_VERSION=8.9.1
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

# text rendering ... we have to download some fonts and rebuild the font
# cache
RUN apk add \
	pango-dev \
	msttcorefonts-installer
RUN update-ms-fonts \
	&& fc-cache -f

# add these for PDF rendering and SVG rendering, but they will pull in 
# loads of other stuff
RUN apk add \
	poppler-dev \
	librsvg-dev 

# there are other optional deps you can add for openslide / openexr /
# imagmagick support / Matlab support etc etc

# installing to /usr is not the best idea, but it's easy
RUN wget -O- ${VIPS_URL}/v${VIPS_VERSION}/vips-${VIPS_VERSION}.tar.gz | tar xzC /tmp
RUN cd /tmp/vips-${VIPS_VERSION} \
	&& ./configure --prefix=/usr --disable-static --disable-debug \
	&& make V=0 \
	&& make install 

RUN apk add \
	ruby-dev \
	ruby-irb
RUN gem install rdoc \
	ruby-vips
