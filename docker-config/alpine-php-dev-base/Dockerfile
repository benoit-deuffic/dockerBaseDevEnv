FROM php:fpm-alpine3.11

# Install packages
RUN apk update \
    && \
    # apt Debian packages
    apk add \
        autoconf \
        ca-certificates \
        curl \
        g++ \
        make \
        bzip2-dev \
        freetype-dev \
        libjpeg-turbo-dev \
        libpng-dev \
        libpq \
        libressl-dev \
        icu-dev \
        gettext-dev \
        oniguruma-dev \
        libzip-dev \
        imagemagick-dev \
        zlib-dev \
        unzip \
        zip \
        git \
        iputils \
        net-tools \
        postgresql-client \
    && \
    # pecl PHP extensions
    pecl install \
        imagick-3.4.4 \
        redis \
        xdebug-2.8.1 \
    && \
    # Configure PHP extensions
    docker-php-ext-configure \
        gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/ \
    && \
    # Install PHP extensions
    docker-php-ext-install \
        bcmath \
        bz2 \
        exif \
        ftp \
        gettext \
        gd \
        iconv \
        intl \
        mbstring \
        opcache \
        pdo \
        shmop \
        sockets \
        sysvmsg \
        sysvsem \
        sysvshm \
        zip \
    && \
    # Enable PHP extensions
    docker-php-ext-enable \
        imagick \
        redis \
        xdebug

# Append our php.ini overrides to the end of the file
RUN echo "upload_max_filesize = 10M" >> /usr/local/etc/php/php.ini && \
    echo "post_max_size = 10M" >> /usr/local/etc/php/php.ini && \
    echo "max_execution_time = 300" >> /usr/local/etc/php/php.ini && \
    echo "memory_limit = 256M" >> /usr/local/etc/php/php.ini && \
    echo "opcache.revalidate_freq = 0" >> /usr/local/etc/php/php.ini && \
    echo "opcache.validate_timestamps = 1" >> /usr/local/etc/php/php.ini

# Copy the `zzz-docker.conf` file into place for php-fpm
COPY ./zzz-docker.conf /usr/local/etc/php-fpm.d/zzz-docker.conf
