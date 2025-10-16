FROM debian:bullseye-slim

# Install vsftpd (Very Secure FTP Daemon)
# This is the standard FTP server on Linux - lightweight and secure
RUN apt-get update && \
    apt-get install -y vsftpd && \
    rm -rf /var/lib/apt/lists/*

# Copy the vsftpd configuration file
# This controls how the FTP server behaves
COPY conf/vsftpd.conf /etc/vsftpd.conf

# Copy the setup script that creates the FTP user
COPY tools/setup.sh /usr/local/bin/setup.sh
RUN chmod +x /usr/local/bin/setup.sh

# FTP uses two types of ports:
# Port 21: Command port (for FTP commands like login, list files, etc.)
# Ports 21000-21010: Passive mode data ports (for actual file transfers)
EXPOSE 21 21000-21010

# Run our setup script, then start vsftpd in foreground mode
ENTRYPOINT ["/usr/local/bin/setup.sh"]
CMD ["vsftpd", "/etc/vsftpd.conf"]
