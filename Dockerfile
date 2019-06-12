FROM ruby:alpine3.9

RUN apk update \
    && apk add \
        --no-cache \
        git \
        icu-libs

RUN apk add \
        --no-cache \
        --virtual build-deps \
        build-base \
        icu-dev \
    && gem install \
        gollum \
        github-markdown \
    && apk del build-deps

COPY overlay /

RUN adduser -D wiki
ENV HOME /home/wiki

EXPOSE 8080
VOLUME /wiki
WORKDIR /wiki

ENTRYPOINT ["/usr/local/bin/entrypoint"]
CMD ["--live-preview"]
