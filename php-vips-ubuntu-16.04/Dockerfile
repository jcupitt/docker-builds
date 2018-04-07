FROM ubuntu:xenial

RUN \
  apt-get update && \
  apt-get install -y \
    build-essential \
    libvips-dev \
    nginx \
    php7.0-dev \
    php-pear

RUN \
  pecl install vips

RUN \
  apt-get install -y \
    composer

# enable vips at the cli
RUN \
  echo "extension=vips.so" > /etc/php/7.0/mods-available/vips.ini && \
  ln -s /etc/php/7.0/mods-available/vips.ini \
  	/etc/php/7.0/cli/conf.d/20-vips.ini

WORKDIR /data
COPY . /data

RUN \
	composer install 
