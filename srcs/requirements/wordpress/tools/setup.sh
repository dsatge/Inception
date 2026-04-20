#!/bin/bash
cd /var/www/html

# Wait time to make sure MariaDb is launch
sleep 10

if [ ! -f wp-config.php ]; then
    echo "WordPress: installation en cours..."
    
    wp core download --allow-root

    wp config create --allow-root \
        --dbname=$SQL_DATABASE \
        --dbuser=$SQL_USER \
        --dbpass=$SQL_PASSWORD \
        --dbhost=mariadb:3306

    wp core install --allow-root \
        --url=$DOMAIN_NAME \
        --title=$SITE_TITLE \
        --admin_user=$WP_ADMIN_USER \
        --admin_password=$WP_ADMIN_PASSWORD \
        --admin_email=$WP_ADMIN_EMAIL
    
    wp user create $WP_USER $WP_USER_EMAIL \
        --role=author \
        --user_pass=$WP_USER_PASSWORD \
        --allow-root
    
    echo "WordPress: installation terminée !"
fi

echo "WordPress started on port 9000"
exec /usr/sbin/php-fpm7.4 -F