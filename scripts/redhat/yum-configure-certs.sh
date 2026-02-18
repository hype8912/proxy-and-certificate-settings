#!/bin/bash
# Tested on:
# Fedora 40+, CentOS 6+, Red Hat 7+, OracleLinux 6+, Rocky Linux 8+, Alma Linux 8+, UBI 8+, Amazon Linux 2+

# Define external file sources
certs_url="http://mycompany.com/Company_CA.pem"
certs_zip_url="http://mycompany.com/Company_certs.zip"
step_cli_rpm_package_url="https://dl.smallstep.com/cli/docs-cli-install/latest/step-cli_amd64.rpm"

# Define basic variables
LOCAL_CERTS_CRT_NAME="Company_CA.crt"
LOCAL_CERTS_PEM_NAME="Company_CA.pem"
LOCAL_STEP_CLI_NAME="step-cli.rpm"

# Define OS variables
# YUM_REPO_LOCAL_PATH="/etc/yum.conf"
YUM_INSTALL_PACKAGES="curl step-cli unzip"
YUM_SSL_CERT_DIR="/etc/pki/ca-trust/source/anchors"
# YUM_SSL_CERT_DIR_USR="/usr/share/pki/ca-trust-source/anchors"

# Begin configuration script
if [ "$(uname)" != "Linux" ]; then
    echo "Non-Linux OS is not currently supported. '$(uname)'"
    exit 1
fi

if command -v yum >/dev/null 2>&1; then
    echo "Centos/Fedora/Rocky/Redhat Yum flavor found."

    if command -v dnf >/dev/null 2>&1; then
        echo "Skipping Yum setup since DNF is installed."
        yum --noplugins --enablerepo='*' clean all -y
        exit 0
    else
        if [[ -f "$YUM_SSL_CERT_DIR/$LOCAL_CERTS_PEM_NAME" && -f "$YUM_SSL_CERT_DIR/$LOCAL_CERTS_CRT_NAME" ]]; then
            echo "Yum setup skipped since already configured."
        else
            if head "/etc/redhat-release" | grep -q "^CentOS release 6"; then
                echo "Updating CentOS 6 repository mirrors."
                # shellcheck disable=SC2016
                sed -i -e '/^mirrorlist=/d' -e 's;^#\(baseurl=\)http://mirror\.centos\.org/centos/\$releasever/\(.*\)$;\1http://archive.kernel.org/centos-vault/centos/6/\2;' /etc/yum.repos.d/CentOS-*.repo
            fi

            if head "/etc/redhat-release" | grep -q "^CentOS Linux release 7"; then
                echo "Updating CentOS 7 repository mirrors."
                # shellcheck disable=SC2016
                sed -i -e '/^mirrorlist=/d' -e 's;^#\(baseurl=\)http://mirror\.centos\.org/centos/\$releasever/\(.*\)$;\1http://archive.kernel.org/centos-vault/centos/7/\2;' /etc/yum.repos.d/CentOS-*.repo
            fi

            yum --setopt=sslverify=false update --noplugins --security -y || yum --setopt=sslverify=false update --noplugins --enableplugin=yum-plugin-security -y

            echo "Determining what packages are installed."
            not_installed_packages=""
            for package in $YUM_INSTALL_PACKAGES; do
                if ! yum --noplugins list installed "$package" >/dev/null 2>&1; then
                    not_installed_packages="$not_installed_packages $package"
                fi
            done

            if [[ "$not_installed_packages" ]]; then
                echo "Installing required packages."
                # shellcheck disable=SC2086
                yum --setopt=sslverify=false --setopt=tsflags=nodocs --noplugins install $not_installed_packages --skip-broken -y || echo "Failed to install $YUM_INSTALL_PACKAGES - $not_installed_packages packages."
            fi

            export SSL_CERT_DIR="$YUM_SSL_CERT_DIR"
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

            update-ca-trust extract

            echo "Downloading $LOCAL_STEP_CLI_NAME package."
            if ! yum --noplugins list installed step-cli >/dev/null 2>&1; then
                curl -L "$step_cli_rpm_package_url" -o "$LOCAL_STEP_CLI_NAME"

                if [ -f "$LOCAL_STEP_CLI_NAME" ]; then
                    yum --noplugins install "$LOCAL_STEP_CLI_NAME" -y || echo "Failed to install $LOCAL_STEP_CLI_NAME package."
                    rm -f "$LOCAL_STEP_CLI_NAME"
                    not_installed_packages="$not_installed_packages step-cli"
                fi
            else
                echo "$LOCAL_STEP_CLI_NAME package already installed."
            fi

            echo "Downloading $LOCAL_CERTS_ZIP_NAME Certificates."
            curl -L "$certs_zip_url" -o "/$LOCAL_CERTS_ZIP_NAME"
            if [ -e "/$LOCAL_CERTS_ZIP_NAME" ]; then
                echo "Unzipping $LOCAL_CERTS_ZIP_NAME file."
                unzip "/$LOCAL_CERTS_ZIP_NAME"

                if [ -d "Certificates" ]; then
                    cd "Certificates" ||:
                    find . -type f -exec step certificate install --all {} \;
                    update-ca-trust extract
                fi
            fi

            not_installed_packages=${not_installed_packages//"curl "/}
            echo "Removing installed packages. $not_installed_packages"
            if [[ "$not_installed_packages" ]]; then
                # shellcheck disable=SC2086
                yum --noplugins remove -y $not_installed_packages || echo "Unable to remove installed packages."
                yum --noplugins autoremove -y ||:
            fi

            yum --noplugins --enablerepo='*' clean all -y
            cd ".." && rm -r "Certificates" >/dev/null 2>&1
            echo "Yum certificate configuration complete."
        fi
    fi
else
    echo "Linux Centos/Fedora/Rocky/Redhat Yum flavor not found."
fi
