FROM composer:latest as composer

FROM bdeuffic/alpine-php8-dev-base

# Install packages
RUN apk update \
    && \
    # apt Debian packages
    apk add \
        nano \
        postgresql-dev \
        libjpeg-turbo-utils \
        advancecomp \
        optipng \
        bash \
        util-linux \
        openssh \
        mysql \
    && \
    # Install PHP extensions
    docker-php-ext-install \
        pdo_mysql \
        pdo_pgsql \
    && \
    # Install Composer
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer

COPY --from=composer  /usr/bin/composer /usr/local/bin/composer

#RUN composer global require hirak/prestissimo --no-plugins --no-scripts

ENV PATH=/var/www/app/vendor/bin:$PATH
ENV COMPOSER_MEMORY_LIMIT=-1


WORKDIR /var/www/app

CMD ln -s /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini

# Do a `composer install` without running any Composer scripts
# - If `composer.lock` is present, it will install what is in the lock file
# - If `composer.lock` is missing, it will update to the latest dependencies
#   and create the `composer.lock` file
# Force permissions, composer update , and start php-fpm
#CMD if [ ! -f "./composer.lock" ]; then \
#        composer install --no-scripts --optimize-autoloader --no-interaction; \
#    fi \
#    && \
#    if [ ! -d ./vendor -o ! "$(ls -A ./vendor)" ]; then \
#        composer install --no-scripts --optimize-autoloader --no-interaction; \
#    fi \
#    && \
#    chown -R www-data:www-data /var/www/project/app/vendor \
#    && \
#    chown -R www-data:www-data /var/www/project/app/var \
#    && \
#    composer update 
    
CMD ln -s /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini

CMD php-fpm

