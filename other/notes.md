# Notes

[Creating a test Proxy](https://www.charlesproxy.com/documentation/using-charles/ssl-certificates/)

[So you want to write a package manager](https://medium.com/@sdboyer/so-you-want-to-write-a-package-manager-4ae9c17d9527)

## How to run a docker image directly

+ `docker run --rm -it --user root --entrypoint sh -v /certs:/certs:ro alpine:latest`
+ `docker run --rm -it --user root --entrypoint bash -v /certs:/certs:ro alpine:latest`

## XBPS

+ [How do I use xbps with an authenticated proxy?](https://unix.stackexchange.com/questions/510497/how-do-i-use-xbps-with-an-authenticated-proxy)
+ [Working xbps via proxy](https://www.reddit.com/r/voidlinux/comments/l1swcm/working_xbps_via_proxy/)
