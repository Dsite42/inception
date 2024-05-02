FROM alpine:3.18.6

EXPOSE 9000

RUN apk update && apk add --no-cache php81 php-fpm php-common php-json php-session php-mysqli php81-phar mariadb-client php81-iconv php81-mbstring curl

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

# Creates a new group and system user named www-data.
RUN adduser -S www-data && adduser www-data www-data

# Copy Config file
COPY ./conf/www.conf /etc/php81/php-fpm.d/www.conf
RUN mkdir -p /var/www/wordpress
COPY ./tools/tool.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/tool.sh

# The ENTRYPOINT instruction specifies the command that will run when the container starts.
ENTRYPOINT ["/usr/local/bin/tool.sh"]

WORKDIR /var/www/wordpress
# Specifies the path to the PHP-FPM(PHP FastCGI Process Manager) executable.
# The -F flag tells PHP-FPM to run in the foreground, so that Docker can properly manage and monitor the process.
CMD ["/usr/sbin/php-fpm81", "-F"]
