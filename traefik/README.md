```
$ docker network create traefik
$ docker compose up -d
```

```
$ docker compose down
```

# Setting up services not included in Homelab

1. add [service].toml to external_services

2. add [service].toml to

```toml
[http.routers]
  [http.routers.[service]]
    entryPoints = ["websecure"]
    rule = "Host(`[service].minpeter.cf`)"
    service = "[service]-ext-srv"
    [http.routers.[service].tls]
      certResolver = "myresolver"
[[http.services.[service]-ext-srv.loadBalancer.servers]]
  url = "http://[service]:[port]"
```
