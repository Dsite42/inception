/* The USE statement tells mariaDB to use the mysql database as the default,
which is a system database containing metadata about all other databases, users, and permissions. */
USE mysql;

/* Delete user with empty name.  It's a security measure intended to ensure there are no anonymous
users in the database, as they could potentially be exploited for unauthorized access. */
DELETE FROM user WHERE user='';

/* The test database is often created by default during installation but is not needed. */
DROP DATABASE IF EXISTS test;

/* Change the root password */
ALTER USER 'root'@'localhost' IDENTIFIED BY 'DB_ROOT_PW';

/* Create a new user and database */
CREATE OR REPLACE USER 'DB_USER_NAME' IDENTIFIED BY 'DB_USER_PW';
CREATE DATABASE IF NOT EXISTS DB_NAME;

/* Grant the new user all privileges on the new database */
GRANT ALL PRIVILEGES ON DB_NAME.* TO 'DB_USER_NAME';

/* reloads the grant tables in the MariaDB database, ensuring that any changes to permissions or
new users are immediately applied and available. */
FLUSH PRIVILEGES;
