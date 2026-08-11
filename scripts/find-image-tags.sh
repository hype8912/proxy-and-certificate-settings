#!/bin/bash

if ! command -v regctl >/dev/null 2>&1; then
    echo "regclient is not installed"
    exit 1
fi

IFS=":" read -r image_name image_tag <<< "$1"

image_sha=$(regctl image digest "${image_name}:${image_tag}")
echo "Searching: ${image_name}:${image_tag} ${image_sha}"

destination_registry="localhost:443/mirror/hub.docker.com"
out_file="./docker_pull.sh"
matching_tag=false
pull_line_wrote=false
echo "docker pull ${image_name}:${image_tag} \\" > $out_file
for tag in $(regctl tag ls "${image_name}"); do
    tp="$(regctl image digest "${image_name}:${tag}")"
    if [ "${image_sha}" = "${tp}" ]; then
        if [ "${pull_line_wrote}" = "false" ]; then
            echo "docker pull ${image_name}@${image_sha} \\" > $out_file
            matching_tag=true
            pull_line_wrote=true
        else
            echo "${tag}"
            echo "&& docker image tag ${image_name}:${image_tag} ${destination_registry}/${image_name}:${tag} \\" >> $out_file
        fi
    fi
done

if [ "${matching_tag}" = "true" ]; then
    echo "&& docker image push ${destination_registry}/${image_name}" >> $out_file
else
    echo "No matching tags found."
fi

cat $out_file
