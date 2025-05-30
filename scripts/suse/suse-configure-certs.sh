#!/bin/bash
# Tested on: Leap 15+, Tumbleweed 

# Define external file sources
certs_url="http://mycompany.com/Company_CA.pem"
certs_zip_url="http://mycompany.com/Company_certs.zip"
step_cli_rpm_package_url="https://dl.smallstep.com/cli/docs-cli-install/latest/step-cli_amd64.rpm"

# Define basic variables
LOCAL_CERTS_CRT_NAME="Company_CA.crt"
LOCAL_CERTS_PEM_NAME="Company_CA.pem"
LOCAL_STEP_CLI_NAME="step-cli.rpm"

# Define OS variables
SUSE_INSTALL_PACKAGES="curl step-cli unzip"
SUSE_SSL_CERT_DIR="/etc/ssl"
SUSE_PM_OPTIONS="--non-interactive"

# Begin configuration script
if [ "$(uname)" != "Linux" ]; then
    echo "Non-Linux OS is not currently supported. '$(uname)'"
    exit 1
fi

if command -v zypper >/dev/null 2>&1; then
    echo "OpenSUSE flavor found."
    zypper $SUSE_PM_OPTIONS refresh

    echo "Determining what packages are installed."
    not_installed_packages=""
    for package in $SUSE_INSTALL_PACKAGES; do
        if ! rpm -q "$package" >/dev/null 2>&1; then
            not_installed_packages="$not_installed_packages $package"
        fi
    done

    if [[ "$not_installed_packages" ]]; then
        echo "Installing required packages."
        # shellcheck disable=SC2086
        zypper $SUSE_PM_OPTIONS --ignore-unknown install --no-recommends $not_installed_packages || echo "Failed to install $SUSE_INSTALL_PACKAGES - $not_installed_packages packages."
    fi

    export SSL_CERT_DIR="$SUSE_SSL_CERT_DIR"
    mkdir -p "$SSL_CERT_DIR"
    export SSL_CERT_FILE="$SSL_CERT_DIR/$LOCAL_CERTS_PEM_NAME"

    echo "Downloading $LOCAL_CERTS_PEM_NAME CA Certificates."
    curl -Lk "$certs_url" -o "$SSL_CERT_FILE"

    export SSL_CA_CERT="$SSL_CERT_DIR/$LOCAL_CERTS_CRT_NAME"
    if [ -f "$SSL_CERT_FILE" ]; then
        export PIP_CERT="$SSL_CERT_FILE"
        export REQUESTS_CA_BUNDLE="$SSL_CERT_FILE"

        chmod 644 "$SSL_CERT_FILE"
        ln -s "$SSL_CERT_FILE" "$SSL_CA_CERT"
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

    echo "Downloading $LOCAL_STEP_CLI_NAME."
    if ! rpm -q step-cli >/dev/null 2>&1; then
        curl -L "$step_cli_rpm_package_url" -o "$LOCAL_STEP_CLI_NAME"

        if [ -f "$LOCAL_STEP_CLI_NAME" ]; then
            zypper $SUSE_PM_OPTIONS --no-gpg-checks install --no-recommends "$LOCAL_STEP_CLI_NAME" || echo "Failed to install $LOCAL_STEP_CLI_NAME package."
            rm -f "$LOCAL_STEP_CLI_NAME"

            if [[ ! $not_installed_packages =~ "step-cli" ]]; then
                not_installed_packages="$not_installed_packages step-cli"
            fi
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
                update-ca-certificates
            fi
        else
            echo "Unzip not installed."
        fi
    fi

    not_installed_packages=${not_installed_packages//"curl "/}
    echo "Removing installed packages. $not_installed_packages"
    if [[ "$not_installed_packages" ]]; then
        # shellcheck disable=SC2086
        zypper $SUSE_PM_OPTIONS --ignore-unknown remove $not_installed_packages
    fi

    zypper $SUSE_PM_OPTIONS clean --all
    cd ".." && rm -r "Certificates" >/dev/null 2>&1
    echo "Zypper certificate configuration complete."
else
    echo "Linux OpenSUSE flavor not found."
fi
