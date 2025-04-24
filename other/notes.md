# Notes

[Creating a test Proxy](https://www.charlesproxy.com/documentation/using-charles/ssl-certificates/)

[So you want to write a package manager](https://medium.com/@sdboyer/so-you-want-to-write-a-package-manager-4ae9c17d9527)

## How to run a docker image directly

+ `docker run --rm -it --user root --entrypoint -v /certs:/certs:ro /bin/sh alpine:latest`
+ `docker run --rm -it --user root --entrypoint -v /certs:/certs:ro /bin/bash alpine:latest`
