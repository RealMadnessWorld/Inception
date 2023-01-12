FROM debian:buster

RUN apt-get update && apt-get upgrade -y
RUN apt-get install mariadb-server -y

COPY ./config/mariadb.cnf /etc/mysql/mariadb.cnf

CMD ["mysqld"]