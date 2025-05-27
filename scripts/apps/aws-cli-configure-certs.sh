#!/bin/bash

if command -v aws >/dev/null 2>&1; then
    echo "Updating AWS-CLI variable(s)."
    export AWS_CA_BUNDLE="$SSL_CERT_FILE"
fi
