FROM debian:buster

RUN apt-get update
RUN apt-get install wget curl nano iproute2 -yq
RUN apt-get install php7.3-fpm php7.3-common php7.3-mysql \
php7.3-gmp php7.3-curl php7.3-intl php7.3-mbstring php7.3-xmlrpc \
php7.3-gd php7.3-xml php7.3-cli php7.3-zip php7.3-soap php7.3-imap -yq

RUN mkdir -p /var/www/jarsenio.com/
WORKDIR /var/www/jarsenio.com/
RUN wget http://wordpress.org/latest.tar.gz
RUN tar -xvf latest.tar.gz
# RUN rm latest.tar.gz
WORKDIR /var/www/jarsenio.com/wordpress/
COPY /config/ /var/www/jarsenio.com/wordpress/
RUN chown -R www-data:www-data /var/www/jarsenio.com

COPY /config/www.conf /etc/php/7.3/fpm/pool.d/www.conf
RUN echo "<?php\nphpinfo();\n?>" > /var/www/jarsenio.com/info.php

# COPY /config/index.html /usr/share/wordpress/jarsenio.com
WORKDIR /tmp/
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

COPY /tools/entrypoint.sh /tmp/

ENTRYPOINT ["bash", "/tmp/entrypoint.sh" ]
# CMD tail -f /dev/null