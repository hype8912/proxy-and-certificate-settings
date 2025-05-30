#!/bin/bash
# Tested on: Alpine 3.15+

# Define external file sources
certs_url="http://mycompany.com/Company_CA.pem"
certs_zip_url="http://mycompany.com/Company_certs.zip"

# Define basic variables
LOCAL_CERTS_CRT_NAME="Company_CA.crt"
LOCAL_CERTS_PEM_NAME="Company_CA.pem"

# Define OS variables
ALPINE_REPO_STABLE="https://dl-cdn.alpinelinux.org/alpine/latest-stable/main"
ALPINE_REPO_LOCAL_PATH="/etc/apk/repositories"
ALPINE_INSTALL_PACKAGES="ca-certificates step-cli unzip"
ALPINE_SSL_CERT_DIR="/usr/local/share/ca-certificates"

# Begin configuration script
if [ "$(uname)" != "Linux" ]; then
    echo "Non-Linux OS is not currently supported. '$(uname)'"
    exit 1
fi

if command -v apk >/dev/null 2>&1; then
    echo "Alpine flavor found."
    echo "$ALPINE_REPO_STABLE" >> "$ALPINE_REPO_LOCAL_PATH"
    if ! apk update --no-check-certificate; then
        sed -i -e "s/https:/http:/g" "$ALPINE_REPO_LOCAL_PATH"
        apk update --allow-untrusted
    fi

    echo "Determining what packages are installed."
    not_installed_packages=""
    for package in $ALPINE_INSTALL_PACKAGES; do
        if ! apk info -e "$package" >/dev/null 2>&1; then
            not_installed_packages="$not_installed_packages $package"
        fi
    done

    if [[ "$not_installed_packages" ]]; then
        echo "Installing required packages."
        # shellcheck disable=SC2086
        apk add --no-check-certificate $not_installed_packages || apk add --allow-untrusted $not_installed_packages || echo "Failed to install $ALPINE_INSTALL_PACKAGES - $not_installed_packages packages."
    fi

    export SSL_CERT_DIR="$ALPINE_SSL_CERT_DIR"
    mkdir -p "$SSL_CERT_DIR"
    export SSL_CERT_FILE="$SSL_CERT_DIR/$LOCAL_CERTS_PEM_NAME"

    echo "Downloading $LOCAL_CERTS_PEM_NAME CA Certificates."
    wget --no-check-certificate -O "$SSL_CERT_FILE" "$certs_url"

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

    echo "Downloading $LOCAL_CERTS_ZIP_NAME Certificates."
    wget -O "/$LOCAL_CERTS_ZIP_NAME" "$certs_zip_url"
    if [ -e "/$LOCAL_CERTS_ZIP_NAME" ]; then
        if command -v unzip >/dev/null 2>&1; then
            echo "Unzipping $LOCAL_CERTS_ZIP_NAME file."
            unzip "/$LOCAL_CERTS_ZIP_NAME"

            if [ -d "Certificates" ]; then
                cd "Certificates" ||:
                find . -type f -exec step certificate install --all {} \;
            fi
        else
            echo "Unzip not installed."
        fi
    fi

    update-ca-certificates

    echo "Removing installed packages. $not_installed_packages"
    if [[ "$not_installed_packages" ]]; then
        # shellcheck disable=SC2086
        apk del $not_installed_packages || echo "Unable to remove installed packages."
    fi

    sed -i -e "s/http:/https:/g" "$ALPINE_REPO_LOCAL_PATH"
    apk cache --purge || echo "[INFO] Unable to purge APK repository cache."
    cd ".." && rm -r "Certificates" >/dev/null 2>&1
    echo "Apk certificate configuration complete."
else
    echo "Linux Alpine flavor not found."
fi
