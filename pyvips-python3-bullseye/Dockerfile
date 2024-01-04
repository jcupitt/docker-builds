FROM python:3.11-slim-bullseye

RUN apt-get update && apt-get install -y \
	build-essential \
	pkg-config \
	wget

# use the precompiled libvips binaries packaged by kleis
ARG VIPS_VERSION=8.15.0
ARG VIPS_URL=https://github.com/kleisauke/libvips-packaging/releases/download
ARG PREFIX=/usr/local

WORKDIR /usr/local/src

RUN wget $VIPS_URL/v$VIPS_VERSION/libvips-$VIPS_VERSION-linux-x64.tar.gz

RUN tar xf libvips-$VIPS_VERSION-linux-x64.tar.gz \
	&& cp -r include/* $PREFIX/include \
	&& cp -r lib/* $PREFIX/lib \
	&& ln -s $PREFIX/lib/libvips.so.42 $PREFIX/lib/libvips.so

RUN echo "prefix=$PREFIX" >> $PREFIX/lib/pkgconfig/vips.pc \
 && echo "includedir=\${prefix}/include" >> $PREFIX/lib/pkgconfig/vips.pc \
 && echo "libdir=\${prefix}/lib" >> $PREFIX/lib/pkgconfig/vips.pc \
 && echo "Name: vips" >> $PREFIX/lib/pkgconfig/vips.pc \
 && echo "Description: Image processing library" >> $PREFIX/lib/pkgconfig/vips.pc \
 && echo "Version: $VIPS_VERSION" >> $PREFIX/lib/pkgconfig/vips.pc \
 && echo "Libs: -L\${libdir} -lvips" >> $PREFIX/lib/pkgconfig/vips.pc \
 && echo "Cflags: -I\${includedir} -I\${includedir}/glib-2.0 -I\${libdir}/glib-2.0/include" >> $PREFIX/lib/pkgconfig/vips.pc 

RUN apt-get install -y python3-dev python3-pip

RUN pip3 install pyvips 

WORKDIR /data


