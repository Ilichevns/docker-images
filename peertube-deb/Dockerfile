ARG TAG=latest
FROM my-deb0:$TAG

RUN apt-get update \
    && DEBIAN_FRONTEND="noninteractive" apt-get install -y \
        curl sudo unzip vim \
        python3-dev python-is-python3 \
        certbot nginx ffmpeg postgresql postgresql-contrib openssl g++ make redis-server git cron wget

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

RUN groupadd --gid 1001 peertube \
    && useradd --shell /bin/bash --uid 1001 --gid 1001 --password $(openssl passwd peertube) --create-home --home-dir /var/www/peertube peertube

RUN cd /var/www/peertube \
    && sudo -u peertube mkdir config storage versions \
    && chmod 750 config

# Peertube directory
RUN cd /var/www/peertube/versions \
    && VERSION=$(curl -s https://api.github.com/repos/chocobozzz/peertube/releases/latest | grep tag_name | cut -d '"' -f 4) \
    && echo "Latest Peertube version is $VERSION" | tee VERSION \
    && sudo -u peertube curl -L "https://github.com/Chocobozzz/PeerTube/releases/download/${VERSION}/peertube-${VERSION}.zip" -o "peertube-${VERSION}.zip" \
    && sudo -u peertube unzip -q "peertube-${VERSION}.zip" 
    
RUN cd /var/www/peertube/versions \
    && VERSION=$(awk '{print $5}' VERSION ) \
    && sudo -u peertube rm "peertube-${VERSION}.zip"

RUN cd /var/www/peertube \
    && VERSION=$(awk '{print $5}' versions/VERSION ) \
    && ln -s versions/peertube-${VERSION} ./peertube-latest \
    && cd ./peertube-latest \
    && sudo -H -u peertube yarn install --production --pure-lockfile

# WIP: Peertube configuration
# https://docs.joinpeertube.org/install-any-os?id=wrench-peertube-configuration
RUN cd /var/www/peertube \
    && sudo -u peertube cp peertube-latest/config/default.yaml config/default.yaml

COPY config/production.yaml /var/www/peertube/config/production.yaml

ENV WEBSERVER_HOST=example.com

# update secret
RUN cd /var/www/peertube \
    && SECRET=$(openssl rand -hex 32) \
    && sed -i 's/_PEERTUBE_SECRET_/'"$SECRET"'/' config/production.yaml

# WIP: Webserver
RUN cp /var/www/peertube/peertube-latest/support/nginx/peertube /etc/nginx/sites-available/peertube \
    && sed -i 's/${WEBSERVER_HOST}/'"${WEBSERVER_HOST}"'/g' /etc/nginx/sites-available/peertube \
    && sed -i 's/${PEERTUBE_HOST}/127.0.0.1:9000/g' /etc/nginx/sites-available/peertube \
    && ln -s /etc/nginx/sites-available/peertube /etc/nginx/sites-enabled/peertube

# WIP: generate the certificate
# RUN certbot certonly --standalone --post-hook "/etc/init.d/nginx restart" \
#     && /etc/init.d/nginx reload
#   ssl_certificate     /etc/letsencrypt/live/example.com/fullchain.pem;
#   ssl_certificate_key /etc/letsencrypt/live/example.com/privkey.pem
RUN mkdir -p /etc/letsencrypt/live/example.com/ \
    && openssl req -newkey rsa:2048 -nodes -x509 -days 365 \
    -subj "/C=XX/ST=XX/L=XX/O=XX/CN=example.com" \
    -keyout /etc/letsencrypt/live/example.com/privkey.pem \
    -out /etc/letsencrypt/live/example.com/fullchain.pem

# WIP: Database (make database at volume)
# /var/lib/pgsql/data
# RUN ls -l /mnt
RUN /etc/init.d/postgresql start \
    && sudo -u postgres psql -c "CREATE USER peertube WITH PASSWORD 'peertube';" \
    && sudo -u postgres psql -c '\du' \
    && sudo -u postgres createdb -O peertube -E UTF8 -T template0 peertube_prod \
    && sudo -u postgres psql -c "CREATE EXTENSION pg_trgm;" peertube_prod \
    && sudo -u postgres psql -c "CREATE EXTENSION unaccent;" peertube_prod \
    && sudo -u postgres psql -c '\l'

# Peertube Start script
RUN cp /var/www/peertube/peertube-latest/support/init.d/peertube /etc/init.d/ \
    && chmod 755 /etc/init.d/peertube

CMD bash

# CMD /etc/init.d/postgresql start \
#     && /etc/init.d/redis-server start \
#     && /etc/init.d/nginx start
#     && /bin/bash
# CMD su - debian

