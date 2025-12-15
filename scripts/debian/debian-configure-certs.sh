#!/bin/bash
# Tested on:
# Debian 10+, Ubuntu 18.04+

# Define external file sources
certs_url="http://mycompany.com/Company_CA.pem"
certs_tar_url="http://mycompany.com/Company_certs.tar"

# Define basic variables
LOCAL_CERTS_CRT_NAME="Company_CA.crt"
LOCAL_CERTS_PEM_NAME="Company_CA.pem"
LOCAL_CERTS_TAR_NAME="Company_certs.tar"

# Define OS variables
# DEBIAN_REPO_LOCAL_PATH="/etc/apt/apt.conf.d/00-ssl-verify"
DEBIAN_INSTALL_PACKAGES="curl ca-certificates"
DEBIAN_SSL_CERT_DIR="/usr/local/share/ca-certificates"
DEBIAN_PM_OPTIONS="-o Acquire::https::Verify-Peer=false -o Acquire::https::Verify-Host=false"

# shellcheck source=../common-functions.sh
. ../common-functions.sh

# Begin configuration script
if [ "$(uname)" != "Linux" ]; then
    echo "Non-Linux OS is not currently supported. '$(uname)'"
    exit 1
fi

if command -v apt-get >/dev/null 2>&1; then
    echo "Debian flavor"
    # shellcheck disable=SC2086
    apt-get $DEBIAN_PM_OPTIONS update || echo "Failed to update repositories."

    echo "Determining what packages are installed."
    not_installed_packages=""
    for package in $DEBIAN_INSTALL_PACKAGES; do
        if ! dpkg -s "$package" >/dev/null 2>&1; then
            not_installed_packages="$not_installed_packages $package"
        fi
    done

    if [[ "$not_installed_packages" ]]; then
        echo "Installing required packages."
        # shellcheck disable=SC2086
        apt-get $DEBIAN_PM_OPTIONS install $not_installed_packages -y || echo "Failed to install $DEBIAN_INSTALL_PACKAGES - $not_installed_packages packages."
    fi

    configure_ssl_variables_and_certs "$DEBIAN_SSL_CERT_DIR"
    update_certificates

    echo "Downloading $LOCAL_CERTS_TAR_NAME Certificates."
    download_file "$certs_tar_url" "/$LOCAL_CERTS_TAR_NAME"
    if [[ -e "/$LOCAL_CERTS_TAR_NAME" ]]; then
        if command -v tar >/dev/null 2>&1; then
            echo "Extracting $LOCAL_CERTS_TAR_NAME file."
            tar -xf "/$LOCAL_CERTS_TAR_NAME"

            mkdir -p "$SSL_CERT_DIR/extra"
            cp -r Certificates/. "$SSL_CERT_DIR/extra"

            echo "Removing extracted certs directory."
            rm -r "Certificates" >/dev/null 2>&1
            update_certificates
        else
            echo "Tar package not installed."
        fi
    fi

    not_installed_packages=${not_installed_packages//"curl "/}
    echo "Removing installed packages. $not_installed_packages"
    if [[ "$not_installed_packages" ]]; then
        # shellcheck disable=SC2086
        apt-get remove $not_installed_packages -y || echo "Unable to remove installed packages."
        apt-get autoremove -y
    fi

    apt-get clean
    echo "Apt-get certificate configuration complete."
else
    echo "Linux Debian flavor not found."
fi
