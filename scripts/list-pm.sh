#!/bin/sh

green='\033[0;32m'
reset='\033[0m'

# Package manager lists (broken into multiple variables for readability)
pkmA="agner ahkpm airship alr apk apm apt apt-get apx aris au3pm aura"
pkmB="bal bingo boss bower bpkg brew bun bundle"
pkmC="cabal cards cargo carthage cast cfpm choco ck clib cobolget composer compote conan conche conda corepack corral cotton cpan cran crew cspkg ctan curd"
pkmD="dart deno dnf dotnet dpkg dub"
pkmE="edm elm-install emerge eopkg"
pkmF="ferry fext fink flatpak flox fpm fppkg fundle"
pkmG="gel gem glasskube gradle guix"
pkmH="harbourmaster hatch haxelib helm hex hpm huak"
pkmI="iron"
pkmJ="jetpack jlpkg"
pkmK="kpm"
pkmL="lein ligo lin lix luarocks lx"
pkmM="magic mamba mason maximus microdnf micromamba mvn"
pkmN="n ncl necro netpkg nimble ninite nitrile niv nix novus npm nuget nyssa"
pkmO="opam openpkg openupm opkg oro"
pkmP="pacaptr pacman paket parn pdm pear petget pip pipenv pipflow pipx pixi pkg pkgm pkgtool plz pnpm pod poet poetry port ppm pym pypm"
pkmQ="qp qpkg"
pkmR="raco rpkg rpm rut rye rzget"
pkmS="sbt scarb scoop slackpkg slapt-get snap spack spago stack swift swupd"
pkmT="teaport trex twine"
pkmU="unearth upm urpmi uv"
pkmV="vanat vcpkg vite vpkg vlt volta"
pkmW="winds winget wpkg"
pkmX="xbps"
pkmY="yarn yum"
pkmZ="zap zig zkg zpm zypper"

# Combine all package managers
package_managers="$pkmA $pkmB $pkmC $pkmD $pkmE $pkmF $pkmG $pkmH $pkmI $pkmJ $pkmK $pkmL $pkmM $pkmN $pkmO $pkmP $pkmQ $pkmR $pkmS $pkmT $pkmU $pkmV $pkmW $pkmX $pkmY $pkmZ"
printf "Package managers- '%s'\n" "$package_managers"
printf "Checking for installed package managers...\n"

# Check if printf supports -e flag, fallback to echo if not
if printf '\033[0m' >/dev/null 2>&1; then
    use_printf=1
else
    use_printf=0
fi

# Process each package manager
for manager in $package_managers; do
	if command -v "$manager" >/dev/null 2>&1; then
		if [ "$use_printf" = 1 ]; then
            printf "${green}%s is installed.${reset}\n" "$manager"
        else
            echo "${manager} is installed."
        fi
	else
		printf "%s not found.\n" "$manager"
	fi
done
