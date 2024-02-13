ARG TAG=12
FROM my-debian:$TAG

RUN dpkg --add-architecture i386

RUN wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key \
    && wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/debian/dists/bookworm/winehq-bookworm.sources \
    && apt-get update \
    && DEBIAN_FRONTEND="noninteractive" apt install --install-recommends -y \
        winehq-staging \
        xserver-xorg xinit x11-apps





