#!/bin/sh

if command -v hex >/dev/null 2>&1; then
    echo "Updating Hex variable(s)."
    export HEX_CACERTS_PATH="$SSL_CERT_FILE"
fi
