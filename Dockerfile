FROM php:5.6-fpm
LABEL maintainer="alex@openzula.org"

EXPOSE 9000
WORKDIR /var/www

RUN apt-get update

## Healthcheck
RUN apt-get install -y libfcgi-bin

RUN echo 'pm.status_path = /oz-health-status' >> /usr/local/etc/php-fpm.d/zz-docker.conf
RUN echo 'ping.path = /oz-health-ping' >> /usr/local/etc/php-fpm.d/zz-docker.conf

COPY ./bin/oz-healthcheck /usr/local/bin/oz-healthcheck
HEALTHCHECK --interval=30s --timeout=10s CMD /usr/local/bin/oz-healthcheck

## PHP config & extensions
RUN apt-get install -y zlib1g-dev libpng-dev libjpeg-dev libfreetype6-dev
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install pdo_mysql gd

COPY ./config/php.ini /usr/local/etc/php/

COPY src/ /var/www/

RUN mkdir -p application/cache
RUN mkdir -p application/logs
RUN mkdir -p public/assets/uploads

CMD chown -R www-data:www-data application/cache application/logs public/assets/uploads && \
    php-fpm
