FROM php:8.2.8-apache-bookworm

# Install all dependencies required to build, install, and enable
# PHP extensions: gd, mysqli, imap, apcu, opcache, and zip.
RUN a2enmod rewrite \
    && service apache2 restart \
    && apt-get update \
    && apt-get install -y \
        git \
        zlib1g-dev libpng-dev libjpeg-dev \
        libc-client2007e-dev libkrb5-dev \
        libzip-dev \
    && pecl install apcu-5.1.22 \
    && docker-php-ext-configure gd --with-jpeg \
    && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-install gd mysqli imap opcache zip \
    && docker-php-ext-enable gd mysqli imap apcu opcache zip \
    && mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

COPY . /web
