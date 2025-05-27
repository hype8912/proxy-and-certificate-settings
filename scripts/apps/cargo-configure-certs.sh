#!/bin/bash

if command -v cargo >/dev/null 2>&1; then
    echo "Updating Cargo variable(s)."
    export CARGO_HTTP_CAINFO="$SSL_CERT_FILE"
fi
