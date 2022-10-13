FROM casjaysdevdocker/alpine:latest AS build

ARG alpine_version="latest"

ARG TIMEZONE="America/New_York" \
  IMAGE_NAME="docker" \
  LICENSE="MIT" \
  PORTS="2375"

ENV TZ="$TIMEZONE" \
  SHELL="/bin/bash" \
  TERM="xterm-256color" \
  HOSTNAME="${HOSTNAME:-casjaysdev-$IMAGE_NAME}"

RUN set -ex; \
  rm -Rf "/etc/apk/repositories"; \
  echo "http://dl-cdn.alpinelinux.org/alpine/$alpine_version/main" >> "/etc/apk/repositories"; \
  echo "http://dl-cdn.alpinelinux.org/alpine/$alpine_version/community" >> "/etc/apk/repositories"; \
  if [ "$alpine_version" = "edge" ]; then echo "http://dl-cdn.alpinelinux.org/alpine/$alpine_version/testing" >> "/etc/apk/repositories" ; fi ; \
  apk update --update-cache && apk add \
  docker-cli-compose \
  dockerize \
  docker \
  docker-cli \
  docker-cli-buildx \
  docker-engine \
  docker-registry

COPY ./bin/. /usr/local/bin/
COPY ./data/. /usr/local/share/template-files/data/
COPY ./config/. /usr/local/share/template-files/config/

RUN rm -Rf /bin/.gitkeep /usr/local/bin/.gitkeep /config /data /var/cache/apk/*

FROM scratch
ARG BUILD_DATE="2022-10-13" \
  BUILD_VERSION="latest"

LABEL maintainer="CasjaysDev <docker-admin@casjaysdev.com>" \
  org.opencontainers.image.vcs-type="Git" \
  org.opencontainers.image.name="docker" \
  org.opencontainers.image.base.name="docker" \
  org.opencontainers.image.license="$LICENSE" \
  org.opencontainers.image.vcs-ref="$BUILD_VERSION" \
  org.opencontainers.image.build-date="$BUILD_DATE" \
  org.opencontainers.image.version="$BUILD_VERSION" \
  org.opencontainers.image.schema-version="$BUILD_VERSION" \
  org.opencontainers.image.url="https://hub.docker.com/r/casjaysdevdocker/docker" \
  org.opencontainers.image.vcs-url="https://github.com/casjaysdevdocker/docker" \
  org.opencontainers.image.url.source="https://github.com/casjaysdevdocker/docker" \
  org.opencontainers.image.documentation="https://hub.docker.com/r/casjaysdevdocker/docker" \
  org.opencontainers.image.vendor="CasjaysDev" \
  org.opencontainers.image.authors="CasjaysDev" \
  org.opencontainers.image.description="Containerized version of docker"

ENV SHELL="/bin/bash" \
  TERM="xterm-256color" \
  HOSTNAME="casjaysdev-docker" \
  TZ="${TZ:-America/New_York}" \
  TIMEZONE="$$TIMEZONE" \
  PHP_SERVER="none" \
  PORT=""

COPY --from=build /. /

WORKDIR /root

VOLUME [ "/config","/data" ]

EXPOSE $PORTS

ENTRYPOINT [ "tini", "-p", "SIGTERM", "--" ]
CMD [ "/usr/local/bin/entrypoint-docker.sh" ]
HEALTHCHECK --start-period=1m --interval=2m --timeout=3s CMD [ "/usr/local/bin/entrypoint-docker.sh", "healthcheck" ]

