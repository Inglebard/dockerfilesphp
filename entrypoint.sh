#!/bin/sh

usermod -u $WWW_USER_ID www-data
groupmod -g $WWW_GROUP_ID www-data


echo "$(hostname -i)\t$(hostname) $(hostname).localhost" >> /etc/hosts

service sendmail start &
php-fpm
