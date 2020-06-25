#!/bin/sh

usermod -u $WWW_USER_ID www-data
groupmod -g $WWW_GROUP_ID www-data


php-fpm
