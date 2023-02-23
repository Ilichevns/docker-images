ARG TAG=latest
FROM my-deb0:$TAG

RUN apt-get update \
    && DEBIAN_FRONTEND="noninteractive" apt-get install -y \
        curl sudo unzip vim \
        python3-dev python-is-python3 \
        certbot nginx ffmpeg openssl g++ make redis-server git cron wget

RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y \
        apt-transport-https gnupg

# nodejs way https://github.com/nodesource/distributions/blob/master/README.md#debinstall
# RUN curl -fsSL https://deb.nodesource.com/setup_19.x | bash - && apt-get install -y nodejs

RUN curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | gpg --dearmor | tee /usr/share/keyrings/nodesource.gpg >/dev/null
RUN curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | sudo tee /usr/share/keyrings/yarnkey.gpg >/dev/null

COPY nodesource.list yarn.list /etc/apt/sources.list.d/

RUN apt-get update \
    && DEBIAN_FRONTEND="noninteractive" apt-get install -y \
        nodejs yarn

# Убрать после пересборки основного образа
RUN apt-get update \
    && DEBIAN_FRONTEND="noninteractive" apt-get install -y \
        procps

# Точка монтирования volumes/peertube_www
RUN groupadd --gid 1001 peertube \
    && useradd --shell /bin/bash --uid 1001 --gid 1001 --password $(openssl passwd peertube) --create-home --home-dir /var/www/peertube peertube

# Точка монтирования volumes/peertube_cert
RUN mkdir -p /etc/letsencrypt/live


CMD bash





# CMD /etc/init.d/postgresql start \
#     && /etc/init.d/redis-server start \
#     && /etc/init.d/nginx start
#     && /bin/bash
# CMD su - debian

