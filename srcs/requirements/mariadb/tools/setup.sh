#!bin/sh

if [ ! -d "/var/lib/mysql/$DB_NAME" ]; then

	# Initialize the database
	mysql_install_db --user=mysql --ldata=/var/lib/mysql

	# replace variables
	sed -i "s/DB_NAME/$DB_NAME/g" /var/mariadb/db_create.sql
	sed -i "s/DB_USER_PW/$DB_USER_PW/g" /var/mariadb/db_create.sql
	sed -i "s/DB_USER_NAME/$DB_USER_NAME/g" /var/mariadb/db_create.sql
	sed -i "s/DB_ROOT_PW/$DB_ROOT_PW/g" /var/mariadb/db_create.sql
fi

exec "$@"
