FROM debian:buster

RUN apt-get update
RUN apt-get install nginx -y
RUN apt-get install openssl -y
# RUN ufw allow 'Nginx HTTP'

RUN openssl req -new -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/ssl/www.jarsenio.42.fr.crt -keyout /etc/ssl/www.jarsenio.42.fr.key \
-subj "/C=PT/ST=Lisboa/L=Lisboa/O=42Lisboa/OU=Inception/CN=www.jarsenio.42.fr"

COPY ./config/nginx.conf /etc/nginx/sites-available/

CMD nginx -g daemon off