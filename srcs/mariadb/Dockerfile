FROM debian:buster

RUN apt-get update && apt-get upgrade -yq
RUN apt-get install mariadb-server -yq
RUN apt-get install procps -yq
RUN apt-get install vim -yq

COPY ./config/mariadb.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# copy the entrypoint script inside the container and give it executing permissions
COPY ./config/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

RUN mysql_install_db

# CMD tail -f /dev/null

CMD ["bash", "/usr/local/bin/entrypoint.sh"]
# CMD ["mysqld_safe"]