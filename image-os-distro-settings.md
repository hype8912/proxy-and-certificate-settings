| OS/Distro | Image Base | Test Image[^test_image] | Test Image Size[^image_size] | Required Packages | Certificates Location | Update Certificates Command |
|---|:---:|---|:---:|---|---|---|
| AIX | Unix | | | | `/var/ssl/serts/` | `runmqakm` |
| Alpine Linux  | Alpine | alpine:latest | 3.5MB | ca-certificates, step-cli, unzip | `/usr/local/share/ca-certificates/` | `update-ca-certificates` |
| Android | Debian | budtmo/docker-android:emulator_14.0 | 3GB | | `/system/etc/security/cacerts/` | |
| Arch Linux | Arch | archlinux:latest | 150MB | curl, unzip, step-cli.rpm| `/etc/ca-certificates/trust-source/anchors/` | `update-ca-trust extract` |
| Clear Linux | Other Linux | clearlinux:latest | 69MB | | `/usr/local/share/ca-certificates/` | `update-ca-certificates` |
| Crux | Other Linux | curx:latest | 152MB | | `/etc/ssl/certs` | |
| Darwin | Unix | | | | | `security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain "$SSL_CA_CERT"`[^windows_mac] |
| Debian Linux | Debian | debian:stable-slim<br>ubuntu:latest | 27MB<br>28MB | curl, ca-certificates, unzip | `/usr/local/share/ca-certificates/` | `update-ca-certificates` |
| FreeBSD | Unix | | | | `/usr/local/share/certs/` | |
| Gentoo Linux | Gentoo | gentoo/python:latest | 611MB | | `/usr/local/share/ca-certificates/` | `update-ca-certificates` |
| Guix System | NixOS | metacall/guix:latest | 992MB | nss-certs | `/etc/ssl/certs/` | |
| Linux From Scratch | LFS | sundev79/nutyx-images:nutyx | 130MB | | `/etc/ssl/local/` | `make-ca -g --force` |
| NetBSD | Unix | | | | `/etc/openssl/certs/` | |
| NixOS | NixOS | nixos/nix:latest | 213MB | | `/etc/ssl/certs/` | <pre lang="bash">export NIX_SSL_CERT_FILE="$SSL_CERT_FILE"</pre> |
| Red Hat | RPM | almalinux:latest<br>amazonlinux:latest<br>centos8:latest<br>quay.io/centos/centos:stream10<br>eurolinux/eurolinux-9:latest<br>fedora:latest<br>rockylinux:9<br>oraclelinux:9<br>redhat/ubi9:latest[^ubi] | 75MB<br>51MB<br>80MB<br>105MB<br>61MB<br>56MB<br>61MB<br>101MB<br>84MB | curl, findutils, unzip, step-cli.rpm | `/etc/pki/ca-trust/source/anchors/` | `update-ca-trust extract` |
| Slackware | Slackware | aclemons/slackware:latest | 66MB | | `/etc/ssl/certs/` | `update-ca-certificates` |
| Solus | Other Linux | silkeh/solus:slim | 268MB | | `/usr/local/share/ca-certificates/` | `update-ca-certificates` |
| Sorcerer | Other Linux | sourcemage:latest | 251MB | | `/etc/ssl/certs/` | `update-ca-certificates` |
| SUSE | SUSE | opensuse/leap:latest<br>opensuse/tumbleweed:latest | 42MB<br>36MB | curl, unzip, step-cli.rpm | `/etc/pki/trust/anchors/` | `update-ca-certificates` |
| Void Linux | Other Linux | voidlinux/voidlinux:latest | 43MB | | `/usr/local/share/ca-certificates/` | `update-ca-certificates` |
| Windows | Windows | mcr.microsoft.com/dotnet/framework/sdk:4.8.1 | 2.2GB | | | `certutil.exe -addstore CA "%SSL_CERT_FILE%"`[^windows_mac] |

## References

* [Linux Distro History Map](https://upload.wikimedia.org/wikipedia/commons/1/1b/Linux_Distribution_Timeline.svg)
* [Distroware Archive](https://distroware.gitlab.io/)
* [Unix Distro History Map](https://upload.wikimedia.org/wikipedia/commons/7/77/Unix_history-simple.svg)
* https://github.com/casey/just

[^test_image]: Every attempt is made to find the recently updated images from known publishers but some images are very old or published by individuals and should be used at your own risk.
[^image_size]: `Test Image Size` are approximate and mainly given for managing bandwidth when testing in a pipeline. Image sizes could change at any time.
[^windows_mac]: https://manuals.gfi.com/en/kerio/connect/content/server-configuration/ssl-certificates/adding-trusted-root-certificates-to-the-server-1605.html
[^ubi]: Red Hat UBI images require a subscription to use.
