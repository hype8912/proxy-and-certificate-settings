#!/bin/bash

if command -v yarn >/dev/null 2>&1; then
    echo "Updating Yarn configuration"
    yarn config set httpsCaFilePath "$SSL_CERT_FILE"
fi
