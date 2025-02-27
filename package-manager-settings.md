<style>
  table {
    width: 100%;
  }
</style>

Set the applicable [proxy](proxy-environment-variables.md), [certificate](certificate-environment-variables.md), and [OS/Distro](image-os-distro-settings.md) variables along with [application](application-proxy-settings.md) configurations.

# Current Package Managers

If no information is provide in the `Proxy Instructions` or `Certificate Instructions` means they use the typical OS or Distro environment values and will work just by setting those value(s).

| Package manager | Name | Image Base | Test Image[^test_image] | Test Image Size[^image_size] | Proxy Instructions | Certificate Instructions |
|:---:|:---:|:---:|---|:---:|---|---|
| alr | Alire | Debian | esolang/ada:latest | 286MB | | |
| apk | Alpine Package | Alpine | alpine:latest | 3.5MB | | |
| apt<a name="apt"></a> | Advanced Package Tool | Debian | debian:stable-slim<br>ubuntu:latest | 27MB<br>28MB | <pre lang="bash">echo 'Acquire::http::Proxy "$HTTP_PROXY";' > /etc/apt/apt.conf.d/00proxy&#13;echo 'Acquire::https::Proxy "$HTTPS_PROXY";' >> /etc/apt/apt.conf.d/00proxy</pre> | |
| apt-get | | Debian | debian:stable-slim<br>ubuntu:latest | 27MB<br>28MB | See [apt](#apt). | |
| apx | | Debian | ghcr.io/vanilla-os/desktop:v1.1.3 | 3.2GB | | |
| bower | Bower (node)[^bower] | Debian | danlynn/ember-cli:latest | 717MB | See [npm](#npm).<pre lang="bash">export bower_proxy="$HTTP_PROXY"&#13;export bower_https_proxy="$HTTPS_PROXY"</pre> | See [npm](#npm).<pre lang="bash">export bower_ca="$SSL_CERT_FILE"</pre> |
| brew | Homebrew | Debian | homebrew/brew:latest | 1.2GB[^brew] | | |
| bun | Bun (node) | Alpine<br>Debian | oven/bun:alpine<br>oven/bun:latest | 44MB<br>88MB | See [npm](#npm). | See [npm](#npm). |
| bundle | Bundler (ruby) | Alpine | alpine/bundle:latest | 339MB | | |
| cabal | Cabal 2+ | Debian | haskell:9.4.3-slim<br>haskell:slim | 319MB<br>576MB | | |
| cards | | Linux From Scratch | sundev79/nutyx-images:nutyx | 130MB | | |
| cargo | Cargo (rust)[^cargo] | Debian | rust:slim | 280MB | | <pre lang="bash">export CARGO_HTTP_CAINFO="$SSL_CERT_FILE"</pre> |
| cast | | Sorcerer | sourcemage:latest | 251MB | | |
| ck | Collective Knowledge | Debian | ctuning/ck-web-server:latest | 135MB | | |
| composer | Composer (PHP)[^composer] | Alpine | composer:latest | 71MB | <pre lang="bash">export CGI_HTTP_PROXY="HTTP_PROXY"</pre> | |
| conan | Conan | Debian | conanio/gcc9:2.9.1 | 306MB | | <pre lang="bash">export CONAN_CACERT_PATH="$SSL_CERT_FILE"</pre> |
| conda<a name="conda"></a> | Conda | Debian | continuumio/miniconda3:latest | 198MB | `conda config --set proxy_servers.http "$HTTP_PROXY"`<br>`conda config --set proxy_servers.https "$HTTPS_PROXY"` | `conda config --set ssl_verify "$SSL_CERT_FILE"` |
| corepack | Corepack (node) | Alpine<br>Debian | node:current-alpine<br>node:slim | 54MB<br>76MB | See [npm](#npm). | See [npm](#npm). |
| cpan | CPAN | Debian | perl:stable-slim | 56MB | | |
| cran | CRAN | Debian | r-base:latest | 343MB | | |
| ctan | CTAN | Debian | esolang/tex:latest | 245MB | |
| dart | Dart Pub | Debian | dart:stable | 291MB | | |
| deno | Deno (node) | Alpine<br>Debian | denoland/deno:alpine<br>denoland/deno:latest | 50MB<br>71MB | See [npm](#npm). | See [npm](#npm).<pre lang="bash">export DENO_CERT="$SSL_CERT_FILE"&#13;export DENO_TLS_CA_STORE=system</pre> |
| dnf<a name="dnf"></a> | DNF | Red Hat | almalinux:latest<br>amazonlinux:latest<br>centos8:latest<br>quay.io/centos/centos:stream10<br>eurolinux/eurolinux-9:latest<br>fedora:latest<br>rockylinux:9<br>oraclelinux:9<br>redhat/ubi9:latest[^ubi] | 75MB<br>80MB<br>105MB<br>61MB<br>56MB<br>61MB<br>101MB<br>84MB | <pre lang="bash">echo "proxy=$HTTP_PROXY" >> /etc/dnf/dnf.conf</pre> | |
| dpkg | Debian Package | Debian | debian:stable-slim<br>ubuntu:latest | 27MB<br>28MB | See [apt](#apt). | |
| dub | DUB | Debian | dlanguage/ldc:latest | 304MB | | |
| emerge | Portage | Gentoo | gentoo/stage3:musl<br>gentoo/python:latest | 290MB<br>611MB | | |
| eopkg | | Solus (Evolve OS) | silkeh/solus:slim | 268MB | | |
| fink | Fink | MacOS | | | | |
| flatpak | Flatpak | Debian<br>Red Hat | flatpak/flatpak-builder:base<br>freedesktopsdk/flatpak:latest | 295MB<br>611MB | | |
| fpm | Fortran Package Manager | Alpine | esolang/fortran:latest | 141MB | | |
| gem | RubyGem | Debian | ruby:slim | 80MB | | |
| go | Go Modules | Debian | golang:bookworm | 289MB | | |
| gradle | Gradle[^gradle] | Debian | gradle:latest | 377MB | <pre lang="bash">gradlew -Dhttp.proxyHost=$HTTP_PROXY_HOST \ &#13; -Dhttp.proxyPort=$HTTP_PROXY_PORT \ &#13; -Dhttps.proxyHost=$HTTPS_PROXY_HOST \ &#13; -Dhttps.proxyPort=$HTTPS_PROXY_PORT \ &#13; -Dhttp.nonProxyHosts=$NO_PROXY \ &#13; -Dhttps.nonProxyHosts=$NO_PROXY</pre> | |
| guix | GNU Guix | NixOS | metacall/guix:latest | 992MB | | |
| hatch | Hatchling (python) | | | | | See [pip](#pip). |
| hex[^hex] | | Debian | erlang:slim | 119MB | | <pre lang="bash">export HEX_CACERTS_PATH="$SSL_CERT_FILE"</pre> |
| hpm | HarmonyOS Package Manager | | | | <pre lang="bash">hpm config set http_proxy $HTTP_PROXY&#13;hpm config set https_proxy $HTTPS_PROXY</pre> | |
| lein<a name="lein"></a> | Leiningen | Debian | clojure:latest | 287MB | | See [java](https://gist.github.com/hype8912/40116cb5e1051fc1a9b29ea54e6c2139#java). |
| luarocks | LuaRocks | Alpine<br>Debian | nickblah/lua:5-luarocks-alpine3<br>nickblah/lua:latest | 7MB<br>47MB | | |
| mamba | Mamba | Debian | condaforge/miniforge3:latest | 141MB | | See [conda](#conda).<pre lang="bash">export CURL_CA_BUNDLE="$SSL_CA_CERT"&#13;export REQUESTS_CA_BUNDLE="SSL_CERT_FILE"</pre> |
| microdnf | MicroDNF | Red Hat | almalinux:9-minimal<br>centos:stream10-minimal<br>eurolinux/eurolinux-9-minimal:latest<br>rockylinux:9-minimal<br>oraclelinux:9-slim<br>redhat/ubi9-minimal:latest[^ubi] | 34MB<br>78MB<br>37MB<br>44MB<br>47MB<br>38MB | See [dnf](#dnf) | |
| micromamba | Micromamba | Debian | mambaorg/micromamba:latest | 33MB | | <pre lang="bash">export CURL_CA_BUNDLE="$SSL_CA_CERT"&#13;export REQUESTS_CA_BUNDLE="SSL_CERT_FILE"&#13;micromamba config set ssl_verify "$SSL_CERT_FILE"</pre> |
| mvn | Maven | Debian | maven:latest | 231MB | <pre lang="bash">mvn -DproxySet=true -D proxyHost=$HTTP_PROXY_HOST \ &#13; -DproxyPort=$HTTP_PROXY_PORT \ &#13; -DproxyProtocol=http \ &#13; -DproxyId=http \ &#13; -DproxyNonProxyHosts=$NO_PROXY&#13;mvn -D proxyHost=$HTTPS_PROXY_HOST \ &#13; -DproxyPort=$HTTPS_PROXY_PORT \ &#13; -DproxyProtocol=https \ &#13; -DproxyId=https \ &#13; -DproxyNonProxyHosts=$NO_PROXY</pre> | See [java](https://gist.github.com/hype8912/40116cb5e1051fc1a9b29ea54e6c2139#java).<pre lang="bash">export MAVEN_OPTS="-Djavax.net.ssl.trustStore=$SSL_KEYSTORE_FILE -Djavax.net.ssl.trustStorePassword={Password}"</pre> |
| nix | Nix Package Manager | NixOS | nixos:nix:latest | 213MB | | <pre lang="bash">export NIX_SSL_CERT_FILE="$SSL_CERT_FILE"</pre> |
| npm<a name="npm"></a> | Node Package Manager | Alpine<br>Debian | node:current-alpine<br>node:slim | 54MB<br>76MB | <pre lang="bash">npm config set proxy "$HTTP_PROXY"&#13;npm config set https-proxy "$HTTPS_PROXY"&#13;npm config set noproxy "$NO_PROXY"</pre>Electron:<pre lang="bash">export ELECTRON_GET_USE_PROXY=true</pre> | <pre lang="bash">export NODE_EXTRA_CA_CERTS="$SSL_CERT_FILE"</pre> |
| nuget | NuGet | Windows | mcr.microsoft.com/dotnet/framework/sdk:4.8.1 | 2.2GB | <pre lang="bash">nuget config -set http_proxy="$HTTP_PROXY"&#13;nuget config -set https_proxy="$HTTPS_PROXY"</pre> | |
| opam | opam | Alpine<br>Debian | ocaml/opam:alpine<br>ocaml/opam:latest | 477MB<br>604MB | | |
| pacman | Pacman | Arch Linux | archlinux:latest | 150MB | | |
| paket | | Debian | nojaf/fable:latest | 284MB | | |
| pdm | pdm (python) | Debian | frostming/pdm:latest | 47MB | | See [pip](#pip). |
| pear[^pear] | PEAR (PHP) | Alpine<br>Debian | php:alpine<br>php:latest | 40MB<br>178MB | <pre lang="bash">pear config-set http_proxy "$HTTP_PROXY"&#13;pear config-set https_proxy "$HTTPS_PROXY"</pre> | |
| pip<a name="pip"></a> | pip (python) | Alpine<br>Debian | python:alpine<br>python:slim | 16MB<br>42MB | | <pre lang="bash">export CURL_CA_BUNDLE="$SSL_CA_CERT"&#13;export PIP_CERT="SSL_CERT_FILE"&#13;export REQUESTS_CA_BUNDLE="SSL_CERT_FILE"</pre> |
| pipenv | Pipenv (python) | Alpine | fsfe/pipenv:alpine-3.13 | 36MB | | See [pip](#pip). |
| pkg | | FreeBSD | | | | |
| pkgadd<br>ports | pkgutils | Crux | crux:latest | 152MB | <pre lang="bash">echo "ROOT_DIR=/usr/ports/core" > /etc/ports/core.httpup&#13;echo "URL=http://crux.nu/ports/crux-3.8/core" >> /etc/ports/core.httpup&#13;mv /etc/ports/core.rsync /etc/ports/core.rsync.inactive&#13;&#13;echo "ROOT_DIR=/usr/ports/opt" > /etc/ports/opt.httpup&#13;echo "URL=http://crux.nu/ports/crux-3.8/opt" >> /etc/ports/opt.httpup&#13;mv /etc/ports/opt.rsync /etc/ports/opt.rsync.inactive&#13;&#13;echo "ROOT_DIR=/usr/ports/xorg" > /etc/ports/xorg.httpup&#13;echo "URL=http://crux.nu/ports/crux-3.8/xorg" >> /etc/ports/xorg.httpup&#13;mv /etc/ports/xorg.rsync /etc/ports/xorg.rsync.inactive</pre> | <pre lang="bash">install -Dm 644 cacert.pem /etc/ssl/cert.pem</pre> |
| pkgtool | Package Tool | Slackware | aclemons:slackware:latest | 66MB | | |
| pnpm | Performant NPM (node) | Alpine<br>Debian | node:current-alpine<br>node:slim | 54MB<br>76MB | See [npm](#npm). | See [npm](#npm). |
| pod | CocoaPods | Debian | renovate/cocoapods:latest | 149MB | | |
| poetry | Poetry (python) | Debian | sunpeek/poetry:py3.11-slim | 90MB | | See [pip](#pip). |
| port | MacPorts | MacOS | | | | |
| rpm<a name="rpm"></a> | RPM Package Manager | Red Hat | almalinux:latest<br>amazonlinux:latest<br>centos8:latest<br>quay.io/centos/centos:stream10<br>eurolinux/eurolinux-9:latest<br>fedora:latest<br>rockylinux:9<br>oraclelinux:9<br>redhat/ubi9:latest[^ubi] | 75MB<br>80MB<br>105MB<br>61MB<br>56MB<br>61MB<br>101MB<br>84MB | | |
| rye | Rye (python) | Debian | Superseded by [uv](#uv).<br>jfxs/rye:latest | 215MB | | See [pip](#pip). |
| sbt | simple build tool[^sbt] | Alpine | sbtscala/scala-sbt:eclipse-temurin-alpine-23.0.1_11_1.10.7_3.3.5 | 503MB | <pre lang="bash">export JAVA_OPTS="$JAVA_OPTS -Dhttp.proxyHost=$HTTP_PROXY_HOST -Dhttp.proxyPort=$HTTP_PROXY_PORT -Dhttps.proxyHost=$HTTPS_PROXY_HOST -Dhttps.proxyPort=$HTTPS_PROXY_PORT"</pre> | See [java](https://gist.github.com/hype8912/40116cb5e1051fc1a9b29ea54e6c2139#java). |
| slackpkg | Slack Package | Slackware | aclemons/slacware:latest | 66MB | | |
| slapt-get | | Slackware | gnujaos/slapt-get-current-min:latest | 71MB | | |
| snap | Snap | Arch Linux | manjarolinux/base:latest | 277MB | <pre lang="bash">snap set system proxy.http="$HTTP_PROXY"&#13;snap set system proxy.https="$HTTPS_PROXY"</pre> | |
| spack | | Debian<br>Red Hat | spack/ubuntu-focal:latest<br>spack/centos7:latest | 234MB<br>295MB | | |
| stack | | Debian | haskell:9.4.3-slim<br>haskell:slim | 319MB<br>576MB | | <pre lang="bash">export SYSTEM_CERTIFICATE_PATH="$SSL_CERT_DIR"</pre> |
| swupd | swupd | Clear Linux | clearlinux:latest | 69MB | | |
| urpmi | | Red Hat | mageia:latest | 97MB | | |
| uv<a name="uv"></a> | uv (python) | Alpine | ghcr.io/astral-sh/uv:alpine | 45MB | | See [pip](#pip). |
| vcpkg | Visual C Package | Alpine<br>Debian | acgetchell/vcpkg-image:alpine<br>acgetchell/vcpkg-image:latest | 136MB<br>507MB | | |
| volta | | Debian | domjtalbot/volta:latest | 92MB | | |
| xbps | X Binary Package System | Void Linux | voidlinux/voidlinux:latest | 43MB | | |
| yarn<a name="yarn"></a> | Yet Another Resource Negotiator (node)[^yarn] | Alpine | jitesoft/node-yarn:lts-slim | 60MB | See [npm](#npm).<pre lang="bash">yarn config set httpProxy "$HTTP_PROXY"&#13;yarn config set httpsProxy "$HTTPS_PROXY"</pre> | See [npm](#npm).<pre lang="bash">yarn config set httpsCaFilePath "$SSL_CERT_FILE"</pre> |
| yum | Yellowdog Update Modifier | Red Hat | almalinux:latest<br>centos8:latest<br>quay.io/centos/centos:stream10<br>eurolinux/eurolinux-9:latest<br>fedora:latest<br>rockylinux:9<br>oraclelinux:9<br>redhat/ubi9:latest[^ubi] | 75MB<br>80MB<br>105MB<br>61MB<br>56MB<br>61MB<br>101MB<br>84MB | <pre lang="bash">echo "proxy=$HTTP_PROXY" >> /etc/yum.conf</pre> | |
| zig | | Alpine | ziglang/static-base:llvm13-x86_64-1 | 177MB | | |
| zypper | Zypper | SUSE | opensuse/leap:latest<br>opensuse/tumbleweed:latest | 42MB<br>36MB | | |

# Further Research Package Managers

These are known package managers but require more research and testing before being moved to the above table.

| Package manager | Name | Image Base | Test Image[^test_image] | Test Image Size[^image_size] | Proxy Instructions | Certificate Instructions |
|:---:|:---:|:---:|---|:---:|---|---|
| bal | Ballerina[^ballerina] | Alpine | ballerina/ballerina:latest | 610MB | `$HOME/.ballerina/Settings.toml`<pre lang="toml">[proxy]&#13;host = "$HTTP_PROXY_HOST"&#13;port = "$HTTP_PROXY_PORT"</pre> | <pre lang="bash">export BALLERINA_CA_BUNDLE="$SSL_CERT_FILE"&#13;export BALLERINA_CA_CERT="$SSL_CA_CERT"</pre> |
| cfpm | ColdFusion Package Manager | Debian | adobecoldfusion/coldfusion:latest | 222MB | | |
| crew | ChromeBrew[^crew] | Debian | satmandu/crewbuild:latest | 2.7GB | | |
| cobolget | | | | | | |
| ipkg | | | | | | |
| | Apache Ivy | | | | <pre lang="bash">export ANT_OPTS="-Dhttp.proxyHost=$HTTP_PROXY_HOST -Dhttp.proxyPort=$HTTP_PROXY_PORT -Dhttps.proxyHost=$HTTPS_PROXY_HOST -Dhttps.proxyPort=$HTTPS_PROXY_PORT"</pre> | See [java](https://gist.github.com/hype8912/40116cb5e1051fc1a9b29ea54e6c2139#java). |
| lin | Lunar | Sorcerer | esselfe/lunar-linux:latest | 786MB | | |
| n | n (node) | | **NEED IMAGE** | | See [npm](#npm). | See [npm](#npm). |
| netpkg | | | | | | |
| openpkg | OpenPKG | Unix | | | | |
| opkg[^opkg] | OPKG | | | | | |
| petget | PETget | | | | | |
| pixi | pixi | Debian | ghcr.io/prefix-dev/pixi:latest | 118MB | | (Python) See [pip](#pip). |
| swift | Swift Package Manager | Debian | swift:latest | 921MB | | |
| <a name="vite"></a>vite | Vite (node) | | | | See [npm](#npm). | See [npm](#npm). |
| vlt | vōlt (node) | | | | See [npm](#npm). | See [npm](#npm). |

# Deprecated Package Managers

See the list [here](deprecated-package-manager-settings.md).

[^test_image]: Every attempt is made to find the recently updated images from known publishers but some images are very old or published by individuals and should be used at your own risk.
[^image_size]: `Test Image Size` are approximate and mainly given for managing bandwidth when testing in a pipeline. Image sizes could change at any time.
[^bower]: Bower is deprecated and suggested to move to [yarn](#yarn) or [vite](#vite).
[^brew]: The homebrew image can be made significantly smaller by updating the `Dockerfile` to `git clone --depth 1` instead of the whole `homebrew-core` repo.
[^cargo]: https://doc.rust-lang.org/cargo/reference/config.html#httpproxy
[^composer]: https://getcomposer.org/doc/faqs/how-to-use-composer-behind-a-proxy.md
[^ubi]: Red Hat UBI images require a subscription to use.
[^gradle]: Gradle requires a `gradle.properties` file before being able to set the proxy.
[^hex]: https://hexdocs.pm/hex/Mix.Tasks.Hex.Config.html#module-config-keys
[^pear]: Requires the installation of [Crypt_GPG-1.4.2](https://pear.php.net/package/Crypt_GPG/download) before you can set the 'https_proxy'. See [link](https://www.reddit.com/r/PHP/comments/4phpz2/errors_installing_crypt_gpg/) for more information.
[^sbt]: https://www.scala-sbt.org/1.x/docs/Command-Line-Reference.html#sbt+JVM+options+and+system+properties
[^yarn]: `caFilePath` was changed to `httpsCaFilePath` in Yarn [Version 4.0](https://yarnpkg.com/advanced/changelog#major-changes).
[^ballerina]: https://ballerina.io/learn/configure-a-network-proxy/
[^opkg]: https://git.yoctoproject.org/opkg/about/#opkg-package-manager
[^crew]: https://github.com/chromebrew/chromebrew
