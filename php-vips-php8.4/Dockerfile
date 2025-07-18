FROM php:8.4-fpm

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends \
	software-properties-common \
	postgresql-client \
	libzip-dev \
	libicu-dev \
	libonig-dev \
	libxml2-dev \
	zlib1g-dev \
	libcurl4-openssl-dev \
	libffi-dev \
	libpq-dev

RUN docker-php-ext-install \
    intl \
    mbstring \
    curl \
    xml \
    bcmath \
    pdo \
    pdo_pgsql \
    soap \
    zip \
    ffi

# php-vips doesn't need libvips-dev, just the shared library
RUN apt-get install -y --no-install-recommends \
    libvips42 

# install composer
RUN curl -sS https://getcomposer.org/installer \
    | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /data
