FROM alpine

RUN apk add --no-cache bash curl git openssh-client make

ENV VERSION "18.09.6"
RUN curl -L -o /tmp/docker-$VERSION.tgz https://download.docker.com/linux/static/stable/x86_64/docker-$VERSION.tgz \
    && tar -xz -C /tmp -f /tmp/docker-$VERSION.tgz \
    && mv /tmp/docker/docker /usr/bin \
    && rm -rf /tmp/docker-$VERSION /tmp/docker

RUN set -x && \
    apk add --no-cache -t .deps ca-certificates && \
    # Install glibc on Alpine (required by docker-compose) from
    # https://github.com/sgerrand/alpine-pkg-glibc
    # See also https://github.com/gliderlabs/docker-alpine/issues/11
    wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.29-r0/glibc-2.29-r0.apk && \
    apk add glibc-2.29-r0.apk && \
    rm glibc-2.29-r0.apk && \
    apk del --purge .deps

# Required for docker-compose to find zlib.
ENV LD_LIBRARY_PATH=/lib:/usr/lib

ENV DOCKER_COMPOSE_VERSION "1.23.2"

RUN set -x && \
    apk add --no-cache -t .deps ca-certificates && \
    # Required dependencies.
    apk add --no-cache zlib libgcc && \
	curl -L https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > /usr/bin/docker-compose && \
	chmod +x /usr/bin/docker-compose && \
	\
	# Clean-up
    apk del --purge .deps && \
    \
    # Basic check it works
    docker-compose version
