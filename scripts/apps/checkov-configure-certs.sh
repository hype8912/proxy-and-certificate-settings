#!/bin/bash

if command -v checkov >/dev/null 2>&1; then
    echo "Updating checkov variable(s)."
    export BC_CA_BUNDLE="$SSL_CERT_FILE"
fi
