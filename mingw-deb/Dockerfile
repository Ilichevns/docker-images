ARG TAG=latest
FROM my-deb0:$TAG

RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y \
        mingw-w64 \
        make

CMD su - debian

