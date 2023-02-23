#!/bin/bash
# Настройка новой БД

# WIP: Database (make database at volume)
# /var/lib/pgsql/data
# RUN ls -l /mnt
/etc/init.d/postgresql start \
    && sudo -u postgres psql -c "CREATE USER peertube WITH PASSWORD 'peertube';" \
    && sudo -u postgres psql -c '\du' \
    && sudo -u postgres createdb -O peertube -E UTF8 -T template0 peertube_prod \
    && sudo -u postgres psql -c "CREATE EXTENSION pg_trgm;" peertube_prod \
    && sudo -u postgres psql -c "CREATE EXTENSION unaccent;" peertube_prod \
    && sudo -u postgres psql -c '\l'