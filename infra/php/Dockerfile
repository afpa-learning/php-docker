FROM php:8.0-fpm
#Install mysqli
RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli
RUN docker-php-ext-install pdo && docker-php-ext-enable pdo
RUN docker-php-ext-install pdo_mysql && docker-php-ext-enable pdo_mysql
#Install git
RUN apt-get update \
    && apt-get install -y git
#Install important libraries
RUN apt-get -y install zip
#Install Composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer
#COPY composer.json /var/www
#RUN composer install
#récupère les librairies utiles
EXPOSE 80
WORKDIR /var/www
EXPOSE 9000
CMD ["php-fpm"]
#CMD php-fpm -D