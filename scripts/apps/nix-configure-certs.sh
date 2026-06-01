#!/bin/sh

if command -v nix >/dev/null 2>&1; then
    echo "Updating Nix variable(s)."
    export NIX_SSL_CERT_FILE="$SSL_CERT_FILE"
fi
