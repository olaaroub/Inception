FROM debian:12-slim

RUN apt-get update && \
	apt-get install -y nginx && \
	rm -rf /var/lib/apt/lists/*

COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY tools/app/index.html /var/www/html/index.html

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
