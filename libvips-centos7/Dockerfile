FROM centos:centos7

# yum-plugin-ovl helps yum work with the docker overlay filesystem 
RUN yum update -y \
    && yum -y install yum-plugin-ovl

# general build stuff 
RUN yum groupinstall -y "Development Tools" \
    && yum install -y wget tar

# openslide is in epel
RUN yum install -y \
    https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN yum install -y \
    openslide-devel

# stuff we need to build our own libvips ... this is a pretty basic selection
# of dependencies, you'll want to adjust these
RUN yum install -y \
    # gtk-doc \
    glib2-devel \
    orc-devel \
    expat-devel \
    zlib-devel \
    libjpeg-devel \
    libpng-devel \
    libtiff-devel \
    libexif-devel \
    libgsf-devel \
    libgif-devel

WORKDIR /usr/local/src

# install libwebp
ARG WEBP_VERSION=1.1.0
ARG WEBP_URL=https://storage.googleapis.com/downloads.webmproject.org/releases/webp
RUN wget ${WEBP_URL}/libwebp-${WEBP_VERSION}.tar.gz \
    && tar xzf libwebp-${WEBP_VERSION}.tar.gz \
    && cd libwebp-${WEBP_VERSION} \
    && ./configure --enable-libwebpmux --enable-libwebpdemux \
    && make V=0 \
    && make install

# install libheif
RUN yum install -y https://download1.rpmfusion.org/free/el/updates/7/x86_64/l/libde265-1.0.2-6.el7.x86_64.rpm \
    && yum install -y https://download1.rpmfusion.org/free/el/updates/7/x86_64/x/x265-libs-2.9-3.el7.x86_64.rpm \
    && yum install -y https://download1.rpmfusion.org/free/el/updates/7/x86_64/l/libheif-1.3.2-2.el7.x86_64.rpm \
    && yum install -y https://download1.rpmfusion.org/free/el/updates/7/x86_64/l/libheif-devel-1.3.2-2.el7.x86_64.rpm


ARG VIPS_VERSION=8.10.5
ARG VIPS_URL=https://github.com/libvips/libvips/releases/download

# so libvips picks up our new libwebp
ENV PKG_CONFIG_PATH /usr/local/lib/pkgconfig
# so your app can open shared object file of libvips.so.42
ENV LD_LIBRARY_PATH /usr/local/lib

RUN wget ${VIPS_URL}/v${VIPS_VERSION}/vips-${VIPS_VERSION}.tar.gz \
    && tar xzf vips-${VIPS_VERSION}.tar.gz \
    && cd vips-${VIPS_VERSION} \
    && ./configure \
    && make V=0 \
    && make install
