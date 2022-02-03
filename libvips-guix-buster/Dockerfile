FROM ubuntu:21.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update \
  && apt-get -y install \
    apt-utils \
    build-essential \
    pkg-config \
    wget 

# guix must have ncsd for NSS lookup or you can get crashes with glibc version
# conflicts
RUN apt-get -y install nscd libnss3-tools 

WORKDIR /usr/local/src
ARG GUIX_URL=https://git.savannah.gnu.org/cgit/guix.git

RUN wget $GUIX_URL/plain/etc/guix-install.sh \
  && chmod +x guix-install.sh \
  && yes | ./guix-install.sh

# link guix i18n to host i18n
RUN guix install glibc-locales
ENV GUIX_LOCPATH=$HOME/.guix-profile/lib/locale

# guix must have its own font system
RUN guix install fontconfig \
  && fc-cache -rv

RUN guix-install build -f libvips.scm
