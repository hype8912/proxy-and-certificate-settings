#!/bin/bash

# Define external file sources
certs_url="http://mycompany.com/Company_CA.pem"
certs_zip_url="http://mycompany.com/Company_certs.zip"

# Define basic variables
LOCAL_CERTS_CRT_NAME="Company_CA.crt"
LOCAL_CERTS_PEM_NAME="Company_CA.pem"

# Define OS variables
ARCH_REPO_LOCAL_PATH="/etc/pacman.d/mirrorlist"
ARCH_INSTALL_PACKAGES="curl step-cli unzip"
ARCH_SSL_CERT_DIR="/etc/ca-certificates/trust-source/anchors"

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
    export SSL_CERT_DIR="$ARCH_SSL_CERT_DIR"
    mkdir -p "$SSL_CERT_DIR"
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

    echo "Downloading $LOCAL_CERTS_ZIP_NAME Certificates."
    curl -L "$certs_zip_url" -o "/$LOCAL_CERTS_ZIP_NAME"
    if [ -e "/$LOCAL_CERTS_ZIP_NAME" ]; then
        if command -v unzip >/dev/null 2>&1; then
            echo "Unzipping $LOCAL_CERTS_ZIP_NAME file."
            unzip "/$LOCAL_CERTS_ZIP_NAME"

            if [ -d "Certificates" ]; then
                cd "Certificates" ||:
                find . -type f -exec step-cli certificate install --all {} \;
                update-ca-trust extract
            fi
        else
            echo "Unzip not installed."
        fi
    fi

    echo "Removing installed packages. $not_installed_packages"
    if [[ "$not_installed_packages" ]]; then
        # shellcheck disable=SC2086
        pacman -Rs $not_installed_packages --noconfirm
    fi

    pacman -Sc --noconfirm
    cd ".." && rm -r "Certificates" >/dev/null 2>&1
    echo "Pacman certificate configuration complete."
else
    echo "Linux Arch flavor not found."
fi
