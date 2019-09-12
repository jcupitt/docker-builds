FROM archlinux/base:latest

# build packages
RUN pacman -Sy --noconfirm \
	base-devel \
	git \
	wget 

# packages needed for makepkg vips ... we can't just use "makepkg -si" sadly,
# since we must run makepkg as a plain user
# still missing: matio openslide 
RUN pacman -S --noconfirm \
	cfitsio \
	fftw \
	imagemagick \
	lcms2 \
	libexif \
	libgsf \
	libheif \
	libimagequant \
	libjpeg-turbo \
	libpng \
	librsvg \
	libtiff \
	libwebp \
	openexr \
	orc \
	pango \
	poppler-glib 

ARG VIPS_VERSION=8.8.2
ARG VIPS_URL=https://github.com/libvips/libvips/releases/download
ENV VIPSHOME /usr/local/vips

ENV PKG_CONFIG_PATH $VIPSHOME/lib/pkgconfig

RUN cd /usr/local/src \
	&& wget ${VIPS_URL}/v${VIPS_VERSION}/vips-${VIPS_VERSION}.tar.gz \
	&& tar xf vips-${VIPS_VERSION}.tar.gz \
	&& cd vips-${VIPS_VERSION} \
	&& ./configure --prefix=$VIPSHOME \
	&& make V=0 \
	&& make install

#RUN git clone https://aur.archlinux.org/vips.git \
#	&& cd vips \
#	&& makepkg -s
