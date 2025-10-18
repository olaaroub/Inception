FROM debian:12-slim

RUN apt-get update && \
	apt-get insall -y nginx && \
	rm -rf /var/lib/apt/lists/*

COPY conf/nginx.conf /etc/nginx/nginx.conf

COPY tools/app /