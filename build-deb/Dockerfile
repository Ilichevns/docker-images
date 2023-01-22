ARG TAG=latest
FROM my-deb0:$TAG

COPY sources.list /etc/apt/sources.list

RUN apt-get update \
    && DEBIAN_FRONTEND="noninteractive" apt-get install -y \
        build-essential

CMD su - debian

