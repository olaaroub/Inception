FROM debian:12-slim

RUN apt-get update && \
	apt-get install -y wget php php-mysql && \
	rm -rf /var/lib/apt/lists/*
# --no-install-recommends ca-certificates
WORKDIR /var/www/html

RUN wget "http://www.adminer.org/latest.php" -O "index.php"
RUN chmod 755 index.php

EXPOSE 8080

CMD [ "php", "-S", "0.0.0.0:8080"]
