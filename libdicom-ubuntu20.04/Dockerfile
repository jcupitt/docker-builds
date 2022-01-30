FROM ubuntu:focal

# non-interactive debconf
ENV DEBIAN_FRONTEND=noninteractive

# basic stuff ... we build from git master, so we need more packages
# than just a tarball
RUN apt-get update \
  && apt-get install -y \
    build-essential \
    autoconf \
    automake \
    pkg-config \
    libtool 

# build everything to this prefix
ENV PREFIX=/usr/local/libdicom

ENV PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig \
  LD_LIBRARY_PATH=$PREFIX/lib \
  PATH=$PATH:$PREFIX/bin \
  WORKDIR=/usr/local/src

WORKDIR $WORKDIR/libdicom

COPY libdicom .

RUN ./autogen.sh --prefix $PREFIX \
  && make V=0 \
  && make install

