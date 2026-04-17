#!/bin/bash

# Make sure socket's folder exist and is user's mysql
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

# Launch mariadb in the background to set it up
# Use mysql bootstrap to set up Mariadb and turn it off only when it s done
mysqld --user=mysql --bootstrap << EOF
USE mysql;
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;
CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

#relaunch mariadb in foreground mode
exec mysqld --user=mysql --console