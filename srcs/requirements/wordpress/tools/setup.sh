#!/bin/bash

# Wait time to make sure MariaDb is launch
sleep 10

if [ ! -f /var/www/html/wp-config.php]; then
	# download wordpress
	wp core download --allow--root

	# Create config file and connect to Mariadb
	wp config create --allow--root \
		--dbname=$SQL_DATABASE \
		--dbuser=$SQL_USER \
		--dbpass=$SQL_PASSWORD \
		--dbhost=mariadb:3306

	# Install website
		--url=$DOMAIN_NAME \
		--title=$SITE_TITLE \
		--admin_user=$WP_ADMIN_USER \
		--amdin_password=$WP_ADMIN_PASSWORD \
		--admin_email=$WP_ADMIN_EMAIL
	
	# Create extra user
	wp user create --allow-root $WP_USER_EMAIL \
		--role=author \
		--user_pass=$WP_USER_PASSWORD

fi

#launch PHP-FPM foreground (-F)
exec /user/sbin/php-fpm7.4 -F
