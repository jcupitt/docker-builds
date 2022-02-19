# syntax=docker/dockerfile:1.3.1-labs
FROM debian:experimental AS builder

ENV VIPS_VERSION="8.12.2"
ENV VIPS_URL="https://github.com/libvips/libvips/releases/download/v${VIPS_VERSION}/vips-${VIPS_VERSION}.tar.gz"

ENV LIBSPNG_VERSION="0.7.2"
ENV LIBSPNG_URL="https://github.com/randy408/libspng/archive/refs/tags/v${LIBSPNG_VERSION}.tar.gz"

ENV PDFIUM_VERSION="4888"
ENV PDFIUM_URL="https://github.com/bblanchon/pdfium-binaries/releases/download/chromium/${PDFIUM_VERSION}/pdfium-linux-x64.tgz"

ENV STATICX_VERSION="0.13.6"

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    ca-certificates \
  && rm -rf /var/lib/apt/lists/*

RUN echo "deb [check-valid-until=no] https://snapshot.debian.org/archive/debian/20220101 experimental main contrib non-free" \
  >> /etc/apt/sources.list

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    file \
    libcfitsio-dev \
    libcgif-dev \
    libexif-dev \
    libexpat1-dev \
    libfftw3-dev \
    libglib2.0-dev \
    libgsf-1-dev \
    libheif-dev \
    libimagequant-dev \
    libjpeg62-turbo-dev \
    libjxl-dev=0.6.1+ds-5 \
    liblcms2-dev \
    libmagick++-6.q16-dev \
    libmatio-dev \
    libnifti2-dev \
    libopenexr-dev \
    libopenjp2-7-dev \
    libopenslide-dev \
    liborc-0.4-dev \
    libpango1.0-dev \
    libpng-dev \
    librsvg2-dev \
    libtiff-dev \
    libwebp-dev \
    make \
    meson \
    patchelf \
    pkg-config \
    python3-minimal \
    python3-pip \
    python3-setuptools \
  && rm -rf /var/lib/apt/lists/*

RUN pip3 install "staticx==${STATICX_VERSION}"

WORKDIR /build-libspng
RUN curl -L "${LIBSPNG_URL}" | tar -xzf- --strip=1
RUN meson build --buildtype=release

WORKDIR /build-libspng/build
RUN ninja
RUN ninja install

WORKDIR /usr
RUN curl -L "${PDFIUM_URL}" | tar -xzf- include
RUN curl -L "${PDFIUM_URL}" | tar -xzf- --strip=1 -C lib/x86_64-linux-gnu lib/libpdfium.so

RUN mkdir -p lib/pkgconfig \
  && echo "prefix=/usr" >> lib/pkgconfig/pdfium.pc \
  && echo "exec_prefix=\${prefix}" >> lib/pkgconfig/pdfium.pc \
  && echo "libdir=\${exec_prefix}/lib" >> lib/pkgconfig/pdfium.pc \
  && echo "includedir=\${prefix}/include" >> lib/pkgconfig/pdfium.pc \
  && echo "Name: pdfium" >> lib/pkgconfig/pdfium.pc \
  && echo "Description: pdfium" >> lib/pkgconfig/pdfium.pc \
  && echo "Version: $PDFIUM_VERSION" >> lib/pkgconfig/pdfium.pc \
  && echo "Requires: " >> lib/pkgconfig/pdfium.pc \
  && echo "Libs: -L\${libdir} -lpdfium" >> lib/pkgconfig/pdfium.pc \
  && echo "Cflags: -I\${includedir}" >> lib/pkgconfig/pdfium.pc

WORKDIR /build-vips
RUN curl -L "${VIPS_URL}" | tar -xzf- --strip=1
ENV CFLAGS="-O2 -flto -pipe"
ENV CXXFLAGS="-O2 -flto -pipe"
RUN ./configure \
  --disable-dependency-tracking \
  --disable-deprecated \
  --disable-gtk-doc \
  --disable-shared \
  --disable-static

WORKDIR /build-vips/libvips
RUN make -j"$(nproc)"

WORKDIR /build-vips/tools
RUN make -j"$(nproc)" vips
RUN staticx --no-compress vips /bin/vips
RUN strip -s /bin/vips

FROM scratch

LABEL org.opencontainers.image.authors="whalehub <admin@datahoarder.dev>"
LABEL org.opencontainers.image.description="A fast image processing library with low memory needs."
LABEL org.opencontainers.image.documentation="https://github.com/whalehub/libvips-static"
LABEL org.opencontainers.image.licenses="GPL-3.0"
LABEL org.opencontainers.image.source="https://github.com/whalehub/libvips-static"
LABEL org.opencontainers.image.title="libvips"
LABEL org.opencontainers.image.url="https://github.com/whalehub/libvips-static"
LABEL org.opencontainers.image.vendor="whalehub <admin@datahoarder.dev>"
LABEL org.opencontainers.image.version="8.12.2"

COPY --from=builder /bin/vips /vips
