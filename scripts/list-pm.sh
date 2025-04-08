#!/bin/sh

green='\e[0;32m'
reset='\e[0m'

pkmA="agner ahkpm airship alr apk apm apt apt-get apx aris au3pm"
pkmB="bal bingo boss bower brew bun bundle"
pkmC="cabal cards cargo carthage cast cfpm choco ck cobolget composer compote conan conche conda corepack corral cotton cpan cran crew cspkg ctan curd"
pkmD="dart deno dnf dotnet dpkg dub"
pkmE="edm elm-install emerge eopkg"
pkmF="ferry fext fink flatpak flox fpm fppkg fundle"
pkmG="gel gem gradle guix"
pkmH="harbourmaster hatch haxelib hex hpm huak"
pkmI="iron"
pkmJ="jetpack jlpkg"
pkmK="kpm"
pkmL="lein ligo lin lix luarocks lx"
pkmM="magic mamba mason maximus microdnf micromamba mvn"
pkmN="n ncl necro netpkg nimble ninite nitrile nix novus npm nuget nyssa"
pkmO="opam openpkg openupm opkg oro"
pkmP="pacman paket parn pdm pear petget pip pipenv pipflow pipx pixi pkg pkgm pkgtool plz pnpm pod poet poetry port ppm pym pypm"
pkmQ="qp qpkg"
pkmR="raco rpkg rpm rut rye rzget"
pkmS="sbt scarb scoop slackpkg slapt-get snap spack stack swift swupd"
pkmT="teaport trex twine"
pkmU="unearth upm urpmi uv"
pkmV="vanat vcpkg vite vpkg vlt volta"
pkmW="winds winget wpkg"
pkmX="xbps"
pkmY="yarn yum"
pkmZ="zap zig zkg zpm zypper"

package_managers="$pkmA $pkmB $pkmC $pkmD $pkmE $pkmF $pkmG $pkmH $pkmI $pkmJ $pkmK $pkmL $pkmM $pkmN $pkmO $pkmP $pkmQ $pkmR $pkmS $pkmT $pkmU $pkmV $pkmW $pkmX $pkmY $pkmZ"
echo "Package managers- '$package_managers'"
echo "Checking for installed package managers..."

for manager in $package_managers; do
	if command -v "$manager" >/dev/null 2>&1; then
		echo -e "${green}$manager is installed.${reset}"
	else
		echo "$manager not found."
	fi
done
