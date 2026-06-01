#!/bin/sh

if command -v uv >/dev/null 2>&1; then
    echo "Updating UV variable(s)."
    export UV_NATIVE_TLS="true"
fi
