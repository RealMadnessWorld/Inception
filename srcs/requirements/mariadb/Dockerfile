FROM debian:buster

RUN apt-get update -q
RUN apt-get install mariadb-server -yq
RUN apt-get install nano -yq
RUN apt-get install procps -yq

COPY ./config/entrypoint.sh /tmp/
COPY ./config/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY ./config/wordpress.sql /tmp/

RUN mysql_install_db;

CMD ["bash", "/tmp/entrypoint.sh"]