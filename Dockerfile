# php 7.2 apache httpd

FROM php:7-apache

MAINTAINER Márton Róbert <robert.marton@dlms.com>

RUN apt-get update && apt-get install -y \
		curl \
		libedit2 \
		libsqlite3-0 \
		libxml2 \
		xz-utils \
	--no-install-recommends && rm -r /var/lib/apt/lists/*

RUN docker-php-ext-install mysqli pdo_mysql bcmath calendar ctype curl dba dom enchant exif fileinfo filter ftp gd \
    && gettext gmp hash iconv imap interbase intl json ldap mbstring oci8 odbc opcache pcntl pdo pdo_dblib pdo_firebird \
    && pdo_oci pdo_odbc pdo_pgsql pdo_sqlite pgsql phar \
    && reflection session simplexml soap sockets spl standard \
    && xml xmlreader xmlrpc xmlwriter xsl zip
RUN pecl install xdebug \
 && docker-php-ext-enable xdebug
RUN echo "xdebug.remote_enable=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
 && echo "xdebug.remote_autostart=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
 && echo "xdebug.idekey=netbeans-xdebug" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
 && echo "date.timezone = Europe/Budapest" > /usr/local/etc/php/conf.d/timezone.ini

CMD ["/usr/sbin/init"]
