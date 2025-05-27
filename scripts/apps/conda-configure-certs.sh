#!/bin/bash

if command -v conda >/dev/null 2>&1; then
    echo "Updating Conda configuration"
    conda config --set ssl_verify "$SSL_CERT_FILE"
fi
