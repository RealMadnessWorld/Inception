FROM debian:buster

# RUN apt-get install php-fpm php-mysql -yq
RUN apt-get update -q
RUN apt install -y php7.3 \
                   php7.3-fpm \
                   php7.3-mysql \
                   php7.3-json \
                   php7.3-common \
                   php7.3-mbstring \
                   php7.3-curl \
                   php7.3-dom \
                   php7.3-exif \
                   php7.3-fileinfo \
                   php7.3-imagick \
                   php7.3-cli \
                   php7.3-xml \
                   php7.3-zip
RUN apt-get install curl -yq
RUN apt-get install wget -yq
RUN apt-get install nano -yq

#* Getting wordpress ready
RUN mkdir -p /var/www/jarsenio.com
WORKDIR /var/www/jarsenio.com/
RUN wget http://wordpress.org/latest.tar.gz
RUN tar -xvf latest.tar.gz
# RUN rm latest.tar.gz
WORKDIR /var/www/jarsenio.com/wordpress/
COPY /config/ /var/www/jarsenio.com/wordpress/
RUN chown -R www-data:www-data /var/www/jarsenio.com

#* File creation
COPY ./config/www.conf /etc/php/7.3/fpm/pool.d/
RUN echo "<?php\nphpinfo();\n?>" > /var/www/jarsenio.com/info.php
COPY ./config/todo_list.php /var/www/jarsenio.com/
COPY ./config/main.php /var/www/jarsenio.com/
COPY ./config/entrypoint.sh /tmp/entrypoint.sh
# COPY ./config/entrypoint.sh /tmp/entrypoint.sh

#* Installing wordpress
WORKDIR /tmp/
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

# ENTRYPOINT ["./config/entrypoint.sh"]
CMD ["bash", "/tmp/entrypoint.sh"]