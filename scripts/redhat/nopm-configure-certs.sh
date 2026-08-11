#!/bin/bash
# Tested on:
# 

# Define external file sources
certs_url="http://mycompany.com/Company_CA.pem"
certs_zip_url="http://mycompany.com/Company_certs.zip"

# Define basic variables
LOCAL_CERTS_CRT_NAME="Company_CA.crt"
LOCAL_CERTS_PEM_NAME="Company_CA.pem"
LOCAL_CERTS_ZIP_NAME="Company_certs.zip"

# Define OS variables
DNF_SSL_CERT_DIR="/etc/pki/ca-trust/source/anchors"

# Begin configuration script
if [ "$(uname)" != "Linux" ]; then
    echo "Non-Linux OS is not currently supported. '$(uname)'"
    exit 1
fi

REDHAT_SUPPORT_COUNT="$(cat /etc/*elease | grep -c 'REDHAT_SUPPORT_PRODUCT' ||:)"
if [ "$REDHAT_SUPPORT_COUNT" -gt "0" ]; then
    echo "Centos/Fedora/Rocky/Redhat Non-Package Manager flavor found."

    if [ -z "$SSL_CERT_FILE" ] && [ -z "$SSL_CA_CERT" ]; then
        if command -v curl >/dev/null 2>&1; then
            # Determine if the current user is root or has permissions to write
            # to the directories for placing the certificates.
            echo "Checking user and certificate path permissions."

            if [ "$(whoami)" = "root" ] || [ -w "$DNF_SSL_CERT_DIR" ] || [ -w "$DNF_SSL_CERT_DIR_USR" ]; then
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

                if command -v update-ca-trust >/dev/null 2>&1; then
                    update-ca-trust extract
                fi

                if command -v unzip >/dev/null 2>&1 && command -v step >/dev/null 2>&1; then
                    echo "Downloading $LOCAL_CERTS_ZIP_NAME Certificates."
                    curl -L "$certs_zip_url" -o "/$LOCAL_CERTS_ZIP_NAME"

                    echo "Unzipping $LOCAL_CERTS_ZIP_NAME file."
                    unzip "/$LOCAL_CERTS_ZIP_NAME"

                    if [ -d "Certificates" ]; then
                        cd "Certificates" ||:
                        find . -type f -exec step certificate install --all {} \;
                        if command -v update-ca-trust >/dev/null 2>&1; then
                            update-ca-trust extract
                        fi
                    fi
                fi
            else
                echo "Current user does not have permission to update certificates."
            fi
        else
            echo "Curl is not installed. Unable to continue certificate configuration."
        fi
    else
        echo "Centos/Fedora/Rocky/Redhat Non-Package Manager flavor already configured."
    fi
else
    echo "Centos/Fedora/Rocky/Redhat Non-Package Manager flavor not found."
fi
