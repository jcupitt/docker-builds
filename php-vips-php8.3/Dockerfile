FROM ubuntu:jammy

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install -y software-properties-common

RUN add-apt-repository -y ppa:ondrej/php \
	&& apt-get update -y 

RUN apt-get install -y \
	php8.3 \
	php8.3-cli \
	php8.3-fpm \
	php8.3-{mysql,curl,xsl,gd,common,xml,zip,xsl,soap,bcmath,mbstring,gettext} \
	composer 

RUN apt install -y libvips42 --no-install-recommends

WORKDIR /data
