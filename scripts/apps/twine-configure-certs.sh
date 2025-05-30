#!/bin/bash

if command -v twine >/dev/null 2>&1; then
    echo "Updating Twine variable(s)."
    export TWINE_CERT="$SSL_CERT_FILE"
fi
