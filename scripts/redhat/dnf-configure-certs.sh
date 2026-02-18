#!/bin/bash
# Tested on:
# Fedora 40+, CentOS 8, CentOS Stream 8+, Red Hat 8+, OracleLinux 8+, Rocky Linux 8+, Alma Linux 8+, UBI 8+, Amazon Linux 2022+

# Define external file sources
certs_url="http://mycompany.com/Company_CA.pem"
certs_zip_url="http://mycompany.com/Company_certs.zip"
step_cli_rpm_package_url="https://dl.smallstep.com/cli/docs-cli-install/latest/step-cli_amd64.rpm"

# Define basic variables
LOCAL_CERTS_CRT_NAME="Company_CA.crt"
LOCAL_CERTS_PEM_NAME="Company_CA.pem"
LOCAL_STEP_CLI_NAME="step-cli.rpm"

# Define OS variables
# DNF_REPO_LOCAL_PATH="/etc/dnf/dnf.conf"
DNF_INSTALL_PACKAGES="curl findutils unzip"
DNF_SSL_CERT_DIR="/etc/pki/ca-trust/source/anchors"
# DNF_SSL_CERT_DIR_USR="/usr/share/pki/ca-trust-source/anchors"

# Begin configuration script
if [ "$(uname)" != "Linux" ]; then
    echo "Non-Linux OS is not currently supported. '$(uname)'"
    exit 1
fi

if command -v dnf >/dev/null 2>&1; then
    echo "Centos/Fedora/Rocky/Redhat DNF flavor found."
    if [[ -f "$DNF_SSL_CERT_DIR/$LOCAL_CERTS_PEM_NAME" && -f "$DNF_SSL_CERT_DIR/$LOCAL_CERTS_CRT_NAME" ]]; then
        echo "Skipping DNF setup since already configured."
        exit 0
    fi
    
    dnf upgrade-minimal --refresh --best --nodocs --noplugins --security --setopt=install_weak_deps=False --setopt=sslverify=0 -y

    echo "Determining what packages are installed."
    not_installed_packages=""
    for package in $DNF_INSTALL_PACKAGES; do
        if ! dnf --noplugins info --installed "$package" >/dev/null 2>&1; then
            not_installed_packages="$not_installed_packages $package"
        fi
    done

    if [[ "$not_installed_packages" ]]; then
        echo "Installing required packages."
        # shellcheck disable=SC2086
        dnf install $not_installed_packages --nodocs --skip-broken --noplugins --setopt=install_weak_deps=False --setopt=sslverify=0 -y || echo "Failed to install $DNF_INSTALL_PACKAGES - $not_installed_packages packages."
    fi
    
    export SSL_CERT_DIR="$DNF_SSL_CERT_DIR"
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
    if ! dnf --noplugins info --installed step-cli >/dev/null 2>&1; then
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
            echo "Unzipping $LOCAL_CERTS_ZIP_NAME file."
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

    not_installed_packages=${not_installed_packages//"curl "/}
    echo "Removing installed packages. $not_installed_packages"
    if [[ "$not_installed_packages" ]]; then
        # shellcheck disable=SC2086
        dnf --noplugins remove -y $not_installed_packages || echo "Unable to remove installed packages."
        dnf --noplugins autoremove -y
    fi

    dnf --noplugins clean all --enablerepo='*' -y
    cd ".." && rm -r "Certificates" >/dev/null 2>&1
    echo "DNF certificate configuration complete."
else
    echo "Centos/Fedora/Rocky/Redhat DNF flavor not found."
fi
