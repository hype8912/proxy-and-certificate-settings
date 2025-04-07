#!/bin/sh

green='\e[0;32m'
reset='\e[0m'

package_managers="ahkpm alr apk apt apt-get apx au3pm bal bower brew bun bundle cabal cards cargo cast cfpm choco ck composer conan conda corepack cpan cran crew ctan dart deno dnf dotnet dpkg dub emerge eopkg fink flatpak fpm gem gradle guix hatch hex hpm lein lin luarocks mamba microdnf micromamba mvn n nix npm nuget nyssa opam openpkg openupm opkg pacman paket pdm pear pip pipenv pipflow pipx pixi pkg pkgm pkgtool pnpm pod poetry port pym qpkg rpm rye sbt slackpkg slapt-get snap spack stack swift swupd teaport twine urpmi uv vcpkg vite vlt volta xbps yarn yum zig zkg zypper"
echo "Package managers- '$package_managers'"
echo "Checking for installed package managers..."

for manager in $package_managers; do
	if command -v "$manager" >/dev/null 2>&1; then
		echo "${green}$manager is installed.${reset}"
	else
		echo "$manager not found."
	fi
done
