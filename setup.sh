#!/bin/sh

docker network create traefik

docker compose -f traefik/docker-compose.yml up -d

docker compose -f pihole/docker-compose.yml up -d
docker compose -f portainer/docker-compose.yml up -d

docker compose -f wg-easy/docker-compose.yml up -d
docker compose -f kuma/docker-compose.yml up -d

docker compose -f watchtower/docker-compose.yml up -d