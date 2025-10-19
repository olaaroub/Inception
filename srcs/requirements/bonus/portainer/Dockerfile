FROM debian:12-slim

RUN apt update && \
    apt install -y curl ca-certificates \
    && rm -rf /var/lib/apt/lists/*
    # libssl-dev libsqlite3-0 libcurl4 libuuid1 && \

RUN mkdir -p /opt/portainer

RUN curl -L https://github.com/portainer/portainer/releases/download/2.33.2/portainer-2.33.2-linux-amd64.tar.gz -o /opt/portainer/portainer.tar.gz &&\
    tar -xzf /opt/portainer/portainer.tar.gz -C /opt/portainer --strip-components=1 && \
    rm /opt/portainer/portainer.tar.gz

RUN     mkdir -p /data

EXPOSE  9000

CMD ["/opt/portainer/portainer", "--data=/data", "--admin-password-file=/run/secrets/portainer_admin_password"]