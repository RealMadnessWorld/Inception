#!/bin/bash

mysql_install_db;
service mysql start;

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
	
	mariadb -u root -e "CREATE TABLE ${MARIADB_DATABASE}.todo_list (item_id INT AUTO_INCREMENT, content VARCHAR(255), PRIMARY KEY(item_id));"
	mariadb -u root -e "INSERT INTO ${MARIADB_DATABASE}.todo_list (content) VALUES ('My first task, yay');"
	mariadb -u root -e "INSERT INTO ${MARIADB_DATABASE}.todo_list (content) VALUES ('Second task, gimme more');"
	mariadb -u root -e "INSERT INTO ${MARIADB_DATABASE}.todo_list (content) VALUES ('Last task i promise');"
	mariadb -u root -e "INSERT INTO ${MARIADB_DATABASE}.todo_list (content) VALUES ('one more task');"

	mariadb -uroot -p${MARIADB_PASSWORD} -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('${MARIADB_PASSWORD}');"
	# mariadb -uroot -p${MARIADB_PASSWORD} -e "UPDATE mysql.user SET plugin = 'auth_socket' WHERE user = 'root';"
	mariadb -uroot -p${MARIADB_PASSWORD} -e "FLUSH PRIVILEGES;"
fi

#SELECT User, Password, Plugin FROM mysql.user;

# service mysql stop;
mysqladmin -u root -p${MARIADB_PASSWORD} shutdown;
mysqld;