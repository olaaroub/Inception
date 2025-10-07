# Use the slim Debian 11 image for a smaller footprint.
FROM debian:bullseye-slim

RUN apt-get update && \
    apt-get install -y php7.4-fpm php7.4-mysql curl mariadb-client


COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf


RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /var/www/html

WORKDIR /var/www/html

COPY tools/setup.sh /usr/local/bin/setup.sh
RUN chmod +x /usr/local/bin/setup.sh

ENTRYPOINT ["/usr/local/bin/setup.sh"]

CMD ["/usr/sbin/php-fpm7.4", "-F"]
