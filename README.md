# docker-client

A docker image with a docker client installed, as well as docker-compose.

This image is designed to be used in CI environments that only need to connect to a remote docker daemon.

Installed in this image:

- alpine
- bash
- curl
- git
- openssh-client
- docker (client only)
- docker-compose

## Build

```
docker build -t enigmampc/docker-client:latest .
```

## Push

```
docker push enigmampc/docker-client:latest
```

## Pull

```
docker pull enigmampc/docker-client:latest
```
