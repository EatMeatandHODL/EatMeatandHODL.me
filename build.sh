#!/bin/bash

set -Eeuo pipefail
cd "$(dirname "$0")"

if ! docker volume list | grep -q jekyllcache; then
    docker volume create jekyllcache
fi

export JEKYLL_VERSION=3.8
docker run --rm -it --volume=jekyllcache:/usr/local/bundle --volume="$PWD:/srv/jekyll" jekyll/jekyll:$JEKYLL_VERSION jekyll build
