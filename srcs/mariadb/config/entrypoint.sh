#!/bin/bash

tail -f /dev/null

# sleep infinity

# mysql_install_db;
mysql_secure_installation;

service mysql start;

# verification if the database exists
# if it doesn't, creates it

if [ -d /var/lib/mysql/${MARIADB_DATABASE} ]; then
	echo "	[i] ${MARIADB_DATABASE} already exists"
else
	mysql -e "CREATE DATABASE IF NOT EXISTS ${MARIADB_DATABASE};"
	mysql -e "CREATE USER ${MARIADB_USER}@localhost IDENTIFIED BY '${MARIADB_PASSWORD}';"
	mysql -e "GRANT ALL PRIVILEGES ON ${MARIADB_DATABASE}.* TO '${MARIADB_USER}'@'localhost';"
	mysql -e "GRANT ALL PRIVILEGES ON *.* TO '${MARIADB_USER}'@'localhost' IDENTIFIED BY '${MARIADB_PASSWORD}' WITH GRANT OPTION;"
	mysql -e "FLUSH PRIVILEGES;"
	echo "	[i] Database created"

	# mysql -uroot -p${MARIADB_PASSWORD} -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_PASSWORD}';"
	# echo "	[i] Root password updated"
fi

# echo "	[i] Shutdown"
# mysqladmin -u root -p${MARIADB_PASSWORD} shutdown;

# service mysql stop;


echo "	[i] Mysqld"
mysqld;