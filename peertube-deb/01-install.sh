#!/bin/bash

# Установка PeerTube

cd /var/www/peertube \
    && sudo -u peertube mkdir config storage versions \
    && chmod 750 config

# Peertube directory
cd /var/www/peertube/versions \
    && VERSION=$(curl -s https://api.github.com/repos/chocobozzz/peertube/releases/latest | grep tag_name | cut -d '"' -f 4) \
    && echo "Latest Peertube version is $VERSION" | tee VERSION \
    && sudo -u peertube curl -L "https://github.com/Chocobozzz/PeerTube/releases/download/${VERSION}/peertube-${VERSION}.zip" -o "peertube-${VERSION}.zip" \
    && sudo -u peertube unzip -q "peertube-${VERSION}.zip" 
    
cd /var/www/peertube/versions \
    && VERSION=$(awk '{print $5}' VERSION ) \
    && sudo -u peertube rm "peertube-${VERSION}.zip"

cd /var/www/peertube \
    && VERSION=$(awk '{print $5}' versions/VERSION ) \
    && ln -s versions/peertube-${VERSION} ./peertube-latest \
    && cd ./peertube-latest \
    && sudo -H -u peertube yarn install --production --pure-lockfile

# WIP: Peertube configuration
# https://docs.joinpeertube.org/install-any-os?id=wrench-peertube-configuration
cd /var/www/peertube \
    && sudo -u peertube cp -v peertube-latest/config/default.yaml config/default.yaml

cd /var/www/peertube \
    && sudo -u peertube cp -v /var/www/distrib/config/production.yaml /var/www/peertube/config/production.yaml

export WEBSERVER_HOST=example.com

# update secret
cd /var/www/peertube \
    && SECRET=$(openssl rand -hex 32) \
    && sed -i 's/_PEERTUBE_SECRET_/'"$SECRET"'/' config/production.yaml

# Peertube Start script
cp /var/www/peertube/peertube-latest/support/init.d/peertube /etc/init.d/ \
    && chmod 755 /etc/init.d/peertube

# WIP: Webserver
export WEBSERVER_HOST=example.com; cp /var/www/peertube/peertube-latest/support/nginx/peertube /etc/nginx/sites-available/peertube \
    && sed -i 's/${WEBSERVER_HOST}/'"${WEBSERVER_HOST}"'/g' /etc/nginx/sites-available/peertube \
    && sed -i 's/${PEERTUBE_HOST}/127.0.0.1:9000/g' /etc/nginx/sites-available/peertube \
    && ln -s /etc/nginx/sites-available/peertube /etc/nginx/sites-enabled/peertube

# WIP: generate the certificate
# RUN certbot certonly --standalone --post-hook "/etc/init.d/nginx restart" \
#     && /etc/init.d/nginx reload
#   ssl_certificate     /etc/letsencrypt/live/example.com/fullchain.pem;
#   ssl_certificate_key /etc/letsencrypt/live/example.com/privkey.pem
mkdir -p /etc/letsencrypt/live/example.com/ \
    && openssl req -newkey rsa:2048 -nodes -x509 -days 365 \
    -subj "/C=XX/ST=XX/L=XX/O=XX/CN=example.com" \
    -keyout /etc/letsencrypt/live/example.com/privkey.pem \
    -out /etc/letsencrypt/live/example.com/fullchain.pem