# homelab_infra

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

```
$ docker network create traefik
$ docker compose up -d
```

```
$ docker compose down
```

## Setting up HTTP services that are not inside HomeLab

1. add [service].toml to external folder

2. add [service].toml to

```toml
[http.routers]
  [http.routers.[service]]
    entryPoints = ["websecure"]
    rule = "Host(`[service].minpeter.tech`)"
    service = "[service]-ext-srv"
    [http.routers.[service].tls]
      certResolver = "myresolver"
[[http.services.[service]-ext-srv.loadBalancer.servers]]
  url = "http://[service]:[port]"
```

// If the service is running on the same server, connect to host.docker.internal:[port]

## Setting up TCP services that are not inside HomeLab

1. add [service].toml to external folder

2. add [service].toml to

```toml
[tcp.routers]
  [tcp.routers.[service]]
    rule = "HostSNI(`[service].minpeter.tech`)"
    service = "[service]-ext-srv"
    [tcp.routers.[service].tls]
[[tcp.services.[service]-ext-srv.loadBalancer.servers]]
  address = "[service]:[port]"
```

3. disable proxy for the service domain in cloudflare DNS

// If the service is running on the same server, connect to host.docker.internal:[port]
