ARG TAG=latest
FROM debian:$TAG

RUN ln -sf /usr/share/zoneinfo/Europe/Moscow  /etc/localtime

RUN rm -rf /etc/apt/sources.list.d

COPY sources.list /etc/apt/sources.list

RUN apt-get update \
    && DEBIAN_FRONTEND="noninteractive" apt-get install -y apt-utils

RUN apt-get update \
    && DEBIAN_FRONTEND="noninteractive" apt-get install -y \
        locales \
        vim \
        bash-completion \
        sudo \
        man \
        procps \
        wget

# make ru_RU locale
RUN sed -i -e '/ru_RU.UTF-8/s/^#//' /etc/locale.gen \
    && locale-gen "ru_RU.UTF-8"

ENV LANG=ru_RU.UTF-8 \
    LANGUAGE=ru_RU:UTF-8

# CMD su --whitelist-environment=LANG,LANGUAGE -l debian


