#!/bin/sh

if command -v yarn >/dev/null 2>&1; then
    echo "Updating Yarn configuration"
    # cafile for yarn 1.0
    # caFilePath for yarn 2.0/3.0 
    # httpsCaFilePath for Yarn v4.0+
    yarn config set cafile "$SSL_CERT_FILE" ||:
    yarn config set caFilePath "$SSL_CERT_FILE" ||:
    yarn config set httpsCaFilePath "$SSL_CERT_FILE"
fi
