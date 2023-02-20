#!/bin/bash

# tail -f /dev/null

# sleep infinity

mysql_install_db;
# mysql_secure_installation;
# mysqld_safe --skip-grant-tables;
echo "	[i] Mariadb installed"

service mysql start;
echo "	[i] Mysql started"

# verification if the database exists
# if it doesn't, creates it

if [ -d /var/lib/mysql/${MARIADB_DATABASE} ]; then
	echo "	[i] ${MARIADB_DATABASE} already exists"
else
	mysql -uroot -p${MARIADB_PASSWORD} -e "CREATE DATABASE IF NOT EXISTS ${MARIADB_DATABASE};"
	mysql -uroot -p${MARIADB_PASSWORD} -e "CREATE USER ${MARIADB_USER}@localhost IDENTIFIED BY '${MARIADB_PASSWORD}';"
	mysql -uroot -p${MARIADB_PASSWORD} -e "GRANT ALL PRIVILEGES ON ${MARIADB_DATABASE}.* TO '${MARIADB_USER}'@'localhost';"
	mysql -uroot -p${MARIADB_PASSWORD} -e "GRANT ALL PRIVILEGES ON *.* TO '${MARIADB_USER}'@'localhost' IDENTIFIED BY '${MARIADB_PASSWORD}' WITH GRANT OPTION;"
	mysql -uroot -p${MARIADB_PASSWORD} -e "FLUSH PRIVILEGES;"
	echo "	[i] Database created"

	# mysql -uroot -p${MARIADB_PASSWORD} -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_PASSWORD}';"
	mysql -uroot -p${MARIADB_PASSWORD} -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('${MARIADB_PASSWORD}');"
	mysql -uroot -p${MARIADB_PASSWORD} -e "UPDATE mysql.user SET plugin = 'auth_socket' WHERE user = 'root';"
	mysql -uroot -p${MARIADB_PASSWORD} -e "FLUSH PRIVILEGES;"
	echo "	[i] Root password updated"
fi

#SELECT User, Password, Plugin FROM mysql.user;

# service mysql stop;
echo "	[i] Shutdown"

mysqld;
echo "	[i] Mysqld"