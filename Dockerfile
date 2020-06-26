FROM php:7.0-fpm
RUN apt-get update && apt-get install -y \
        libicu-dev\
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
	      libmcrypt-dev \
        libxml2-dev \
        libjpeg-dev \
	&& docker-php-ext-configure gd -with-freetype-dir=/usr --with-jpeg-dir=/usr --with-png-dir=/usr \
	&& docker-php-ext-configure intl \
	&& docker-php-ext-install -j$(nproc) gd iconv mcrypt iconv mcrypt intl exif opcache pdo_mysql soap mysqli zip gettext calendar bcmath \
  && rm -rf /var/lib/apt/lists/*

ENV WWW_USER_ID=1000
ENV WWW_GROUP_ID=1000

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/bin/sh", "-c", "/entrypoint.sh"]
