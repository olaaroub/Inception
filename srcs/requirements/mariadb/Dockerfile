FROM debian:bullseye-slim

RUN apt-get update && \
	apt-get install mariadb-sever -y && \
	rm -rf /var/lib/apt/lists/*

COPY conf/mariadb.cnf /etc/mysql/mariadb.conf.d/99-custom.cnf

EXPOSE 3306

CMD [ "mysqld_safe" ]
