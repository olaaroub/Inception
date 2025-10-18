FROM debian:12-slim

RUN apt-get update && \
    apt-get install -y wget && \
    rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/portainer/portainer/releases/download/2.20.1/portainer-2.20.1-linux-amd64.tar.gz -O portainer.tar.gz && \
    tar -xzf portainer.tar.gz && \
    rm portainer.tar.gz && \
    mv portainer /opt/portainer-binary

RUN mkdir /data

# Create a non-root user for security
RUN adduser --system --no-create-home portainer && \
    chown -R portainer:portainer /data /opt/portainer-binary

# Run as the non-root user
USER portainer

EXPOSE 9000

ENTRYPOINT [ "/opt/portainer-binary" ]

CMD [ "--data=/data" ]