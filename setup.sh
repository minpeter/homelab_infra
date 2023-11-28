#!/bin/sh

docker network create traefik

docker compose -f docker-compose.yml up -d

