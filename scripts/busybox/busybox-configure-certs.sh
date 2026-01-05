#!/bin/sh
# Tested on:
# kaniko-project/executor:v1.23.2-debug, go-containerregistry/crane:debug

# Define external file sources
certs_url="http://mycompany.com/Company_CA.pem"

# Define basic variables
LOCAL_CERTS_PEM_NAME="Company_CA.pem"

# Define OS variables
BUSYBOX_SSL_CERT_DIR="/usr/local/share/ca-certificates"
BUSYBOX_LOCAL_CRT_NAME="ca_certificates.crt"

# Begin configuration script
if [ "$(uname)" != "Linux" ]; then
    echo "Non-Linux OS is not currently supported. '$(uname)'"
    exit 1
fi

if [ "$(command -v sh)" = "/busybox/sh" ]; then
    echo "Generic Busybox flavor found."
    export SSL_CERT_DIR="$BUSYBOX_SSL_CERT_DIR"
    mkdir -p "$SSL_CERT_DIR"

    if command -v wget >/dev/null 2>&1; then
        export SSL_CERT_FILE="$SSL_CERT_DIR/$LOCAL_CERTS_PEM_NAME"
        export SSL_CA_CERT="$SSL_CERT_DIR/$BUSYBOX_LOCAL_CRT_NAME"

        wget --no-check-certificate -O "$SSL_CERT_FILE" "$certs_url"
        if [ -f "$SSL_CERT_FILE" ]; then
            chmod 644 "$SSL_CERT_FILE"
            ln -s -f "$SSL_CERT_FILE" "$SSL_CA_CERT"
        fi
    fi
else
    echo "Linux BusyBox flavor not found."
fi
