# homelab_infra

This is a collection of scripts and configuration files that I use to manage my homelab infrastructure.

(VPN power by tailsacle :)

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
echo "<username>:<htpassword>" >> secrets/usersfile
```

5. cloudflare settings

```
A record: *.domain.com -> <server_ip>
A record: domain.com -> <server_ip>

SSL -> Full (strict)
```

API token 발급

![image](https://github.com/minpeter/homelab_infra/assets/62207008/03e39852-ca62-47fa-8098-10e98f824191)


그리고 secrets/cf-dns-api-token 파일에 토큰을 넣는다.

6. server start up

```sh
docker-compose up -d
```

https://dockge.domain.com로 접속해서 필요한 서비스를 시작시킨다.

## Setting up HTTP services that are not inside HomeLab

1. add [service].toml to external folder

2. add [service].toml to

```toml
[http.routers]
  [http.routers.[service]]
    rule = "Host(`[service].minpeter.tech`)"
    service = "[service]-ext-srv"
    [http.routers.[service].tls]
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
