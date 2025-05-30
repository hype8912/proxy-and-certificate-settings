#!/bin/bash

# Define external file sources
certs_url="http://mycompany.com/Company_CA.pem"
certs_zip_url="http://mycompany.com/Company_certs.zip"
step_cli_rpm_package_url="https://dl.smallstep.com/cli/docs-cli-install/latest/step-cli_amd64.rpm"

# Define basic variables
LOCAL_CERTS_CRT_NAME="Company_CA.crt"
LOCAL_CERTS_PEM_NAME="Company_CA.pem"
LOCAL_STEP_CLI_NAME="step-cli.rpm"

# Define OS variables
MICRODNF_REPO_LOCAL_PATH="/etc/dnf/dnf.conf"
MICRODNF_INSTALL_PACKAGES="curl-minimal findutils unzip"
MICRODNF_SSL_CERT_DIR="/etc/pki/ca-trust/source/anchors"
# MICRODNF_SSL_CERT_DIR_USR="/usr/share/pki/ca-trust-source/anchors"

# Begin configuration script
if [ "$(uname)" != "Linux" ]; then
    echo "Non-Linux OS is not currently supported. '$(uname)'"
    exit 1
fi

if command -v microdnf >/dev/null 2>&1; then
    echo "Centos/Fedora/Rocky/Redhat MicroDNF flavor found."
    if command -v dnf >/dev/null 2>&1; then
        echo "Skipping MicroDNF setup since DNF is installed."
        exit 0
    fi

    cp "$MICRODNF_REPO_LOCAL_PATH" "$MICRODNF_REPO_LOCAL_PATH.bak" 2>/dev/null ||:
    echo "sslverify=0" >> "$MICRODNF_REPO_LOCAL_PATH"
    microdnf upgrade --refresh --best --nodocs --noplugins --setopt=install_weak_deps=0 -y

    echo "Determining what packages are installed."
    not_installed_packages=""
    for package in $MICRODNF_INSTALL_PACKAGES; do
        if ! rpm -q "$package" >/dev/null 2>&1; then
            not_installed_packages="$not_installed_packages $package"
        fi
    done

    if [[ "$not_installed_packages" ]]; then
        echo "Installing required packages."
        # shellcheck disable=SC2086
        microdnf install $not_installed_packages --best --nodocs --noplugins --setopt=install_weak_deps=0 -y || echo "Failed to install $MICRODNF_INSTALL_PACKAGES - $not_installed_packages packages."
    fi

    cp "$MICRODNF_REPO_LOCAL_PATH.bak" "$MICRODNF_REPO_LOCAL_PATH" 2>/dev/null ||:
    export SSL_CERT_DIR="$MICRODNF_SSL_CERT_DIR"
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

    update-ca-trust extract

    echo "Downloading $LOCAL_STEP_CLI_NAME."
    if ! rpm -q step-cli >/dev/null 2>&1; then
        curl -L "$step_cli_rpm_package_url" -o "$LOCAL_STEP_CLI_NAME"

        if [ -f "$LOCAL_STEP_CLI_NAME" ]; then
            rpm -ivh "$LOCAL_STEP_CLI_NAME" || echo "Failed to install $LOCAL_STEP_CLI_NAME package."
            rm -f "$LOCAL_STEP_CLI_NAME"
            not_installed_packages="$not_installed_packages step-cli"
        fi
    else
        echo "$LOCAL_STEP_CLI_NAME package already installed."
    fi

    echo "Downloading $LOCAL_CERTS_ZIP_NAME Certificates."
    curl -L "$certs_zip_url" -o "/$LOCAL_CERTS_ZIP_NAME"
    if [ -e "/$LOCAL_CERTS_ZIP_NAME" ]; then
        if command -v unzip >/dev/null 2>&1; then
            unzip "/$LOCAL_CERTS_ZIP_NAME"

            if [ -d "Certificates" ]; then
                cd "Certificates" ||:
                find . -type f -exec step certificate install --all {} \;
                update-ca-trust extract
            fi
        else
            echo "Unzip not installed."
        fi
    fi

    not_installed_packages=${not_installed_packages//"curl-minimal "/}
    echo "Removing installed packages. $not_installed_packages"
    if [[ "$not_installed_packages" ]]; then
        # shellcheck disable=SC2086
        microdnf remove --noplugins -y $not_installed_packages || echo "Unable to remove installed packages."
    fi

    microdnf clean all --noplugins --enablerepo='*' -y
    cd ".." && rm -r "Certificates" >/dev/null 2>&1
fi
