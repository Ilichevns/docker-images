ARG TAG=latest
FROM debian:$TAG

RUN ln -sf /usr/share/zoneinfo/Europe/Moscow  /etc/localtime

RUN apt-get update \
    && DEBIAN_FRONTEND="noninteractive" apt-get install -y apt-utils

RUN apt-get update \
    && DEBIAN_FRONTEND="noninteractive" apt-get install -y --no-install-recommends \
        iproute2 \
        curl \
        dbus-x11 \
        firefox-esr \
        locales \
        pulseaudio \
        pulseaudio-utils \
        xz-utils \
        x11-xserver-utils

RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y --no-install-recommends \
    openssh-client

RUN groupadd --gid 1000 tor-browser \
    && useradd --uid 1000 --gid 1000 --create-home --home-dir /home/tor-browser tor-browser

RUN sed -i -e '/ru_RU.UTF-8/s/^#//' /etc/locale.gen \
    && locale-gen "ru_RU.UTF-8"

COPY ./tor-browser.tar.xz /opt

RUN cd /opt && tar -xvf ./tor-browser.tar.xz && rm ./tor-browser.tar.xz \
    && chown tor-browser:tor-browser -R /opt/tor-browser \
    && ln -s /opt/tor-browser/Browser/start-tor-browser /home/tor-browser/

ENTRYPOINT ["/bin/bash"]
