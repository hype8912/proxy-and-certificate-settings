#!/bin/bash
# Tested on:
# aclemons/slackware:latest

# Define external file sources
certs_url="http://mycompany.com/Company_CA.pem"
certs_tar_url="http://mycompany.com/Company_certs.tar"

# Define basic variables
LOCAL_CERTS_CRT_NAME="Company_CA.crt"
LOCAL_CERTS_PEM_NAME="Company_CA.pem"
LOCAL_CERTS_TAR_NAME="Company_certs.tar"

# Define OS variables
SLACKWARE_REPO_LOCAL_PATH="/etc/slackpkg/mirrors"
SLACKWARE_INSTALL_PACKAGES="ca-certificates"
SLACKWARE_SSL_CERT_DIR="/etc/ssl/certs"

# shellcheck source=../common-functions.sh
. ../common-functions.sh

# Begin configuration script
if [ "$(uname)" != "Linux" ]; then
    echo "Non-Linux OS is not currently supported. '$(uname)'"
    exit 1
fi

if [ -f "/etc/slackware-version" ]; then
    echo "Slackware detected."
    configure_ssl_variables_and_certs "$SLACKWARE_SSL_CERT_DIR"
    update_certificates

    echo "Determining what packages are installed."
    not_installed_packages=""
    for package in $SLACKWARE_INSTALL_PACKAGES; do
        if ! slackpkg search "$package" >/dev/null 2>&1; then
            not_installed_packages="$not_installed_packages $package"
        fi
    done

    if [[ "$not_installed_packages" ]]; then
        echo "Updating package database"
        slackpkg update

        echo "Installing required packages."
        # shellcheck disable=SC2086
        slackpkg install $not_installed_packages || echo "Failed to install $not_installed_packages packages."
    fi

    # Slackware may need custom certificate handling
    configure_individual_certs_with_step
    update_certificates

    echo "Slackware certificate configuration complete."
else
    echo "Slackware not detected."
fi
