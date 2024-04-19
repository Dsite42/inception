FROM alpine:3.18.6

# listens on port 3306, the default port for MariaDB
EXPOSE 3306

# updates the package manager and installs mariadb and mariadb-client
RUN apk update && apk add --no-cache mariadb mariadb-client

# modify the MariaDB server configuration file to disable the skip-networking option (or set it to 0), 
    # ensuring that MariaDB listens on TCP/IP ports, allowing connections from outside the container.
RUN sed -i "s/skip-networking/skip-networking=0/g" /etc/my.cnf.d/mariadb-server.cnf

# This directory is used for storing the MariaDB server's PID file and socket.
RUN mkdir -p /var/run/mysqld
RUN chmod 777 /var/run/mysqld

#Changes the ownership of the /var/lib/mysql directory (and all files within) to the mysql user and group.
    # This directory is where MariaDB stores its databases and needs to be owned by the mysql user for the database server to operate correctly.
RUN chown -R mysql:mysql /var/lib/mysql

# This script likely contains SQL commands to set up the initial database schema.
COPY ./conf/db_create.sql /var/mariadb/

# This script is used to initialize the database and apply the db_create.sql script
COPY ./tools/setup.sh /var/mariadb/

RUN chmod 777 /var/mariadb/db_create.sql
RUN chmod 777 /var/mariadb/setup.sh

# The ENTRYPOINT instruction specifies the command that will run when the container starts.
ENTRYPOINT ["/var/mariadb/setup.sh"]

# This runs the mysqld process (MariaDB server) as the mysql user and specifies the db_create.sql file to be executed upon database server startup.
CMD ["/usr/bin/mysqld", "--user=mysql", "--init-file=/var/mariadb/db_create.sql"]
