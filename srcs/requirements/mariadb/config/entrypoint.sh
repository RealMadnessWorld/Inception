#!/bin/bash

service mysql start;

sleep 5;

# Configure database
if [ -f /var/lib/mysql/${MARIADB_DATABASE} ]; then
	echo "${MARIADB_DATABASE} already created"
else
	# creating database
	mariadb -u root -e "CREATE DATABASE IF NOT EXISTS ${MARIADB_DATABASE};"
	# creating user MARIADB_USER %
	mariadb -u root -e "CREATE USER IF NOT EXISTS '${MARIADB_USER}'@'%' IDENTIFIED BY '${MARIADB_PASSWORD}';"
	mariadb -u root -e "GRANT ALL ON ${MARIADB_DATABASE}.* TO '${MARIADB_USER}'@'%' IDENTIFIED BY '${MARIADB_PASSWORD}';"
	mariadb -u root -e "FLUSH PRIVILEGES;"
	# creating user MARIADB_USER local
	mariadb -u root -e "CREATE USER IF NOT EXISTS '${MARIADB_USER}'@'localhost' IDENTIFIED BY '${MARIADB_PASSWORD}';"
	mariadb -u root -e "GRANT ALL ON ${MARIADB_DATABASE}.* TO '${MARIADB_USER}'@'localhost' IDENTIFIED BY '${MARIADB_PASSWORD}';"
	mariadb -u root -e "FLUSH PRIVILEGES;"
	echo "${MARIADB_DATABASE} created database"
	
	# mariadb -u root -e "CREATE TABLE ${MARIADB_DATABASE}.todo_list (item_id INT AUTO_INCREMENT, content VARCHAR(255), PRIMARY KEY(item_id));"
	# mariadb -u root -e "INSERT INTO ${MARIADB_DATABASE}.todo_list (content) VALUES ('My first task, yay');"
	# mariadb -u root -e "INSERT INTO ${MARIADB_DATABASE}.todo_list (content) VALUES ('Second task, gimme more');"
	# mariadb -u root -e "INSERT INTO ${MARIADB_DATABASE}.todo_list (content) VALUES ('Last task i promise');"
	# mariadb -u root -e "INSERT INTO ${MARIADB_DATABASE}.todo_list (content) VALUES ('one more task');"

	mysql -u ${MARIADB_USER} -p${MARIADB_PASSWORD} ${MARIADB_DATABASE} < /tmp/wordpress.sql

	mariadb -uroot -p${MARIADB_PASSWORD} -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('${MARIADB_PASSWORD}');"
	mariadb -uroot -p${MARIADB_PASSWORD} -e "FLUSH PRIVILEGES;"
	echo "Updated root password"
fi

# TODO -> SELECT User, Password, Plugin FROM mysql.user;
# show databases;
# use testdb
# show tables
# select * from todo_list

# service mysql stop;
echo "Starting mysqld"
mysqladmin -u root -p${MARIADB_PASSWORD} shutdown;
mysqld;
echo "Mysqld failed to start!"