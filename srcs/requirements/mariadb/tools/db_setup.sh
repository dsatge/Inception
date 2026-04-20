#!/bin/bash

# Création du dossier de runtime pour MariaDB
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

# Initialisation de la base de données système si elle n'existe pas
if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

# Initialisation sécurisée via le mode bootstrap de mysqld
# On utilise les variables d'environnement définies dans le .env
mysqld --user=mysql --bootstrap << EOF
USE mysql;
FLUSH PRIVILEGES;

CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;
CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%';

-- On sécurise le root et on l'autorise à distance pour l'installateur WordPress
ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';

FLUSH PRIVILEGES;
EOF

# Lancement de MariaDB en mode normal (foreground) pour garder le conteneur actif
echo "MariaDB starting..."
exec mysqld --user=mysql --console