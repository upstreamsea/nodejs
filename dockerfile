  
# ----------------------------------
# Pterodactyl Core Dockerfile
# Environment: glibc
# Minimum Panel Version: 0.6.0
# ----------------------------------
FROM        node:10-alpine

LABEL       author="Nathan Clark" maintainer="upstream@slothhost.com"

RUN         apk add --no-cache mono --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing && apk add --no-cache --virtual=.build-dependencies ca-certificates && cert-sync /etc/ssl/certs/ca-certificates.crt && apk del .build-dependencies
RUN         apk add --no-cache --update libc6-compat ffmpeg git make gcc g++ python build-base cairo-dev jpeg-dev pango-dev giflib-dev sqlite-dev sqlite-libs sqlite \
            && adduser -D -h /home/container container

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh
CMD         ["/bin/bash", "/entrypoint.sh"]