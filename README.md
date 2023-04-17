## homelab_infra

This is a collection of scripts and configuration files that I use to manage my homelab infrastructure.

## Starting a new server

To start a new server, I use the following steps:

1. install docker

```sh
curl https://get.docker.com | sh
```

2. install docker-compose

```sh
sudo apt-get install docker-compose
```

3. clone this repo

```sh
git clone https://github.com/minpeter/homelab_infra.git
```

4. config .env

web interface passwod change

```
echo "WEBPASSWORD=<password>" > pihole/.env
echo "PASSWORD=<password>" > wg-easy/.env
```

set traefik basic auth username and password

```
echo "<username>:<htpassword>" >> traefik/usersfile
```

5. cloudflare settings

```
A record: *.domain.com -> <server_ip>
A record: domain.com -> <server_ip>

SSL -> Full (strict)

Page Rules
  - *domain.com/.well-known/acme-challenge/* -> SSL, off
  - *domain.com/* -> Always Use HTTPS
```

6. run the setup script

```sh
cd homelab_infra
./setup.sh
```

7. check server status

```sh
docker-compose ps
curl https://whoami.domain.com
```
