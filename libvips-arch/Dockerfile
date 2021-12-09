FROM archlinux:base

# build packages
RUN pacman -Sy --noconfirm \
	base-devel \
	git \
	wget 

# packages needed for makepkg vips ... we can't just use "makepkg -si" sadly,
# since we must run makepkg as a plain user
# still missing: matio openslide 
#RUN pacman -S --noconfirm \
#	cfitsio \
#	fftw \
#	imagemagick \
#	lcms2 \
#	libexif \
#	libgsf \
#	libheif \
#	libimagequant \
#	libjpeg-turbo \
#	libpng \
#	librsvg \
#	libtiff \
#	libwebp \
#	openexr \
#	orc \
#	pango \
#	poppler-glib 

RUN pacman -S --noconfirm \
	fftw \
	libexif \
	libgsf \
	libheif \
	libimagequant \
	libjpeg-turbo \
	libpng \
	libtiff \
	orc 

ARG VIPS_VERSION=8.12.1
ARG VIPS_URL=https://github.com/libvips/libvips/releases/download
ENV VIPSHOME /usr/local/vips

ENV PKG_CONFIG_PATH $VIPSHOME/lib/pkgconfig

RUN cd /usr/local/src \
	&& wget ${VIPS_URL}/v${VIPS_VERSION}/vips-${VIPS_VERSION}.tar.gz \
	&& tar xf vips-${VIPS_VERSION}.tar.gz \
	&& cd vips-${VIPS_VERSION} \
	&& ./configure --enable-static --prefix=$VIPSHOME \
		--enable-introspection=no \
		--without-magick \
		--without-lcms \
		--without-OpenEXR \
		--without-nifti \
		--without-pdfium \
		--without-rsvg \
		--without-matio \
		--without-libwebp \
		--without-cfitsio \
		--without-zlib \
		--without-poppler \
		--without-pangoft2 \
		--without-openslide \
	&& make V=0 \
	&& make install

#RUN git clone https://aur.archlinux.org/vips.git \
#	&& cd vips \
#	&& makepkg -s
