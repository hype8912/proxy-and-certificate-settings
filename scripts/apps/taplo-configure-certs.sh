#!/bin/sh

if command -v taplo >/dev/null 2>&1; then
    echo "Updating Taplo variable(s)."
    export TAPLO_EXTRA_CA_CERTS="$SSL_CERT_FILE"
fi
