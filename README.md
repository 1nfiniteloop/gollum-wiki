# Overview

This is a minimalistic Docker-image for [gollum wiki](https://github.com/gollum/gollum). Gollum is a simple wiki system built on top of Git.

# Usage

## 1. Build image

```bash
docker build --tag "local-registry/gollum-wiki:latest" .
```

## 2. Configure

Set git-user inside container with a static configuration-file `~/.gollum-wiki.env`:

```bash
GITCONFIG_USER_NAME=Your Name
GITCONFIG_USER_EMAIL=your.email@example.com
```

**NOTE:** Define variables without quotes since "there is no special handling of quotation marks. This means that they are part of the VAL" (https://docs.docker.com/compose/env-file/#syntax-rules).

...or set git-user temporary for wiki:

```bash
export GITCONFIG_USER_NAME="Your Name"
export GITCONFIG_USER_EMAIL="your.email@example.com"
export GOLLUM_EXTRA_ARGS="--plantuml-url http://plantuml:8080/png"
```

...or set git-user locally for the git-repository:

```bash
git config --local --add user.name "Your Name"
git config --local --add user.email "your.email@example.com"
```

## 3. Launch wiki:

First install script:

```bash
[ -e ${HOME}/bin ] || mkdir ${HOME}/bin
ln -s `pwd`/wiki ${HOME}/bin/wiki
```

Launch with `wiki ~/wiki/hello-world` or manually with:

```bash
docker run \
    --rm \
    --detach \
    --name=wiki \
    --publish=4567:8080 \
    --volume=`pwd`:/wiki \
    --env-file ${HOME}/.gollum-wiki.env \
    local-registry/gollum-wiki:latest
```

### Use with plantuml

Start plantuml server:

```bash
docker run \
    --name=plantuml \
    --detach \
    --publish 8080:8080 \
    plantuml/plantuml-server:latest
```

Start wiki with `wiki --docker-args "--link=plantuml" --gollum-args "--plantuml-url http://plantuml:8080/png" ~/wiki/hello-world` or manually with:

```bash
docker run \
    --rm \
    --detach \
    --name=wiki \
    --publish=4567:8080 \
    --volume=`pwd`:/wiki \
    --env-file ${HOME}/.gollum-wiki.env \
    --link=plantuml \
    local-registry/gollum-wiki:latest --live-preview --plantuml-url http://plantuml:8080/png
```

**NOTE**: you must resolve the hostname *plantuml* by adding it into `/etc/hosts` for example.

Reference: https://github.com/gollum/gollum/wiki#plantuml-diagrams

