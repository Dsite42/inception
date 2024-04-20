#!/bin/sh

# Checks if the database already exists 
if [ ! -d "/var/lib/mysql/$DB_NAME" ]; then

	# Initialize the database, specifing the user and the data directory
	mysql_install_db --user=mysql --ldata=/var/lib/mysql

	# replace variables
	# search for the placeholder DB_NAME in the db_create.sql script and replaces
	# it with the actual database name stored in the $DB_NAME environment variable. 
	sed -i "s/DB_NAME/$DB_NAME/g" /var/mariadb/db_create.sql
	sed -i "s/DB_USER_PW/$DB_USER_PW/g" /var/mariadb/db_create.sql
	sed -i "s/DB_USER_NAME/$DB_USER_NAME/g" /var/mariadb/db_create.sql
	sed -i "s/DB_ROOT_PW/$DB_ROOT_PW/g" /var/mariadb/db_create.sql
fi

# It replaces itself with the command specified in CMD (see Dockerfile) —in this case, starting the MariaDB
# server with the given options. This ensures that the MariaDB server runs as the main process in the
# container (PID 1) and can directly handle signals sent to the container, like stop requests.
exec "$@"
