FROM debian:12-slim

RUN apt-get update && \
    apt-get install -y ca-certificates apt-transport-https lsb-release gnupg curl && \
    rm -rf /var/lib/apt/lists/*

RUN curl -sSLo /usr/share/keyrings/deb.sury.org-php.gpg https://packages.sury.org/php/apt.gpg && \
    sh -c 'echo "deb [signed-by=/usr/share/keyrings/deb.sury.org-php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list'

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

FROM debian:12-slim

COPY --from=0 /etc/apt/sources.list.d/php.list /etc/apt/sources.list.d/php.list
COPY --from=0 /usr/share/keyrings/deb.sury.org-php.gpg /usr/share/keyrings/deb.sury.org-php.gpg

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    php8.2-fpm php8.2-mysql php8.2-redis mariadb-client redis-tools ca-certificates && \
    rm -rf /var/lib/apt/lists/*

COPY --from=0 /usr/local/bin/wp /usr/local/bin/wp

RUN mkdir -p /run/php && \
    chown www-data:www-data /run/php

COPY conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf
COPY tools/setup.sh /usr/local/bin/setup.sh
RUN chmod +x /usr/local/bin/setup.sh

WORKDIR /var/www/html

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/setup.sh"]

CMD ["/usr/sbin/php-fpm8.2", "-F"]
