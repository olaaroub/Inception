FROM debian:12-slim

RUN apt-get update && \
	apt-get install mariadb-server -y && \
	rm -rf /var/lib/apt/lists/*

COPY conf/mariadb.cnf /etc/mysql/mariadb.conf.d/99-custom.cnf



COPY tools/init.sh /usr/local/bin/init.sh

RUN chmod +x /usr/local/bin/init.sh

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/init.sh"]

CMD [ "mysqld_safe" ]
