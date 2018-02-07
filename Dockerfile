# php 7.2 apache httpd

FROM centos:7.0.1406
MAINTAINER Márton Róbert <robert.marton@gmail.com>

# install apache
RUN yum -y install httpd
RUN systemctl start httpd.service 
RUN systemctl enable httpd.service

RUN firewall-cmd --permanent --zone=public --add-service=http 
RUN firewall-cmd --permanent --zone=public --add-service=https 
RUN firewall-cmd --reload

# install php
RUN rpm -Uvh http://rpms.remirepo.net/enterprise/remi-release-7.rpm
RUN yum -y install yum-utils
RUN yum update

RUN yum-config-manager --enable remi-php72
RUN yum -y install php php-opcache php-gd php-pdo php-mysqli php-mcrypt php-ldap php-odbc php-pear php-xml php-xmlrpc php-mbstring php-soap curl curl-devel

# configure php
RUN echo "date.timezone = Europe/Budapest" > /usr/local/etc/php/conf.d/timezone.ini

# restart apache
RUN systemctl restart httpd.service
