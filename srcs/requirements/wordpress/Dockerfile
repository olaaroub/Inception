FROM debian:bullseye-slim

RUN apt-get update && \
    apt-get install -y ca-certificates apt-transport-https lsb-release gnupg curl mariadb-client redis-tools && \
    rm -rf /var/lib/apt/lists/*

RUN curl -sSLo /usr/share/keyrings/deb.sury.org-php.gpg https://packages.sury.org/php/apt.gpg && \
    sh -c 'echo "deb [signed-by=/usr/share/keyrings/deb.sury.org-php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list'

RUN apt-get update && \
    apt-get install -y php8.2-fpm php8.2-mysql php8.2-redis && \
    rm -rf /var/lib/apt/lists/*

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Create PHP-FPM runtime directory hadi dart lia mochkil dial php fpm fach taybghi ysayb pid file
# /run/php/php8.2-fpm.pid
RUN mkdir -p /run/php && \
    chown www-data:www-data /run/php

COPY conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

COPY tools/setup.sh /usr/local/bin/setup.sh

RUN chmod +x /usr/local/bin/setup.sh

WORKDIR /var/www/html

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/setup.sh"]

CMD ["/usr/sbin/php-fpm8.2", "-F"]

