FROM alpine:3.16

RUN apk update
RUN apk add nginx
RUN adduser -g 'Nginx www user' -h /home/nginx/ nginx

COPY index.html /usr/share/nginx/html
