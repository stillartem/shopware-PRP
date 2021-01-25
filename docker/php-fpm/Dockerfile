FROM php:7.2.0-apache

RUN docker-php-ext-install pdo pdo_mysql mysqli
# Enable apache rewrite
#Install spatialite and create symlink for libproj.so.0
RUN apt-get update && apt-get -y install gdal-bin libpng-dev
RUN ln -s /usr/lib/x86_64-linux-gnu/libproj.so.12 /usr/lib/x86_64-linux-gnu/libproj.so.0

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev

RUN apt-get update && \
     apt-get install -y \
         libzip-dev \
         unzip \
         && docker-php-ext-install zip

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

##Install gd library for images
#RUN apt-get install libpng-dev libfreetype6-dev libjpeg62-turbo-dev -qy \
#    && apt-get clean \
#    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#Copy php ini
COPY php.ini /usr/local/etc/php/php.ini
RUN a2enmod rewrite

# INSTALL COMPOSER:
RUN curl -o /tmp/composer-setup.php https://getcomposer.org/installer \
    && curl -o /tmp/composer-setup.sig https://composer.github.io/installer.sig \
    && php -r "if (hash('SHA384', file_get_contents('/tmp/composer-setup.php')) !== trim(file_get_contents('/tmp/composer-setup.sig'))) { unlink('/tmp/composer-setup.php'); echo 'Invalid installer' . PHP_EOL; exit(1); }" \
    && php /tmp/composer-setup.php --no-ansi --no-dev --install-dir=/usr/local/bin --filename=composer --stable \
    && ln -s /usr/local/bin/composer /usr/local/sbin/composer \
    && rm -f /tmp/composer-setup.*

# SHOPWARE 5 doesn't work with new version of composer because PSR-0. WTF?
RUN composer self-update 1.10.19


# Install git
RUN apt-get update \
    && apt-get -y install git \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

WORKDIR /var/www/html/shopware

#RUN if getent passwd www-data ; then  userdel -f www-data; fi && \
#    if getent group www-data ; then groupdel www-data; fi && \
#    groupadd -g ${GROUP_ID} www-data && \
#    useradd -l -s /bin/bash -u ${USER_ID} -g www-data www-data && \
#    chown --changes --silent --no-dereference --recursive  --from=33:33 ${USER_ID}:${GROUP_ID} /usr/local/bin/composer

