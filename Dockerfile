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

ENV HOME /home/wiki
RUN adduser -D wiki \
    && touch ${HOME}/.gitconfig \
    && chmod a+rw ${HOME}/.gitconfig \
    && chown wiki:wiki ${HOME}/.gitconfig

EXPOSE 8080
VOLUME /mnt/wiki
WORKDIR /mnt/wiki

ENTRYPOINT ["/usr/local/bin/entrypoint"]
CMD ["--live-preview"]
