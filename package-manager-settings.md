# Package Managers

Set the applicable [Proxy](proxy-environment-variables.md), [Certificate](certificate-environment-variables.md), and [OS/Distro](image-os-distro-settings.md) variables along with [application](application-proxy-settings.md) configurations.

## Current Package Managers

If no information is provided in the `Proxy Instructions` or `Certificate Instructions` means they use the typical OS or Distro environment values and will work by setting those value(s).

| Package manager | Name | Image Base | Test Image[^test_image] | Test Image Size[^test_image] | Proxy Instructions | Certificate Instructions |
| :---: | :---: | :---: | --- | :---: | --- | --- |
| alr | Alire | Debian | esolang/ada:latest | 286MB | | |
| apk | Alpine Package | Alpine | alpine:latest | 3.5MB | | |
| apt<a name="apt"></a> | Advanced Package Tool | Debian | debian:stable-slim<br>ubuntu:latest | 27MB<br>28MB | <pre language="bash">echo 'Acquire::http::Proxy "$HTTP_PROXY";' > /etc/apt/apt.conf.d/00proxy&#13;echo 'Acquire::https::Proxy "$HTTPS_PROXY";' >> /etc/apt/apt.conf.d/00proxy&#13;echo 'Acquire::ftp::Proxy "$FTP_PROXY";' >> /etc/apt/apt.conf.d/00proxy</pre> | |
| apt-get | | Debian | debian:stable-slim<br>ubuntu:latest | 27MB<br>28MB | See [apt](#apt). | |
| apx | | Debian | ghcr.io/vanilla-os/desktop:v1.1.3 | 3.2GB | | |
| bower | Bower (node)[^bower] | Debian | danlynn/ember-cli:latest | 717MB | <pre><code class="language-bash">export bower_proxy="$HTTP_PROXY"&#13;export bower_https_proxy="$HTTPS_PROXY"</code></pre>See also [npm](#npm). | <code class="language-bash">export bower_ca="$SSL_CERT_FILE"</code><br>See also [npm](#npm). |
| brew | Homebrew | Debian | homebrew/brew:latest | 1.2GB[^brew] | | |
| bun | Bun (node) | Alpine<br>Debian | oven/bun:alpine<br>oven/bun:latest | 44MB<br>88MB | See [npm](#npm). | See [npm](#npm). |
| bundle | Bundler (ruby) | Alpine | alpine/bundle:latest | 339MB | | |
| cabal | Cabal 2+ | Debian | haskell:9.4.3-slim<br>haskell:slim | 319MB<br>576MB | | |
| cards | | Linux From Scratch | sundev79/nutyx-images:nutyx | 130MB | | |
| cargo<a name="cargo"></a> | Cargo (rust)[^cargo] | Debian | rust:slim | 280MB | | <code class="language-bash">export CARGO_HTTP_CAINFO="$SSL_CERT_FILE"</code>[^cargo_cert] |
| cast | | Sorcerer | sourcemage:latest | 251MB | | |
| choco | Chocolatey | Debian | chocolatey/choco:latest | 249MB | | |
| ck | Collective Knowledge | Debian | ctuning/ck-web-server:latest | 135MB | | |
| composer<a name="composer"></a> | Composer (PHP) | Alpine | composer:latest | 71MB | <code class="language-bash">export CGI_HTTP_PROXY="$HTTP_PROXY"</code>[^composer_proxy] | <code class="language-bash">export COMPOSER_CAFILE="$SSL_CERT_FILE"</code>[^composer_cert] |
| conan<a name="conan"></a> | Conan | Debian | conanio/gcc9:2.9.1 | 306MB | | <code class="language-bash">export CONAN_CACERT_PATH="$SSL_CERT_FILE"</code>[^conan_cert] |
| conda<a name="conda"></a> | Conda | Debian | continuumio/miniconda3:latest | 198MB | <pre><code class="language-bash">conda config --set proxy_servers.http "$HTTP_PROXY"&#13;conda config --set proxy_servers.https "$HTTPS_PROXY"</code></pre> | <code class="language-bash">conda config --set ssl_verify "$SSL_CERT_FILE"</code> |
| corepack | Corepack (node) | Alpine<br>Debian | node:current-alpine<br>node:slim | 54MB<br>76MB | See [npm](#npm). | See [npm](#npm). |
| cpan | CPAN | Debian | perl:stable-slim | 56MB | | |
| cran | CRAN | Debian | r-base:latest | 343MB | | |
| ctan | CTAN | Debian | esolang/tex:latest | 245MB | | |
| dart | Dart Pub | Debian | dart:stable | 291MB | | |
| deno<a name="deno"></a> | Deno (node) | Alpine<br>Debian | denoland/deno:alpine<br>denoland/deno:latest | 50MB<br>71MB | See [npm](#npm). | <pre><code class="language-bash">export DENO_CERT="$SSL_CERT_FILE"&#13;export DENO_TLS_CA_STORE=system</code>[^deno_cert]</pre>See also [npm](#npm). |
| dnf<a name="dnf"></a> | DNF | Red Hat | See [Red Hat Image Distros](other/redhat-image-distros.md) | | <code class="language-bash">echo "proxy=$HTTP_PROXY" >> "/etc/dnf/dnf.conf"</code> | |
| dotnet nuget | NuGet | Debian | mcr.microsoft.com/dotnet/sdk:8.0 | 836MB | | |
| dpkg | Debian Package | Debian | debian:stable-slim<br>ubuntu:latest | 27MB<br>28MB | See [apt](#apt). | |
| dub | DUB | Debian | dlanguage/ldc:latest | 304MB | | |
| emerge | Portage | Gentoo | gentoo/stage3:musl<br>gentoo/python:latest | 290MB<br>611MB | <code class="language-bash">export RSYNC_PROXY="$HTTP_PROXY"</code> | |
| eopkg | | Solus (Evolve OS) | silkeh/solus:slim | 268MB | | |
| fink | Fink | MacOS | | | | |
| flatpak | Flatpak | Debian<br>Red Hat | flatpak/flatpak-builder:base<br>freedesktopsdk/flatpak:latest | 295MB<br>611MB | | |
| fpm | Fortran Package Manager | Alpine | esolang/fortran:latest | 141MB | | |
| gem | RubyGem | Debian | ruby:slim | 80MB | | |
| go | Go Modules | Debian | golang:bookworm | 289MB | | |
| gradle | Gradle[^gradle] | Debian | gradle:latest | 377MB | <pre><code class="language-bash">gradlew -Dhttp.proxyHost=$HTTP_PROXY_HOST \ &#13; -Dhttp.proxyPort=$HTTP_PROXY_PORT \ &#13; -Dhttps.proxyHost=$HTTPS_PROXY_HOST \ &#13; -Dhttps.proxyPort=$HTTPS_PROXY_PORT \ &#13; -Dhttp.nonProxyHosts=$NO_PROXY \ &#13; -Dhttps.nonProxyHosts=$NO_PROXY</code></pre> | |
| guix | GNU Guix | NixOS | metacall/guix:latest | 992MB | | |
| hatch | Hatchling (python) | | | | | See [pip](#pip). |
| hex<a name="hex"></a> | | Debian | erlang:slim | 119MB | | <code class="language-bash">export HEX_CACERTS_PATH="$SSL_CERT_FILE"</code>[^hex] |
| hpm | HarmonyOS Package Manager[^hpm] | | | | <pre><code class="language-bash">hpm config set http_proxy $HTTP_PROXY&#13;hpm config set https_proxy $HTTPS_PROXY</code></pre> | |
| lein<a name="lein"></a> | Leiningen | Debian | clojure:latest | 287MB | | See [java](application-proxy-settings.md#java). |
| luarocks | LuaRocks | Alpine<br>Debian | nickblah/lua:5-luarocks-alpine3<br>nickblah/lua:latest | 7MB<br>47MB | | |
| mamba | Mamba | Debian | condaforge/miniforge3:latest | 141MB | | <pre><code class="language-bash">export CURL_CA_BUNDLE="$SSL_CA_CERT"&#13;export REQUESTS_CA_BUNDLE="$SSL_CERT_FILE"</code></pre>See also [conda](#conda). |
| microdnf | MicroDNF | Red Hat | See [Red Hat Image Distros](other/redhat-image-distros.md) | | See [dnf](#dnf) | |
| micromamba | Micromamba | Debian | mambaorg/micromamba:latest | 33MB | | <pre><code class="language-bash">export CURL_CA_BUNDLE="$SSL_CA_CERT"&#13;export REQUESTS_CA_BUNDLE="$SSL_CERT_FILE"&#13;micromamba config set ssl_verify "$SSL_CERT_FILE"</code></pre> |
| mvn<a name="mvn"></a> | Maven | Debian | maven:latest | 231MB | <pre><code class="language-bash">mvn -DproxySet=true -D proxyHost=$HTTP_PROXY_HOST \ &#13; -DproxyPort=$HTTP_PROXY_PORT \ &#13; -DproxyProtocol=http \ &#13; -DproxyId=http \ &#13; -DproxyNonProxyHosts=$NO_PROXY&#13;mvn -D proxyHost=$HTTPS_PROXY_HOST \ &#13; -DproxyPort=$HTTPS_PROXY_PORT \ &#13; -DproxyProtocol=https \ &#13; -DproxyId=https \ &#13; -DproxyNonProxyHosts=$NO_PROXY</code></pre> | See also [java](application-proxy-settings.md#java).<pre><code class="language-bash" style="white-space: pre-wrap;">export MAVEN_OPTS="-Djavax.net.ssl.trustStore=$SSL_KEYSTORE_FILE -Djavax.net.ssl.trustStorePassword={Password}"</code>[^maven_cert]</pre> |
| nix<a name="nix"></a> | Nix Package Manager | NixOS | nixos/nix:latest | 213MB | | <code class="language-bash">export NIX_SSL_CERT_FILE="$SSL_CERT_FILE"</code>[^nix_cert] |
| npm<a name="npm"></a> | Node Package Manager | Alpine<br>Debian | node:current-alpine<br>node:slim | 54MB<br>76MB | <pre><code class="language-bash">npm config set proxy "$HTTP_PROXY"&#13;npm config set https-proxy "$HTTPS_PROXY"&#13;npm config set noproxy "$NO_PROXY"</code></pre>Electron:<br><code class="language-bash">export ELECTRON_GET_USE_PROXY=true</code> | <pre><code class="language-bash">export NODE_EXTRA_CA_CERTS="$SSL_CERT_FILE"&#13;export NODE_TLS_REJECT_UNAUTHORIZED=1</code>[^node_certs]</pre> |
| nuget | NuGet | Windows | mcr.microsoft.com/dotnet/framework/sdk:4.8.1 | 2.2GB | <pre><code class="language-bash">nuget config -set http_proxy="$HTTP_PROXY"&#13;nuget config -set https_proxy="$HTTPS_PROXY"</code></pre> | |
| opam | opam | Alpine<br>Debian | ocaml/opam:alpine<br>ocaml/opam:latest | 477MB<br>604MB | | |
| pacman<a name="pacman"></a> | Pacman | Arch Linux | archlinux:latest | 150MB | <code class="language-bash">export RSYNC_PROXY="$HTTP_PROXY"</code> | |
| paket | | Debian | nojaf/fable:latest | 284MB | | |
| paru | Paru | Arch Linux | ticpu/archlinux-paru:latest | 314MB | See [pacman](#pacman). | |
| pdm | pdm (python) | Debian | frostming/pdm:latest | 47MB | | See [pip](#pip). |
| pear | PEAR (PHP) | Alpine<br>Debian | php:alpine<br>php:latest | 40MB<br>178MB | <pre><code class="language-bash">pear config-set http_proxy "$HTTP_PROXY"&#13;pear config-set https_proxy "$HTTPS_PROXY"</code>[^pear]</pre> | |
| pip<a name="pip"></a> | pip (python) | Alpine<br>Debian | python:alpine<br>python:slim | 16MB<br>42MB | | <pre><code class="language-bash">export CURL_CA_BUNDLE="$SSL_CA_CERT"&#13;export PIP_CERT="$SSL_CERT_FILE"&#13;export REQUESTS_CA_BUNDLE="$SSL_CERT_FILE"</code>[^pip_cert]</pre> |
| pipenv | Pipenv (python) | Alpine | fsfe/pipenv:alpine-3.13 | 36MB | | See [pip](#pip). |
| pixi | pixi | Debian | ghcr.io/prefix-dev/pixi:latest | 133MB | | See [pip](#pip). |
| pkg | | FreeBSD | | | | |
| pkgadd<br>ports | pkgutils | Crux | crux:latest | 152MB | <pre><code class="language-bash">echo "ROOT_DIR=/usr/ports/core" > /etc/ports/core.httpup&#13;echo "URL=http://crux.nu/ports/crux-3.8/core" >> "/etc/ports/core.httpup"&#13;mv "/etc/ports/core.rsync" "/etc/ports/core.rsync.inactive"&#13;&#13;echo "ROOT_DIR=/usr/ports/opt" > "/etc/ports/opt.httpup"&#13;echo "URL=http://crux.nu/ports/crux-3.8/opt" >> "/etc/ports/opt.httpup"&#13;mv "/etc/ports/opt.rsync" "/etc/ports/opt.rsync.inactive"&#13;&#13;echo "ROOT_DIR=/usr/ports/xorg" > "/etc/ports/xorg.httpup"&#13;echo "URL=http://crux.nu/ports/crux-3.8/xorg" >> "/etc/ports/xorg.httpup"&#13;mv "/etc/ports/xorg.rsync" "/etc/ports/xorg.rsync.inactive"</code></pre> | <code class="language-bash">install -Dm 644 cacert.pem "/etc/ssl/cert.pem"</code> |
| pkg_add<br>pkgin | pkgsrc | NetBSD | | | | |
| pkgtool | Package Tool | Slackware | aclemons:slackware:latest | 66MB | | |
| pnpm | Performant NPM (node) | Alpine<br>Debian | node:current-alpine<br>node:slim | 54MB<br>76MB | See [npm](#npm). | See [npm](#npm). |
| pod | CocoaPods | Debian | renovate/cocoapods:latest | 149MB | | |
| poetry | Poetry (python) | Debian | sunpeek/poetry:py3.11-slim | 90MB | | See [pip](#pip). |
| port | MacPorts | MacOS | | | | |
| rpm<a name="rpm"></a> | RPM Package Manager | Red Hat | See [Red Hat Image Distros](other/redhat-image-distros.md) | | | |
| sbt | simple build tool[^sbt] | Alpine | sbtscala/scala-sbt:eclipse-temurin-alpine-23.0.1_11_1.10.7_3.3.5 | 503MB | <pre><code class="language-bash" style="white-space: pre-wrap;">export JAVA_OPTS="$JAVA_OPTS -Dhttp.proxyHost=$HTTP_PROXY_HOST -Dhttp.proxyPort=$HTTP_PROXY_PORT -Dhttps.proxyHost=$HTTPS_PROXY_HOST -Dhttps.proxyPort=$HTTPS_PROXY_PORT"</code></pre> | See [java](application-proxy-settings.md#java). |
| slackpkg | Slack Package | Slackware | aclemons/slackware:latest | 66MB | | |
| slapt-get | | Slackware | gnujaos/slapt-get-current-min:latest | 71MB | | |
| snap | Snap | Arch Linux | manjarolinux/base:latest | 277MB | <pre><code class="language-bash">snap set system proxy.http="$HTTP_PROXY"&#13;snap set system proxy.https="$HTTPS_PROXY"</code></pre> | |
| spack | | Debian<br>Red Hat | spack/ubuntu-focal:latest<br>spack/centos7:latest | 234MB<br>295MB | | |
| stack<a name="stack"></a> | | Debian | haskell:9.4.3-slim<br>haskell:slim | 319MB<br>576MB | | <code class="language-bash">export SYSTEM_CERTIFICATE_PATH="$SSL_CERT_DIR"</code>[^haskell_stack] |
| swupd | swupd | Clear Linux | clearlinux:latest | 69MB | | |
| urpmi | | Red Hat | mageia:latest | 97MB | | |
| uv<a name="uv"></a> | uv (python) | Alpine | ghcr.io/astral-sh/uv:python3.13-alpine | 85MB | | <pre><code class="language-bash">export UV_NATIVE_TLS=true</code></pre>See also [pip](#pip). |
| vcpkg | Visual C Package | Alpine<br>Debian | acgetchell/vcpkg-image:alpine<br>acgetchell/vcpkg-image:latest | 136MB<br>507MB | | |
| volta | | Debian | domjtalbot/volta:latest | 92MB | | |
| xbps | X Binary Package System | Void Linux | ghcr.io/void-linux/void-musl-full:latest | 81MB | | |
| yarn<a name="yarn"></a> | Yet Another Resource Negotiator (node)[^yarn] | Alpine | jitesoft/node-yarn:lts-slim | 60MB | <pre><code class="language-bash">yarn config set httpProxy "$HTTP_PROXY"&#13;yarn config set httpsProxy "$HTTPS_PROXY"</code></pre>See also [npm](#npm). | <code class="language-bash">yarn config set httpsCaFilePath "$SSL_CERT_FILE"</code><br>See also [npm](#npm). |
| yum | Yellowdog Update Modifier | Red Hat | See [Red Hat Image Distros](other/redhat-image-distros.md) | | <code class="language-bash">echo "proxy=$HTTP_PROXY" >> /etc/yum.conf</code> | |
| zig | | Alpine | ziglang/static-base:llvm13-x86_64-1 | 177MB | | |
| zypper | Zypper | SUSE | opensuse/archive:13.2<br>opensuse/leap:latest<br>opensuse/tumbleweed:latest | 37MB<br>42MB<br>36MB | | |

## Further Research Package Managers

These are known package managers but require more research and testing before being moved to the above table.

| Package manager | Name | Image Base | Test Image[^test_image] | Test Image Size[^test_size] | Proxy Instructions | Certificate Instructions |
| :---: |:---:| :---: | --- :---:| --- --- |
| bal | Ballerina[^ballerina] | Alpine | ballerina/ballerina:1.2.57 | 357MB | `$HOME/.ballerina/Settings.toml`<pre><code class="language-toml">[proxy]&#13;host = "$HTTP_PROXY_HOST"&#13;port = "$HTTP_PROXY_PORT"</code></pre> | <pre><code class="language-bash">export BALLERINA_CA_BUNDLE="$SSL_CERT_FILE"&#13;export BALLERINA_CA_CERT="$SSL_CA_CERT"</code></pre> |
| cfpm | ColdFusion Package Manager | Debian | adobecoldfusion/coldfusion:latest | 222MB | | |
| crew | ChromeBrew[^crew] | Debian | satmandu/crewbuild:latest | 2.7GB | | |
| | Apache Ivy | | | | <code class="language-bash" style="white-space:pre-wrap;">export ANT_OPTS="-Dhttp.proxyHost=$HTTP_PROXY_HOST -Dhttp.proxyPort=$HTTP_PROXY_PORT -Dhttps.proxyHost=$HTTPS_PROXY_HOST -Dhttps.proxyPort=$HTTPS_PROXY_PORT"</code> | See [java](application-proxy-settings.md#java). |
| lin | Lunar | Sorcerer | esselfe/lunar-linux:latest | 786MB | | |
| n | n (node) | | **NEED IMAGE** | | See [npm](#npm). | See [npm](#npm). |
| openupm<a name="openupm"></a> | OpenUPM | | | | <code class="language-bash">export UNITY_NOPROXY="$NO_PROXY"</code>[^unity_proxy]<br>See also [npm](#npm). | |
| pkgm[^pkgm] | | Debian | pkgxdev/pkgx:latest | 66MB | | |
| qpkg | QPKG | Debian | owncloudci/qnap-qpkg-builder:latest | 197MB | | |
| swift | Swift Package Manager | Debian | swift:latest | 921MB | | |
| twine<a name="twine"></a> | Twine (python) | | | |  | <code class="language-bash">export TWINE_CERT="$SSL_CERT_FILE"</code>[^twine]<br>See also [pip](#pip) |
| vite<a name="vite"></a> | Vite (node) | | | | See [npm](#npm). | See [npm](#npm). |
| vlt | vōlt (node) | | | | See [npm](#npm). | See [npm](#npm). |
| winget<a name="winget"></a> | Windows Package Manager[^winget] | | | | | |

## Deprecated Package Managers

See the list of [Deprecated Package Managers](deprecated-package-manager-settings.md).

## See also

+ [Package URL Type definitions](https://github.com/package-url/purl-spec/blob/346589846130317464b677bc4eab30bf5040183a/PURL-TYPES.rst)

[^test_image]: [Test Image Disclaimer](README.md#test-image)
[^ballerina]: https://ballerina.io/learn/configure-a-network-proxy/
[^bower]: Bower is deprecated and suggested to move to [yarn](#yarn) or [vite](#vite).
[^brew]: The homebrew image can be made significantly smaller by updating the `Dockerfile` to `git clone --depth 1` instead of the whole `homebrew-core` repo.
[^cargo]: https://doc.rust-lang.org/cargo/reference/config.html#httpproxy
[^cargo_cert]: https://doc.rust-lang.org/cargo/reference/config.html#httpcainfo
[^choco_proxy]: https://docs.chocolatey.org/en-us/guides/usage/proxy-settings-for-chocolatey/
[^composer_proxy]: PHP Versions 5.6+ are more likely to be able to automatically detect the system's default CA file. https://getcomposer.org/doc/faqs/how-to-use-composer-behind-a-proxy.md
[^composer_cert]: https://getcomposer.org/doc/03-cli.md#composer-cafile
[^conan_cert]: https://docs.conan.io/1/reference/env_vars.html#conan-cacert-path
[^crew]: https://github.com/chromebrew/chromebrew
[^deno_cert]: https://docs.deno.com/runtime/reference/env_variables/#std%2Fcli
[^gradle]: Gradle requires a `gradle.properties` file before being able to set the proxy.
[^haskell_stack]: https://github.com/commercialhaskell/stack/blob/123622ab2a2b90d80fc617791b57e486aef725a1/doc/faq.md?plain=1#L218
[^hex]: https://hexdocs.pm/hex/Mix.Tasks.Hex.Config.html#module-config-keys
[^hpm]: https://gitee.com/openharmony/docs/blob/master/en/device-dev/hpm-part/hpm-part-development.md
[^maven_cert]: https://maven.apache.org/guides/mini/guide-repository-ssl.html
[^nix_cert]: https://wiki.nixos.org/wiki/Enterprise
[^node_certs]: https://nodejs.org/docs/latest/api/cli.html#node_extra_ca_certsfile
[^pear]: Requires the installation of [Crypt_GPG-1.4.2](https://pear.php.net/package/Crypt_GPG/download) before you can set the 'https_proxy'. See [info link](https://www.reddit.com/r/PHP/comments/4phpz2/errors_installing_crypt_gpg/) for more information.
[^pip_cert]: https://pip.pypa.io/en/latest/topics/https-certificates/
[^pkgm]: https://github.com/pkgxdev/pkgm
[^sbt]: https://www.scala-sbt.org/1.x/docs/Command-Line-Reference.html#sbt+JVM+options+and+system+properties
[^twine]: https://twine.readthedocs.io/en/stable/#environment-variables
[^unity_proxy]: https://discussions.unity.com/t/difficulties-in-proxy-environment/774349
[^winget]: https://learn.microsoft.com/en-us/windows/package-manager/
[^yarn]: `caFilePath` was changed to `httpsCaFilePath` in Yarn [Version 4.0](https://yarnpkg.com/advanced/changelog#major-changes).
