FROM httpd:alpine

ADD ./apache/httpd-vhosts.conf /usr/local/apache2/conf/extra/httpd-vhosts.conf
ADD ./apache/httpd.conf /usr/local/apache2/conf/httpd.conf

# RUN sed -i 's,#Include /usr/local/apache2/conf/extra/httpd-vhosts.conf,Include /usr/local/apache2/conf/extra/httpd-vhosts.conf,g' /usr/local/apache2/conf/httpd.conf

RUN mkdir -p /var/www/html