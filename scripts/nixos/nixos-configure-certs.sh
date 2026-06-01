#!/bin/sh
# Tested on:
# nixos/nix:latest

# Define external file sources
certs_url="http://mycompany.com/Company_CA.pem"
certs_tar_url="http://mycompany.com/Company_certs.tar"

# Define basic variables
LOCAL_CERTS_CRT_NAME="Company_CA.crt"
LOCAL_CERTS_PEM_NAME="Company_CA.pem"
LOCAL_CERTS_TAR_NAME="Company_certs.tar"

# Define OS variables
NIXOS_REPO_LOCAL_PATH: "/nix/store"
NIXOS_INSTALL_PACKAGES: ""
NIXOS_SSL_CERT_DIR: "/etc/ssl/certs"

# shellcheck source=../common-functions.sh
. ../common-functions.sh

# Begin configuration script
if [ "$(uname)" != "Linux" ]; then
    echo "Non-Linux OS is not currently supported. '$(uname)'"
    exit 1
fi

if command -v nix >/dev/null 2>&1; then
    echo "NixOS Linux flavor found."
    configure_ssl_variables_and_certs "$NIXOS_SSL_CERT_DIR"

    echo "NixOS certificate configuration complete."
else
    echo "NixOS Linux flavor not found."
fi
