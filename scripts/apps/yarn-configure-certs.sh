#!/bin/bash

if command -v yarn >/dev/null 2>&1; then
    echo "Updating Yarn configuration"
    # caFilePath was changed to httpsCaFilePath in Yarn v4.0
    yarn config set caFilePath "$SSL_CERT_FILE" ||:
    yarn config set httpsCaFilePath "$SSL_CERT_FILE"
fi
