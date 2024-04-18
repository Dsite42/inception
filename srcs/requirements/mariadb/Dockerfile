FROM alpine:3.17.5

EXPOSE 3306

RUN apk update && apk add --no-cache mariadb mariadb-client

RUN sed -i "s/skip-networking/skip-networking=0/g" /etc/my.cnf.d/mariadb-server.cnf

RUN mkdir -p /var/run/mysqld
RUN chmod 777 /var/run/mysqld
RUN chown -R mysql:mysql /var/lib/mysql

COPY ./conf/db_create.sql /var/mariadb/
COPY ./tools/setup.sh /var/mariadb/
RUN chmod 777 /var/mariadb/db_create.sql
RUN chmod 777 /var/mariadb/setup.sh

ENTRYPOINT ["/var/mariadb/setup.sh"]

CMD ["/usr/bin/mysqld", "--user=mysql", "--init-file=/var/mariadb/db_create.sql"]
