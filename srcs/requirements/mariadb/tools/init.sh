#!/bin/bash

mysqld --user=mysql --bootstrap << EOF

-- Create the main WordPress database only if it doesn't already exist.
CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\`;

-- Create the root user if it doesn't exist, allowing connections from any host.
CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;

-- Create the WordPress application user only if it doesn't already exist.
-- The '%' wildcard means 'any host on the network'.
CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';

-- Grant all necessary privileges for the WordPress user on its database.
GRANT ALL PRIVILEGES ON \`$MYSQL_DATABASE\`.* TO '$MYSQL_USER'@'%';

-- Apply the new privileges immediately.
FLUSH PRIVILEGES;
EOF

exec "$@"

