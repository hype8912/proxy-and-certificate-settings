#!/bin/bash

if command -v node >/dev/null 2>&1 && [ -z "$NODE_EXTRA_CA_CERTS" ]; then
    echo "Updating Node/npm variable(s)."
    export NODE_EXTRA_CA_CERTS="$SSL_CERT_FILE"
    export NODE_TLS_REJECT_UNAUTHORIZED=1
fi
