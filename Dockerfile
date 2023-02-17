FROM openjdk:17

LABEL "repository"="https://github.com/lss233/mirai-http-docker" \
  "homepage"="https://github.com/lss233/mirai-http-docker" \
  "maintainer"="Lss233 <i@lss233.com>"

WORKDIR /app

COPY ./app /app/

ENTRYPOINT ["/app/mcl", "--disable-module", "updater"]