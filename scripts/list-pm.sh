#!/bin/bash

green='\033[0;32m'
reset='\033[0m'

# Package manager lists (broken into multiple variables for readability)
pkmA="agner ahkpm airship alr apk apkg apm apt apt-get aptitude apx aris au3pm aura"
pkmB="bal biicode bingo boss bower bpkg brew buckaroo bun bundle"
pkmC="cabal cards cargo carthage carton cask cast cfpm choco ck clib cljr cnpm cobolget composer compote conan conche conda corepack corral cotton cpan cpanm cran crew cspkg ctan curd"
pkmD="dart dbin deno dep dnf dotnet dpkg dub"
pkmE="easy_install edm elm-install emerge eopkg equo eudrop"
pkmF="ferry fext fink flatpak flix flox fpm fppkg fundle"
pkmG="gel gem gerap glasskube glide godep gradle guix"
pkmH="harbourmaster hatch haxelib helm hex hpm huak"
pkmI="ipkg iron itsy ivy"
pkmJ="jetpack jlpkg jpm"
pkmK="kiss kpm"
pkmL="lein ligo lin lix lmod luarocks lx"
pkmM="magic mamba mason maximus meteor microdnf micromamba miniforge minpac mpm mvn"
pkmN="n ncl necro netpkg nimble ninite nitrile niv nix novus npm nuget nyssa"
pkmO="opam openpkg openupm opkg oro"
pkmP="pacaptr pacman paket parn paru pdm pear petget pip pipenv pipflow pipx pixi pkg pkgm pkgtool plz pnpm pod poet poetry port portage ppm pyenv pym pypm"
pkmQ="qp qpkg"
pkmR="raco rebar rectx rpkg rpm rpm-ostree rustup rut rye rzget"
pkmS="sbt scarb scoop shards slackpkg slapt-get snap soldeer spack spago stack swift swupd"
pkmT="tatin tdnf teaport tlmgr trex twine"
pkmU="unearth upm urpmi uv"
pkmV="valapkg vanat vcpkg vgo vite vpkg vlt volta"
pkmW="wapm winds winget wpkg"
pkmX="xbps"
pkmY="yarn yast yum"
pkmZ="zap zig zkg zpm zypper"

# Combine all package managers
package_managers="$pkmA $pkmB $pkmC $pkmD $pkmE $pkmF $pkmG $pkmH $pkmI $pkmJ $pkmK $pkmL $pkmM $pkmN $pkmO $pkmP $pkmQ $pkmR $pkmS $pkmT $pkmU $pkmV $pkmW $pkmX $pkmY $pkmZ"
printf "Package managers- '%s'\n" "${package_managers}"
printf "Checking for installed package managers...\n"

# Check if printf supports -e flag, fallback to echo if not
if printf '\033[0m' >/dev/null 2>&1; then
    use_printf=1
else
    use_printf=0
fi

# Process each package manager
for manager in ${package_managers}; do
	if command -v "${manager}" >/dev/null 2>&1; then
		if [[ "${use_printf}" = 1 ]]; then
            printf "${green}%s is installed.${reset}\n" "${manager}"
        else
            echo -e "${green}${manager} is installed.${reset}"
        fi
	else
        if [[ "${use_printf}" = 1 ]]; then
            printf "%s not found.\n" "${manager}"
        else
            echo "${manager} not found."
        fi
	fi
done
