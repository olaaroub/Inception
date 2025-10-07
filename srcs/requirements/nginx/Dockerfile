FROM debian:bullseye-slim

RUN apt-get update && \
	apt-get install nginx openssl -y \
	rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/yourlogin.key \
    -out /etc/nginx/ssl/yourlogin.crt \
    -subj "/C=MA/ST=Kech/L=Marrakech/O=42/OU=student/CN=olaaroub.42.fr"

COPY conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
