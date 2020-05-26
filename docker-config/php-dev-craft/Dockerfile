FROM bdeuffic/php-dev-base

# Install packages
RUN apt-get update \
    && \
    # apt Debian packages
    apt-get install -y \
        nano \
    && \
    # Install PHP extensions
    docker-php-ext-install \
        pdo_mysql \
        pdo_pgsql \
    && \
    # Install Composer
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer

WORKDIR /var/www/project

# Copy over the directories/files php needs access to
COPY --chown=www-data:www-data ./app/composer.* /var/www/project/app/

# Create the cache  directory and make it writeable by PHP
RUN mkdir -p /var/www/project/app/var/cache \ 
    && \
    chown -R www-data:www-data /var/www/project/app/var


WORKDIR /var/www/project/app

# Do a `composer install` without running any Composer scripts
# - If `composer.lock` is present, it will install what is in the lock file
# - If `composer.lock` is missing, it will update to the latest dependencies
#   and create the `composer.lock` file
# Force permissions, composer update , and start php-fpm
CMD if [ ! -f "./composer.lock" ]; then \
        composer install --no-scripts --optimize-autoloader --no-interaction; \
    fi \
    && \
    if [ ! -d ./vendor -o ! "$(ls -A ./vendor)" ]; then \
        composer install --no-scripts --optimize-autoloader --no-interaction; \
    fi \
    && \
    chown -R www-data:www-data /var/www/project/app/vendor \
    && \
    chown -R www-data:www-data /var/www/project/app/var \
    && \
    composer update \
    && \
    php-fpm
