FROM php:8.2-fpm-alpine

RUN mkdir -p /var/www/html

# this line below is used to resolve permissions issue that some times appear when writing to files
# if you attached an interactive shell to the PHP_FPM container and run the command `/usr/local/etc/php-fpm.d # cat www.conf`
# you will find the following `user = www-data & group = www-data`. i think with the command below
# we are installing shadow then enabling the same user as the configration so there wont' be permission issues

RUN apk --no-cache add shadow && usermod -u 1000 www-data

RUN docker-php-ext-install pdo pdo_mysql