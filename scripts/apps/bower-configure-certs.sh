#!/bin/bash

if command -v bower >/dev/null 2>&1; then
    echo "Updating Bower variable(s)."
    export bower_ca="$SSL_CERT_FILE"
fi
