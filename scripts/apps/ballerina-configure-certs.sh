#!/bin/sh

if command -v bal >/dev/null 2>&1; then
    echo "Updating Ballerina variable(s)."
    export BALLERINA_CA_BUNDLE="$SSL_CERT_FILE"
    export BALLERINA_CA_CERT="$SSL_CA_CERT"
fi
