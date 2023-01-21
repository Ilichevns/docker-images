ARG TAG=latest
FROM debian:$TAG

RUN ln -sf /usr/share/zoneinfo/Europe/Moscow  /etc/localtime

COPY sources.list /etc/apt/sources.list

RUN apt-get update \
    && DEBIAN_FRONTEND="noninteractive" apt-get install -y \
        locales \
        vim \
        bash-completion \
        git \
        iproute2 \
        screen \
        sudo

# make ru_RU locale
RUN sed -i -e '/ru_RU.UTF-8/s/^#//' /etc/locale.gen \
    && locale-gen "ru_RU.UTF-8"

RUN groupadd --gid 1000 debian \
    && useradd --shell /bin/bash --uid 1000 --gid 1000 --password $(openssl passwd debian) --create-home --home-dir /home/debian debian \
    && usermod -aG sudo debian

ENV LANG=ru_RU.UTF-8 \
    LANGUAGE=ru_RU:UTF-8

CMD su --whitelist-environment=LANG,LANGUAGE -l debian


