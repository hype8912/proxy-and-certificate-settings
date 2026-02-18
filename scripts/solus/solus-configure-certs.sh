#!/bin/bash
# Tested on:
# silkeh/solus:slim

# Define external file sources
certs_url="http://mycompany.com/Company_CA.pem"
certs_tar_url="http://mycompany.com/Company_certs.tar"

# Define basic variables
LOCAL_CERTS_CRT_NAME="Company_CA.crt"
LOCAL_CERTS_PEM_NAME="Company_CA.pem"
LOCAL_CERTS_TAR_NAME="Company_certs.tar"

# Define OS variables
SOLUS_REPO_LOCAL_PATH: "/etc/eopkg/repositories.d"
SOLUS_INSTALL_PACKAGES: ""
SOLUS_SSL_CERT_DIR: "/etc/ssl/certs"
SOLUS_LOCAL_CRT_NAME: "ca_certificates.crt"

# shellcheck source=../common-functions.sh
. ../common-functions.sh

# Begin configuration script
if [ "$(uname)" != "Linux" ]; then
    echo "Non-Linux OS is not currently supported. '$(uname)'"
    exit 1
fi

if command -v eopkg >/dev/null 2>&1; then
    echo "Solus eopkg found."

    mkdir -p /etc/eopkg
    echo "[general]" > /etc/eopkg/eopkg.conf
    # shellcheck disable=SC2154
    echo "proxy_http = $http_proxy" >> /etc/eopkg/eopkg.conf
    echo "proxy_https = $http_proxy" >> /etc/eopkg/eopkg.conf

    configure_ssl_variables_and_certs "$SOLUS_SSL_CERT_DIR"

    echo "Updating variables."
    export SSL_CERT_FILE="$SOLUS_SSL_CERT_DIR/$SOLUS_LOCAL_CRT_NAME"
    export SSL_CA_CERT="$SSL_CERT_FILE"

    update_certificates

    echo "Restarting systemd services if available."
    if command -v systemctl >/dev/null 2>&1; then
        systemctl restart systemd-cryptenroll ||:
    fi

    echo "Solus certificate configuration complete."

else
    echo "Solus eopkg not found."
fi
