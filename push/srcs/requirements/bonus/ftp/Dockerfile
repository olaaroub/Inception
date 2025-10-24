FROM debian:12-slim

RUN apt-get update && \
    apt-get install -y vsftpd && \
    rm -rf /var/lib/apt/lists/*

COPY tools/setup.sh /usr/local/bin/setup.sh
RUN chmod +x /usr/local/bin/setup.sh

EXPOSE 21 50000-50100

ENTRYPOINT [ "/usr/local/bin/setup.sh" ]
CMD [ "/usr/sbin/vsftpd" ]