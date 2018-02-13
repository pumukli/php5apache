# php 7.2 apache httpd

FROM php:7-apache

MAINTAINER Márton Róbert <robert.marton@dlms.com>

RUN docker-php-ext-install mysqli pdo_mysql bcmath calendar ctype dba dom enchant exif fileinfo filter ftp gd \
    && gettext gmp hash iconv imap intl json ldap mbstring opcache pcntl pdo pdo_dblib \
    && pdo_odbc phar reflection session soap sockets spl standard \
    && zip
    
RUN pecl install xdebug \
 && docker-php-ext-enable xdebug
 
RUN echo "xdebug.remote_enable=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
 && echo "xdebug.remote_autostart=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
 && echo "xdebug.idekey=netbeans-xdebug" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
 && echo "date.timezone = Europe/Budapest" > /usr/local/etc/php/conf.d/timezone.ini

CMD ["/usr/sbin/init"]
