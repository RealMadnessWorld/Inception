#!/bin/bash

# tail -f /dev/null

service mysql start;
sleep 5;
echo "	[i] Mysql started"

# verification if the database exists
# if it doesn't, creates it
if [ -d /var/lib/mysql/${MARIADB_DATABASE} ]; then
	echo "	[i] ${MARIADB_DATABASE} already exists"
else
	# mysql -uroot -p${MARIADB_PASSWORD} -e "CREATE DATABASE IF NOT EXISTS ${MARIADB_DATABASE};"
	# mysql -uroot -p${MARIADB_PASSWORD} -e "CREATE USER ${MARIADB_USER}@localhost IDENTIFIED BY '${MARIADB_PASSWORD}';"
	# mysql -uroot -p${MARIADB_PASSWORD} -e "GRANT ALL PRIVILEGES ON ${MARIADB_DATABASE}.* TO '${MARIADB_USER}'@'localhost';"
	# mysql -uroot -p${MARIADB_PASSWORD} -e "GRANT ALL PRIVILEGES ON *.* TO '${MARIADB_USER}'@'localhost' IDENTIFIED BY '${MARIADB_PASSWORD}' WITH GRANT OPTION;"
	# mysql -uroot -p${MARIADB_PASSWORD} -e "FLUSH PRIVILEGES;"
	# echo "	[i] Database created"

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

	# mysql -uroot -p${MARIADB_PASSWORD} -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_PASSWORD}';"
	mysql -uroot -p${MARIADB_PASSWORD} -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('${MARIADB_PASSWORD}');"
	mysql -uroot -p${MARIADB_PASSWORD} -e "FLUSH PRIVILEGES;"
	echo "	[i] Root password updated"
fi

#SELECT User, Password, Plugin FROM mysql.user;

mysqladmin -u root -p${MARIADB_PASSWORD} shutdown;
echo "	[i] Shutdown"

mysqld;
echo "	[i] Mysqld"