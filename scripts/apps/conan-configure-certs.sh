#!/bin/bash

if command -v conan >/dev/null 2>&1; then
    echo "Updating Conan variable(s)."
    export CONAN_CACERT_PATH="$SSL_CERT_FILE"
fi
