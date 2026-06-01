#!/bin/bash
# Tested on:
# archlinux:latest, artixlinux/artixlinux:latest, athenaos/base:latest

# Define external file sources
certs_url="http://mycompany.com/Company_CA.pem"
certs_tar_url="http://mycompany.com/Company_certs.tar"

# Define basic variables
LOCAL_CERTS_CRT_NAME="Company_CA.crt"
LOCAL_CERTS_PEM_NAME="Company_CA.pem"
LOCAL_CERTS_TAR_NAME="Company_certs.tar"

# Define OS variables
ARCH_REPO_LOCAL_PATH="/etc/pacman.d/mirrorlist"
ARCH_INSTALL_PACKAGES="curl step-cli"
ARCH_SSL_CERT_DIR="/etc/ca-certificates/trust-source/anchors"

# shellcheck source=../common-functions.sh
. ../common-functions.sh

# Begin configuration script
if [ "$(uname)" != "Linux" ]; then
    echo "Non-Linux OS is not currently supported. '$(uname)'"
    exit 1
fi

if command -v pacman >/dev/null 2>&1; then
    echo "Arch Linux flavor found."
    # shellcheck disable=SC2016
    {
        echo 'Server = https://mirrors.mit.edu/archlinux/$repo/os/$arch'
        echo 'Server = https://mirrors.ocf.berkeley.edu/archlinux/$repo/os/$arch'
        echo 'Server = https://plug-mirror.rcac.purdue.edu/archlinux/$repo/os/$arch'
        echo 'Server = https://mirrors.rutgers.edu/archlinux/$repo/os/$arch'
        echo 'Server = https://mirror.siena.edu/archlinux/archlinux/$repo/os/$arch'
        echo 'Server = https://mirrors.cat.pdx.edu/archlinux/archlinux/$repo/os/$arch'
    } >> "$ARCH_REPO_LOCAL_PATH"
    sed -i -e "s/https:/http:/g" "$ARCH_REPO_LOCAL_PATH"
    pacman -Syu --noconfirm

    echo "Determining what packages are installed."
    not_installed_packages=""
    for package in $ARCH_INSTALL_PACKAGES; do
        if ! pacman -Qi "$package" >/dev/null 2>&1; then
            not_installed_packages="$not_installed_packages $package"
        fi
    done

    if [[ "$not_installed_packages" ]]; then
        echo "Installing required packages."
        # shellcheck disable=SC2086
        pacman -S $not_installed_packages --noconfirm || echo "Failed to install $ARCH_INSTALL_PACKAGES - $not_installed_packages packages."
    fi

    sed -i -e 's/http:/https:/g' "$ARCH_REPO_LOCAL_PATH"
    configure_ssl_variables_and_certs "$ARCH_SSL_CERT_DIR"
    update_certificates

    configure_individual_certs_with_step
    update_certificates

    echo "Removing installed packages. $not_installed_packages"
    if [[ "$not_installed_packages" ]]; then
        # shellcheck disable=SC2086
        pacman -Rs $not_installed_packages --noconfirm
    fi

    pacman -Sc --noconfirm
    echo "Pacman certificate configuration complete."
else
    echo "Linux Arch flavor not found."
fi
