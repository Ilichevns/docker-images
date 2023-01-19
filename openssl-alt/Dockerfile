ARG TAG=latest
FROM registry.altlinux.org/alt/alt:$TAG

RUN ln -sf /usr/share/zoneinfo/Europe/Moscow  /etc/localtime

RUN apt-get update \
    && DEBIAN_FRONTEND="noninteractive" apt-get install -y \
        openssl \
        openssl-gost-engine \
        iproute2 \
        curl \
        # bash-completion \
        # netcat \
        # socat

RUN /etc/control.d/facilities/openssl-gost enabled

# RUN groupadd --gid 1000 ansible \
#     && useradd --shell /bin/bash --uid 1000 --gid 1000 --password $(openssl passwd ansible) --create-home --home-dir /home/ansible ansible

# CMD su - ansible
#COPY entrypoint.sh /usr/bin/entrypoint
#ENTRYPOINT ["/usr/bin/entrypoint"]
