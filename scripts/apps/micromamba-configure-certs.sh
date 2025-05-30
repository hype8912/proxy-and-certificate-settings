#!/bin/bash

if command -v micromamba >/dev/null 2>&1; then
    echo "Updating Micromamba configuration"
    micromamba config set ssl_verify "$SSL_CERT_FILE"
fi
