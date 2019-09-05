#!/bin/bash

set -Eeuox pipefail
cd "$(dirname "$0")"

bash -c ./build.sh

docker pull nginx

if docker ps | grep -a eatmeathodl; then
    docker kill eatmeathodl
fi

docker system prune -f

EXTERNAL_PORT="9000"
HOSTNAME="127.0.0.1"
docker run -d \
--name=eatmeathodl \
-p "127.0.0.1:$EXTERNAL_PORT:80" \
-v "$PWD/_site:/usr/share/nginx/html:ro" \
-e NGINX_HOST="$HOSTNAME" \
-e NGINX_PORT="$EXTERNAL_PORT" \
nginx

echo "Note! You can find a locally running copy of your site at $HOSTNAME:$EXTERNAL_PORT"
