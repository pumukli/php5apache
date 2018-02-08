# php 7.2 apache httpd

FROM centos:7
ENV container docker
MAINTAINER Márton Róbert <robert.marton@gmail.com>

RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
VOLUME [ "/sys/fs/cgroup" ]
CMD ["/usr/sbin/init"]

# install apache
RUN yum -y install httpd; yum clean all; systemctl enable httpd.service

EXPOSE 80

# install php
#RUN rpm -Uvh http://rpms.remirepo.net/enterprise/remi-release-7.rpm
RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN yum -y install yum-utils
RUN yum -y update

RUN yum -y install curl curl-devel php72 php72-cli php72-common php72-devel php72-gd php72-bcmath php72-imap php72-json php72-ldap php72-mbstring php72-mysqlnd php72-pdo php72-dblib php72-soap php72-xml php72-xmlrpc php72-opcache

#RUN yum-config-manager --enable remi-php72
#RUN yum -y install php72 php72-opcache php-gd php-pdo php-mysqli php-mcrypt php-ldap php-odbc php-pear php-xml php-xmlrpc php-mbstring php-soap curl curl-devel

# configure php
#RUN echo "date.timezone = Europe/Budapest" > /usr/local/etc/php/conf.d/timezone.ini

CMD ["/usr/sbin/init"]
