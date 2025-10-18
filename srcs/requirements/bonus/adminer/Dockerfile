FROM debian:12-slim

RUN apt-get update && \
	apt-get install -y wget php php-mysql && \
	rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html

RUN wget "https://www.adminer.org/latest.php" -O "adminer.php" && \
	chmod 755 adminer.php

EXPOSE 8080

CMD [ "php", "-S", "0.0.0.0:8080" ]
