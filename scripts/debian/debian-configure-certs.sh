#!/bin/bash
# Tested on:
# Debian 10+, Ubuntu 18.04+

# Define external file sources
certs_url="http://mycompany.com/Company_CA.pem"
certs_zip_url="http://mycompany.com/Company_certs.zip"

# Define basic variables
LOCAL_CERTS_CRT_NAME="Company_CA.crt"
LOCAL_CERTS_PEM_NAME="Company_CA.pem"

# Define OS variables
# DEBIAN_REPO_LOCAL_PATH="/etc/apt/apt.conf.d/00-ssl-verify"
DEBIAN_INSTALL_PACKAGES="curl ca-certificates unzip"
DEBIAN_SSL_CERT_DIR="/usr/local/share/ca-certificates"
DEBIAN_PM_OPTIONS="-o Acquire::https::Verify-Peer=false -o Acquire::https::Verify-Host=false"

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

    export SSL_CERT_DIR="$DEBIAN_SSL_CERT_DIR"
    export SSL_CERT_FILE="$SSL_CERT_DIR/$LOCAL_CERTS_PEM_NAME"
    echo "Downloading $LOCAL_CERTS_PEM_NAME CA Certificates."
    curl -Lk "$certs_url" -o "$SSL_CERT_FILE"

    export SSL_CA_CERT="$SSL_CERT_DIR/$LOCAL_CERTS_CRT_NAME"
    if [ -f "$SSL_CERT_FILE" ]; then
        export PIP_CERT="$SSL_CERT_FILE"
        export REQUESTS_CA_BUNDLE="$SSL_CERT_FILE"

        chmod 644 "$SSL_CERT_FILE"
        ln -s -f "$SSL_CERT_FILE" "$SSL_CA_CERT"
    else
        echo "SSL_CERT_FILE missing. $SSL_CERT_FILE"
    fi

    if [ -f "$SSL_CA_CERT" ]; then
        export CURL_CA_BUNDLE="$SSL_CA_CERT"
        export GITLAB_CERTIFICATE_PATH="$SSL_CA_CERT"
        export GRYPE_DB_CA_CERT="$SSL_CA_CERT"
    else
        echo "SSL_CA_CERT missing. $SSL_CA_CERT"
    fi

    update-ca-certificates

    echo "Downloading $LOCAL_CERTS_ZIP_NAME Certificates."
    curl -L "$certs_zip_url" -o "/$LOCAL_CERTS_ZIP_NAME"
    if [ -e "/$LOCAL_CERTS_ZIP_NAME" ]; then
        if command -v unzip >/dev/null 2>&1; then
            echo "Unzipping $LOCAL_CERTS_ZIP_NAME file."
            unzip "/$LOCAL_CERTS_ZIP_NAME"

            mkdir -p "$SSL_CERT_DIR/extra"
            cp -r Certificates/. "$SSL_CERT_DIR/extra"
            echo "Removing extracted certs directory."
            rm -r "Certificates" >/dev/null 2>&1
            update-ca-certificates
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
