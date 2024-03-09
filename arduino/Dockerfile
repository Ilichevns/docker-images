ARG TAG=bullseye
FROM debian:$TAG

RUN ln -sf /usr/share/zoneinfo/Europe/Moscow  /etc/localtime

RUN apt-get update \
    && DEBIAN_FRONTEND="noninteractive" apt-get install -y apt-utils

RUN apt-get update \
    && DEBIAN_FRONTEND="noninteractive" apt-get install -y --no-install-recommends \
        arduino \
        bash-completion \
        procps

RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y python3-serial \
    && ln -s /usr/bin/python3 /usr/bin/python

RUN groupadd --gid 1000 \
    && useradd --uid 1000 --gid 1000 --create-home --home-dir /home/arduino arduino \
    && usermod -aG dialout arduino

ENTRYPOINT ["/bin/bash", "--login"]

