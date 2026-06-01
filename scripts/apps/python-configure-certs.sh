#!/bin/sh

if command -v python >/dev/null 2>&1; then
    echo "Updating Pip variable(s) if not already set."
    if [ -z "$PIP_CERT" ]; then
        export PIP_CERT="$SSL_CERT_FILE"
    fi

    if [ -z "$REQUESTS_CA_BUNDLE" ]; then
        export REQUESTS_CA_BUNDLE="$SSL_CERT_FILE"
    fi
fi
