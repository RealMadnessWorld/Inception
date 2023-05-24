FROM debian:buster

RUN apt-get update -yq
RUN apt-get install nginx -yq
RUN apt-get install nano -yq
RUN apt-get install openssl -yq

# RUN ufw allow 'Nginx HTTP'

RUN mkdir -p /var/www/jarsenio.com
# RUN mkdir /etc/nginx/ssl
RUN openssl req -new -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/ssl/certs/www.jarsenio.42.fr.crt -keyout /etc/ssl/private/www.jarsenio.42.fr.key \
-subj "/C=PT/ST=Lisboa/L=Lisboa/O=42Lisboa/OU=Inception/CN=www.jarsenio.42.fr"

# COPY ./config/site.conf /etc/nginx/sites-available/jarsenio.conf
# RUN ln -s /etc/nginx/sites-available/jarsenio.conf /etc/nginx/sites-enabled/
COPY ./config/nginx.conf /etc/nginx/nginx.conf
COPY ./config/nginx.conf /etc/nginx/sites-enabled/default

RUN echo "fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;" >> /etc/nginx/fastcgi_params

CMD ["nginx", "-g", "daemon off;"]
# CMD ["tail", "-f", "/dev/null"]