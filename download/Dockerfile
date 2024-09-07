FROM docker.io/alpine:3.20.3

RUN apk add --no-cache parallel bash aria2

COPY . /docker

RUN chmod +x /docker/download.sh

ENTRYPOINT ["/docker/download.sh"]
