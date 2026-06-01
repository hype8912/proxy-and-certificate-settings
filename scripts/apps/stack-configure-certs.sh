#!/bin/sh

if command -v stack >/dev/null 2>&1; then
    echo "Updating Haskell Stack variable(s)."
    export SYSTEM_CERTIFICATE_PATH="$SSL_CERT_DIR"
fi
