#!/bin/sh

if command -v deno >/dev/null 2>&1; then
    echo "Updating Deno variable(s)."
    export DENO_TLS_CA_STORE="system"
    export DENO_CERT="$SSL_CERT_FILE"
fi
