#!/bin/bash

if ! command -v regctl >/dev/null 2>&1; then
    echo "regclient is not installed"
    exit 1
fi

IFS=":" read -r image_name image_tag <<< "$1"

destination_registry="localhost:443/mirror/hub.docker.com"
out_file="./docker_pull.sh"
matching_tag=false
echo "docker pull $image_name:$image_tag \\" > $out_file
for tag in $(regctl tag ls "${image_name}"); do
    tp="$(regctl image digest ${image_name}:${tag})"
    if [ "$image_sha" = "$tp" ]; then
        matching_tag=true
        echo "$tag"
        echo "&& docker image tag $image_name:$image_tag $destination_registry/$image_name:$tag \\" >> $out_file
    fi
done

echo "&& docker image push $destination_registry/$image_name" >> $out_file
