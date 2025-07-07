# Use the official PHP 8.4 FPM Alpine image as the base image
FROM php:8.4-fpm-alpine

# Set maintainer information
LABEL maintainer="MD Masud Sikdar <masudsikdar85@gmail.com>"

# Define environment variables for PECL and PHP extensions
ENV PECL_EXTENSIONS="pcov"
ENV PHP_EXTENSIONS="bz2 exif gd gettext intl mysqli opcache pcntl pdo pdo_mysql zip"

# Install necessary dependencies and development tools
RUN apk add --no-cache --virtual .build-deps \
    $PHPIZE_DEPS libtool bzip2-dev gettext-dev icu-dev libpng-dev libzip-dev \
    krb5-dev curl-dev \
    && apk add --no-cache git icu libintl mysql-client unzip wget bash \
    && docker-php-source extract \
    && pecl channel-update pecl.php.net \
    && pecl install $PECL_EXTENSIONS \
    && docker-php-ext-enable $PECL_EXTENSIONS \
    && docker-php-ext-configure opcache --enable-opcache \
    && docker-php-ext-install -j"$(nproc)" $PHP_EXTENSIONS \
    && docker-php-source delete

# Copy Composer binary from the official Composer image
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set the working directory
WORKDIR /var/www/html

# Switch to non-root user for security
USER www-data
