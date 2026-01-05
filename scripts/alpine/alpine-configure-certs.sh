#!/bin/sh
# Tested on: Alpine 3.15+

# Define external file sources
certs_url="http://mycompany.com/Company_CA.pem"
certs_tar_url="http://mycompany.com/Company_certs.tar"

# Define basic variables
LOCAL_CERTS_CRT_NAME="Company_CA.crt"
LOCAL_CERTS_PEM_NAME="Company_CA.pem"
LOCAL_CERTS_TAR_NAME="Company_certs.tar"

# Define OS variables
# ALPINE_REPO_STABLE="https://dl-cdn.alpinelinux.org/alpine/latest-stable/main"
ALPINE_REPO_LOCAL_PATH="/etc/apk/repositories"
ALPINE_INSTALL_PACKAGES="ca-certificates step-cli"
ALPINE_SSL_CERT_DIR="/usr/local/share/ca-certificates"

# shellcheck source=../common-functions.sh
. ../common-functions.sh

# Begin configuration script
if [ "$(uname)" != "Linux" ]; then
    echo "Non-Linux OS is not currently supported. '$(uname)'"
    exit 1
fi

if command -v apk >/dev/null 2>&1; then
    echo "Alpine flavor found."
    #echo "$ALPINE_REPO_STABLE" >> "$ALPINE_REPO_LOCAL_PATH"

    echo "Determining what packages are installed."
    not_installed_packages=""
    for package in $ALPINE_INSTALL_PACKAGES; do
        if ! apk info -e "$package" >/dev/null 2>&1; then
            not_installed_packages="$not_installed_packages $package"
        fi
    done

    if [ "$not_installed_packages" ]; then
        if ! apk update --no-check-certificate; then
            sed -i -e "s/https:/http:/g" "$ALPINE_REPO_LOCAL_PATH"
            apk update --allow-untrusted
        fi
    
        echo "Installing required packages."
        # shellcheck disable=SC2086
        apk add --no-check-certificate $not_installed_packages || apk add --allow-untrusted $not_installed_packages || echo "Failed to install $ALPINE_INSTALL_PACKAGES - $not_installed_packages packages."
    fi

    configure_ssl_variables_and_certs "$ALPINE_SSL_CERT_DIR"
    update_certificates

    echo "Removing installed packages. $not_installed_packages"
    if [ "$not_installed_packages" ]; then
        # shellcheck disable=SC2086
        apk del $not_installed_packages || echo "Unable to remove installed packages."
    fi

    sed -i -e "s/http:/https:/g" "$ALPINE_REPO_LOCAL_PATH"
    apk cache --purge || echo "[INFO] Unable to purge APK repository cache."
    echo "Apk certificate configuration complete."
else
    echo "Linux Alpine flavor not found."
fi
