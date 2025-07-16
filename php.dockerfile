FROM php:8.2-fpm-alpine

RUN mkdir -p /var/www/html
# WORKDIR /var/www/html

# this line below is used to resolve permissions issue that some times appear when writing to files
# if you attached an interactive shell to the PHP_FPM container and run the command `/usr/local/etc/php-fpm.d # cat www.conf`
# you will find the following `user = www-data & group = www-data`. i think with the command below
# we are installing shadow then enabling the same user as the configration so there wont' be permission issues
# production only
RUN apk --no-cache add shadow && usermod -u 1000 www-data

# devolpemnt only
# Install shadow utils
# RUN apk --no-cache add shadow

# devolpemnt only
# Stop FPM before modifying user
RUN rc-service php-fpm8 stop || true

# devlopemnt only 
# Change the user PHP-FPM runs as to root
# RUN usermod -u 0 www-data && \
#     groupmod -g 0 www-data

# devolpment only
# Set www-data as the default user
# USER www-data

# devolpemnt and production
# Install extensions
RUN docker-php-ext-install pdo pdo_mysql

# devolpment only
# Fix permissions inside the container
# RUN chown -R www-data:www-data /var/www/html && \
#     chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache
