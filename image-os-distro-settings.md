# Image/OS/Distro Proxy Settings

| OS/Distro | Image Base | Test Image[^test_image] | Test Image Size[^test_image] | Required Packages | Certificates Location | Update Certificates Command |
| --- | :---: | --- | :---: | --- | --- | --- |
| AIX | Unix | | | | `/var/ssl/certs/` | <code class="language-bash">runmqakm</code> |
| Alpine Linux | Alpine | alpine:latest | 3.5MB | ca-certificates, step-cli, unzip | `/usr/local/share/ca-certificates/` | <code class="language-bash">update-ca-certificates</code> |
| Android | Debian | budtmo/docker-android:emulator_14.0 | 3GB | | `/system/etc/security/cacerts/` | |
| Arch Linux | Arch | archlinux:latest | 150MB | curl, unzip, step-cli | `/etc/ca-certificates/trust-source/anchors/` | <code class="language-bash">update-ca-trust extract</code> |
| ChromeOS | Other Linux | satmandu/crewbuild:latest | 1.9GB | | | |
| Clear Linux | Other Linux | clearlinux:latest | 69MB | | `/usr/local/share/ca-certificates/` | <code class="language-bash">update-ca-certificates</code> |
| CoreOS[^coreos] | RPM | | | | `/etc/pki/ca-trust/source/anchors/` | <code class="language-bash">update-ca-certificates</code> |
| Crux | Other Linux | crux:latest | 152MB | | `/etc/ssl/certs` | |
| Darwin | Unix | | | | `/Library/Keychains/System.keychain` | <pre style="white-space:pre-wrap;"><code class="language-bash" style="white-space:pre-wrap;">security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain "$SSL_CA_CERT"&#13;cp /etc/ssl/cert.pem "$SSL_CERT_FILE"</code>[^windows_mac]</pre> |
| Debian Linux | Debian | debian:stable-slim<br>ubuntu:latest | 27MB<br>28MB | ca-certificates, curl, unzip | `/usr/local/share/ca-certificates/` | <code class="language-bash">update-ca-certificates</code> |
| FreeBSD | Unix | | | | `/usr/local/share/certs/` | |
| Gentoo Linux[^gentoo] | Gentoo | gentoo/python:latest | 611MB | | `/usr/local/share/ca-certificates/` | <code class="language-bash">update-ca-certificates</code> |
| Guix System | NixOS | metacall/guix:latest | 992MB | nss-certs | `/etc/ssl/certs/` | |
| Linux From Scratch | LFS | sundev79/nutyx-images:nutyx | 130MB | | `/etc/ssl/local/` | <code class="language-bash">make-ca -g --force</code> |
| NetBSD | Unix | | | | `/etc/openssl/certs/` | |
| NixOS | NixOS | nixos/nix:latest | 213MB | | `/etc/ssl/certs/` | <code class="language-bash">export NIX_SSL_CERT_FILE="$SSL_CERT_FILE"</code>[^nix_cert] |
| Red Hat | RPM | See [Red Hat Image Distros](other/redhat-image-distros.md) | | curl, findutils, unzip, [step-cli.rpm](https://dl.smallstep.com/cli/docs-ca-install/latest/step-cli_amd64.rpm) | `/etc/pki/ca-trust/source/anchors/`<br>`/usr/share/pki/ca-trust-source/anchors/`[^redhat_certs] | <code class="language-bash">update-ca-trust extract</code> |
| Slackware | Slackware | aclemons/slackware:latest | 66MB | | `/etc/ssl/certs/` | <code class="language-bash">update-ca-certificates</code> |
| Solus | Other Linux | silkeh/solus:slim | 268MB | | `/usr/local/share/ca-certificates/` | <code class="language-bash">update-ca-certificates</code> |
| Sorcerer | Other Linux | sourcemage:latest | 251MB | | `/etc/ssl/certs/` | <code class="language-bash">update-ca-certificates</code> |
| SUSE | SUSE | opensuse/archive:13.2<br>opensuse/leap:latest<br>opensuse/tumbleweed:latest | 37MB<br>42MB<br>36MB | curl, unzip, [step-cli.rpm](https://dl.smallstep.com/cli/docs-ca-install/latest/step-cli_amd64.rpm) | `/etc/pki/trust/anchors/` | <code class="language-bash">update-ca-certificates</code> |
| Void Linux | Other Linux | ghcr.io/void-linux/void-musl-full:latest | 81MB | | `/usr/local/share/ca-certificates/` | <code class="language-bash">update-ca-certificates</code> |
| Windows | Windows | mcr.microsoft.com/dotnet/framework/sdk:4.8.1 | 2.2GB | | | <code class="language-bat">certutil.exe -addstore CA "%SSL_CERT_FILE%"</code>[^windows_mac] |

## See also

+ [Linux Distro History Map](https://upload.wikimedia.org/wikipedia/commons/1/1b/Linux_Distribution_Timeline.svg)
+ [Distroware Archive](https://distroware.gitlab.io/)
+ [Unix Distro History Map](https://upload.wikimedia.org/wikipedia/commons/7/77/Unix_history-simple.svg)
+ [Add the certificate to operating systems](https://developers.cloudflare.com/cloudflare-one/connections/connect-devices/user-side-certificates/manual-deployment/#add-the-certificate-to-operating-systems)
+ https://github.com/casey/just
+ [Debian Release Names](https://www.debian.org/releases/)
+ [Ubuntu Release Names](https://wiki.ubuntu.com/Releases)

[^coreos]: https://github.com/endocode/coreos-docs/blob/master/os/adding-certificate-authorities.md
[^gentoo]: https://wiki.gentoo.org/wiki/Certificates#OpenSSL-compatible_ca-certificates
[^nix_cert]: https://nix.dev/manual/nix/2.24/installation/env-variables.html#nix_ssl_cert_file
[^redhat_certs]: https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/7/html/security_guide/sec-shared-system-certificates
[^test_image]: [Test Image Disclaimer](README.md#test-image)
[^windows_mac]: https://manuals.gfi.com/en/kerio/connect/content/server-configuration/ssl-certificates/adding-trusted-root-certificates-to-the-server-1605.html
