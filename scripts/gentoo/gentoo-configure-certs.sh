#!/bin/bash
# Tested on:
# gentoo/stage3:musl

# Define external file sources
certs_url="http://mycompany.com/Company_CA.pem"
certs_tar_url="http://mycompany.com/Company_certs.tar"

# Define basic variables
LOCAL_CERTS_CRT_NAME="Company_CA.crt"
LOCAL_CERTS_PEM_NAME="Company_CA.pem"
LOCAL_CERTS_TAR_NAME="Company_certs.tar"

# Define OS variables
GENTOO_REPO_LOCAL_PATH="/etc/portage/repos.conf"
GENTOO_INSTALL_PACKAGES="ca-certificates"
GENTOO_SSL_CERT_DIR="/usr/local/share/ca-certificates"

# shellcheck source=../common-functions.sh
. ../common-functions.sh

# Begin configuration script
if [ "$(uname)" != "Linux" ]; then
    echo "Non-Linux OS is not currently supported. '$(uname)'"
    exit 1
fi

if command -v  emerge >/dev/null 2>&1; then
    echo "Gentoo Portage found."
    configure_ssl_variables_and_certs "$GENTOO_SSL_CERT_DIR"

    echo "Determining what packages are installed."
    not_installed_packages=""
    for package in $GENTOO_INSTALL_PACKAGES; do
        if ! emerge -qv "$package" >/dev/null 2>&1; then
            not_installed_packages="$not_installed_packages $package"
        fi
    done

    if [[ "$not_installed_packages" ]]; then
        echo "Updating package database"
        emerge-webrsync --no-pgp-verify

        echo "Installing required packages."
        # shellcheck disable=SC2086
        emerge $not_installed_packages || echo "Failed to install $not_installed_packages packages."
    fi

    echo "Updating certificates."
    update_certificates

    configure_individual_certs_with_step

    echo "Removing temporary packages."
    if [[ "$not_installed_packages" ]]; then
        # shellcheck disable=SC2086
        emerge --depclean $not_installed_packages || echo "Unable to remove installed packages."
    fi

    echo "Gentoo certificate configuration complete."
else
    echo "Gentoo Portage not found."
fi
