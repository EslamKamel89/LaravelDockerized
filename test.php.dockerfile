FROM php:8.2-fpm-alpine

# Use ARGs for UID/GID
ARG UID=1000
ARG GID=1000

# Install required packages
RUN apk add --no-cache shadow

# Stop FPM before changing UID
RUN rc-service php-fpm8 stop || true

# Create group if needed
RUN if getent group ${GID}; then \
    group_name=$(getent group ${GID} | cut -d: -f1); \
    useradd -u ${UID} -g ${GID} -s /bin/sh -D www; \
    else \
    addgroup -g ${GID} www; \
    adduser -u ${UID} -G www -s /bin/sh -D www; \
    fi

# Change ownership of Laravel directory
RUN mkdir -p /var/www/html && \
    chown -R www:www /var/www/html

# Set user/group in PHP-FPM config
RUN sed -i "s/user = www-data/user = www/" /usr/local/etc/php-fpm.d/www.conf && \
    sed -i "s/group = www-data/group = www/" /usr/local/etc/php-fpm.d/www.conf

# Set working dir
WORKDIR /var/www/html

# Install extensions
RUN docker-php-ext-install pdo pdo_mysql

