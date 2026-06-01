#!/bin/sh
# Tested on: kaniko-project/executor:v1.23.2-debug

# Define basic variables
# KANIKO_SSL_CERT_DIR="/kaniko/ssl/certs"
KANIKO_LOCAL_CRT_NAME="ca-certificates.crt"

if command -v /kaniko/executor >/dev/null 2>&1; then
    echo "Updating kaniko configuration."

    if [ -f "$SSL_CERT_FILE" ]; then
        export SSL_CA_CERT="$SSL_CERT_DIR/$KANIKO_LOCAL_CRT_NAME"
        ln -s -f "$SSL_CERT_FILE" "$SSL_CA_CERT"
    fi
fi
