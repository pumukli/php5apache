FROM centos:7.0.1406
MAINTAINER Márton Róbert <robert.marton@gmail.com>
RUN docker-php-ext-install mysqli pdo_mysql
RUN pecl install xdebug \
 && docker-php-ext-enable xdebug
RUN echo "xdebug.remote_enable=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
 && echo "xdebug.remote_autostart=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
 && echo "xdebug.idekey=netbeans-xdebug" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
 && echo "date.timezone = Europe/Budapest" > /usr/local/etc/php/conf.d/timezone.ini
