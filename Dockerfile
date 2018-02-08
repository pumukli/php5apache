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
RUN yum update

RUN yum -y install php72.x86_64 php72-php-cli.x86_64 php72-php-common.x86_64 php72-php-devel.x86_64 php72-php-gd.x86_64 php72-php-bcmath.x86_64 php72-php-imap.x86_64 php72-php-json.x86_64 php72-php-ldap.x86_64 php72-php-mbstring.x86_64 php72-php-mysqlnd.x86_64 php72-php-pdo.x86_64 php72-php-pdo-dblib.x86_64 php72-php-soap.x86_64 php72-php-xml.x86_64 php72-php-xmlrpc.x86_64 php72-php-opcache.x86_64

#RUN yum-config-manager --enable remi-php72
#RUN yum -y install php72 php72-opcache php-gd php-pdo php-mysqli php-mcrypt php-ldap php-odbc php-pear php-xml php-xmlrpc php-mbstring php-soap curl curl-devel

# configure php
RUN echo "date.timezone = Europe/Budapest" > /usr/local/etc/php/conf.d/timezone.ini

CMD ["/usr/sbin/init"]
