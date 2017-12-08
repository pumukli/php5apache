FROM centos:7.0.1406
MAINTAINER Márton Róbert <robert.marton@gmail.com>
RUN yum install php php-gd php-mcrypt php-mysqli
RUN echo "date.timezone = Europe/Budapest" > /usr/local/etc/php/conf.d/timezone.ini
