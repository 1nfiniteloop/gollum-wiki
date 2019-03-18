# Overview

This is a minimalistic Docker-image for [gollum wiki](https://github.com/gollum/gollum). Gollum is a simple wiki system built on top of Git.

# Versions

* `1nfiniteloop/gollum-wiki:latest` from [here](https://github.com/1nfiniteloop/gollum-wiki).

# Volumes

* /wiki

# Ports

* 8080

# Environment variables


* GITCONFIG_USER_NAME
* GITCONFIG_USER_EMAIL


# Author

[Lars Gunnarsson](https://github.com/1nfiniteloop)

# License

MIT

# Usage

1. Get image with `docker pull 1nfiniteloop/gollum-wiki`.

2. Set git user inside container, preferably with a static configuration-file `~/.gollum-wiki.env` as below. **NOTE:** Define variables without quotes since there is no special handling of quotation marks. This means that they are part of the value ([docker docs]( https://docs.docker.com/compose/env-file/#syntax-rules)).
```bash
GITCONFIG_USER_NAME=Your Name
GITCONFIG_USER_EMAIL=your.email@example.com
```

3. Get script with `sudo curl -o /usr/local/bin/wiki https://raw.githubusercontent.com/1nfiniteloop/gollum-wiki/master/wiki` and make executable `sudo chmod +x /usr/local/bin/wiki`.

4. Start wiki with `mkdir -p ~/wiki/hello-world.wiki && wiki ~/wiki/hello-world.wiki`.

**Use with plantuml**

1. Start plantuml server
```bash
docker run \
    --name=plantuml \
    --detach \
    --publish 8080:8080 \
    plantuml/plantuml-server:latest
```

2. Start wiki with `wiki --docker-args "--link=plantuml" --gollum-args "--plantuml-url http://plantuml:8080/png" ~/wiki/hello-world.wiki`. **NOTE**: you must resolve the hostname *plantuml* for example by adding it into `/etc/hosts`. See further about plantuml support in https://github.com/gollum/gollum/wiki#plantuml-diagrams


