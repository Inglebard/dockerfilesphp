FROM ubuntu:16.04

SHELL ["/bin/bash", "-c"]

RUN apt-get update && apt-get install -y \
        php-fpm\
        php-gd \
        php-intl \
        php-exif \
	      php-soap \
        php-zip \
        php-mysql \
        php-bcmath \
        php-mysql \
        php-mcrypt \
        php-curl \
        php-json \
        php-mbstring \
        php-xml \
        php-sqlite3 \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/php && mkdir -p /var/www/html
RUN ln -sf /usr/sbin/php-fpm7.0 /usr/sbin/php-fpm

RUN echo -e $'\
[global]\n\
error_log = /proc/self/fd/2\n\
\n\
[www]\n\
; if we send this to /proc/self/fd/1, it never appears\n\
access.log = /proc/self/fd/2\n\
\n\
clear_env = no\n\
\n\
; Ensure worker stdout and stderr are sent to the main error log.\n\
catch_workers_output = yes' > /etc/php/7.0/fpm/pool.d/docker.conf

RUN echo -e $'\
[global]\n\
daemonize = no\n\
\n\
[www]\n\
listen = 9000' > /etc/php/7.0/fpm/pool.d/zz-docker.conf




ENV WWW_USER_ID=1000
ENV WWW_GROUP_ID=1000

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/bin/sh", "-c", "/entrypoint.sh"]
