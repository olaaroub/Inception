#!/bin/bash

echo -e "[mysqld]\nbind-address = 0.0.0.0" > /etc/mysql/mariadb.conf.d/99-custom.cnf

service mariadb start;

while ! mysqladmin ping -h localhost --silent; do
    sleep 1
done
mysql -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"

mysql -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%';"

mysqladmin -u root -p${MYSQL_ROOT_PASSWORD} shutdown

exec "$@"