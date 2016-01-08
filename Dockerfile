# Use this as a base image
FROM ubuntu:14.04

# Optional: specify the maintainer
MAINTAINER Andres Mendez <amj.desarrollo@gmail.com>

# ENV LARAVEL_VERSION 5.1.*
ENV LAST_UPDATE 2016-01-06_081000

# Run any command on terminal
RUN apt-get update && \
    apt-get -y install apache2 php5 libapache2-mod-php5 php5-mcrypt php5-json php5-mysql curl git nodejs npm nano && \
    apt-get clean && \
    update-rc.d apache2 defaults && \
    php5enmod mcrypt && \
    a2enmod rewrite && \
    rm -rf /var/www/html && \
    curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer && \
    ln -s /usr/bin/nodejs /usr/bin/node && \
    npm install -g gulp

# Install Laravel
# WORKDIR /var/www
# RUN composer create-project laravel/laravel laravel $LARAVEL_VERSION --prefer-dist --no-interaction && \
#     php laravel/artisan key:generate && \
#     chown www-data:www-data -R laravel/storage

COPY 000-default.conf /etc/apache2/sites-available/000-default.conf

# Expose necessary ports to the container
EXPOSE 80
EXPOSE 443

# COPY setup-laravel.sh /setup-laravel.sh
# RUN ["chmod", "+x", "/setup-laravel.sh"]
# ENTRYPOINT ["/setup-laravel.sh"]

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
