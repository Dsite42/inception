#!/bin/sh

if [ -f "/var/www/wordpress/wp-config.php" ]; then
	echo "Wordpress already exist"
else
	wp core download --allow-root
	echo "wp core downloaded"
	wp core config --dbname="$DB_NAME" --dbuser="$DB_USER_NAME" --dbpass="$DB_USER_PW" --dbhost="$DB_HOST:$DB_PORT" --dbprefix='wp_' --allow-root
	echo "WP db configured"
	wp core install --url="$DOMAIN_NAME" --title="$WP_TITLE" --admin_user="$WP_ADMIN_NAME" --admin_password="$WP_ADMIN_PW" --admin_email="$WP_ADMIN_MAIL" --allow-root
	echo "wp installed"
	echo "wp user create $WP_USER_NAME $WP_USER_MAIL --role='subscriber' --user_pass="$WP_USER_PW" --allow-root"
	wp user create $WP_USER_NAME $WP_USER_MAIL --role='subscriber' --user_pass="$WP_USER_PW" --allow-root
	echo "wp user added"
fi
exec "$@"
