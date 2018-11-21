FROM ruby:alpine3.7

RUN apk update && \
    apk add --no-cache git icu-libs

RUN apk add --no-cache --virtual build-deps build-base icu-dev && \
    gem install gollum github-markdown && \
    apk del build-deps

RUN adduser -D wiki
COPY rootfs /

USER wiki:wiki
ENTRYPOINT ["/usr/bin/entrypoint"]
CMD ["--live-preview"]

EXPOSE 8080
VOLUME /wiki
WORKDIR /wiki
