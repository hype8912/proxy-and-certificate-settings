#!/bin/bash

if command -v curl >/dev/null 2>&1 && [ -z "$CURL_CA_BUNDLE" ]; then
    echo "Updating Curl variable(s)."
    export CURL_CA_BUNDLE="$SSL_CA_CERT"
fi
