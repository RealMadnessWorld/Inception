FROM debian:buster

RUN apt-get update -q
RUN apt-get install nginx -yq
RUN apt-get install nano -yq
RUN apt-get install openssl -yq
# RUN ufw allow 'Nginx HTTP'

RUN mkdir /var/www/jarsenio.com
RUN mkdir /etc/nginx/ssl
RUN openssl req -new -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/nginx/ssl/www.jarsenio.42.fr.crt -keyout /etc/nginx/ssl/www.jarsenio.42.fr.key \
-subj "/C=PT/ST=Lisboa/L=Lisboa/O=42Lisboa/OU=Inception/CN=www.jarsenio.42.fr"

# COPY ./config/nginx.conf /etc/nginx/
RUN sleep 10
COPY ./config/site.conf /etc/nginx/sites-available/jarsenio.conf
RUN ln -s /etc/nginx/sites-available/jarsenio.conf /etc/nginx/sites-enabled/

# RUN echo "fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;" >> /etc/nginx/fastcgi_params



CMD ["nginx", "-g", "daemon off;"]