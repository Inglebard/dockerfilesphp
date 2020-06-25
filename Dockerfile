FROM php:7.2-fpm
RUN apt-get update && apt-get install -y \
        libicu-dev\
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
	&& docker-php-ext-configure gd -with-freetype-dir=/usr --with-jpeg-dir=/usr --with-png-dir=/usr \
	&& docker-php-ext-install -j$(nproc) gd \
	&& docker-php-ext-configure intl \
	&& docker-php-ext-install intl \
	&& docker-php-ext-install exif \
	&& docker-php-ext-install -j$(nproc) iconv \
	&& docker-php-ext-install opcache \
	&& docker-php-ext-install mysqli \
	&& docker-php-ext-install pdo pdo_mysql

ENV WWW_USER_ID=1000
ENV WWW_GROUP_ID=1000

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/bin/sh", "-c", "/entrypoint.sh"]
