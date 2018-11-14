# build with
#    docker build -t alpine-openslide-libvips:latest alpine-openslide-libvips

# run with
#    docker run -it alpine-openslide-libvips vips

# debug with
#    docker run \
#       --cap-add=SYS_PTRACE \
#       --security-opt seccomp=unconfined \
#       -it alpine-openslide-libvips bash
#    apk add gdb glib-dbg
#    gdb vips

FROM alpine:latest

ARG OPENSLIDE_VERSION=3.4.1
ARG OPENSLIDE_URL=https://github.com/openslide/openslide/releases/download

ARG VIPS_VERSION=8.6.3
ARG VIPS_URL=https://github.com/jcupitt/libvips/releases/download

RUN apk update && apk upgrade

RUN apk add build-base \
	autoconf \
	automake \
	libtool \
	bc \
	zlib-dev \
	libxml2-dev \
	jpeg-dev \
	openjpeg-dev \
	tiff-dev \
	glib-dev \
	gdk-pixbuf-dev \
	sqlite-dev \
	libjpeg-turbo-dev \
	libexif-dev \
	lcms2-dev \
	fftw-dev \
	giflib-dev \
	libpng-dev \
	libwebp-dev \
	orc-dev \
	poppler-dev \
	librsvg-dev \
	libgsf-dev \
	openexr-dev \
	gtk-doc

COPY openslide-init.patch /tmp

RUN wget -O- ${OPENSLIDE_URL}/v${OPENSLIDE_VERSION}/openslide-${OPENSLIDE_VERSION}.tar.gz | tar xzC /tmp
RUN cd /tmp \
	&& patch -p0 </tmp/openslide-init.patch \
        && cd openslide-${OPENSLIDE_VERSION} \
	&& ./configure --prefix=/usr --disable-static \
	&& make \
	&& make install 

RUN wget -O- ${VIPS_URL}/v${VIPS_VERSION}/vips-${VIPS_VERSION}.tar.gz | tar xzC /tmp
RUN cd /tmp/vips-${VIPS_VERSION} \
	&& ./configure --prefix=/usr --disable-static --disable-debug \
	&& make V=0 \
	&& make install 

RUN cd /tmp/vips-${VIPS_VERSION} \
	&& make check \
	|| cat test/test-suite.log
