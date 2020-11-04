#!/bin/sh

usermod -u $WWW_USER_ID www-data
groupmod -g $WWW_GROUP_ID www-data

final_mail_domain="$(hostname).localhost"
if [ ! -z "$MAIL_DOMAIN" ]
then
      final_mail_domain=$MAIL_DOMAIN
fi


echo "$(hostname -i)\t$(hostname) $final_mail_domain" >> /etc/hosts

service sendmail start &
php-fpm
