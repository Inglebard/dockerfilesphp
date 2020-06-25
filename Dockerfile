FROM php:7.0-fpm
RUN apt-get update && apt-get install -y \
        libicu-dev\
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
	libmcrypt-dev \
	&& docker-php-ext-configure gd --with-freetype --with-jpeg \
	&& docker-php-ext-install -j$(nproc) gd iconv mcrypt \
	&& docker-php-ext-configure intl \
	&& docker-php-ext-install intl \
	&& docker-php-ext-install exif \
	&& docker-php-ext-install -j$(nproc) iconv mcrypt \
	&& docker-php-ext-install opcache \
	&& docker-php-ext-install pdo_mysql

ENV WWW_USER_ID=1000
ENV WWW_GROUP_ID=1000

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/bin/sh", "-c", "/entrypoint.sh"]
