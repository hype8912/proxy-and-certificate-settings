#!/bin/bash
# Tested on: macOS 13+

# Define external file sources
certs_url="http://mycompany.com/Company_CA.pem"

# Define basic variables
LOCAL_CERTS_CRT_NAME="Company_CA.crt"
LOCAL_CERTS_PEM_NAME="Company_CA.pem"

# Define OS variables
DARWIN_REPO_LOCAL_PATH="/Library/Keychains/System.keychain"
DARWIN_SSL_CERT_DIR="/etc/ssl"

# Begin configuration script
if [ "$(uname)" = "Darwin" ]; then
    echo "Darwin OS found."

    echo "Determining what packages are installed."
    if command -v curl >/dev/null 2>&1; then
        export SSL_CERT_DIR="$DARWIN_SSL_CERT_DIR"
        export SSL_CERT_FILE="$SSL_CERT_DIR/$LOCAL_CERTS_PEM_NAME"
        export SSL_CA_CERT="$SSL_CERT_DIR/$LOCAL_CERTS_CRT_NAME"

        echo "Downloading $LOCAL_CERTS_PEM_NAME CA Certificates."
        curl -Lk "$certs_url" -o "$SSL_CA_CERT"

        if [ -f "$SSL_CA_CERT" ]; then
            export CURL_CA_BUNDLE="$SSL_CA_CERT"
            export GITLAB_CERTIFICATE_PATH="$SSL_CA_CERT"
            export GRYPE_DB_CA_CERT="$SSL_CA_CERT"

            echo "Adding CA Certificates to $DARWIN_REPO_LOCAL_PATH"
            sudo security add-trusted-cert -d -r trustRoot -k "$DARWIN_REPO_LOCAL_PATH" "$SSL_CA_CERT"
            ln -s "$DARWIN_SSL_CERT_DIR/cert.pem" "$SSL_CERT_FILE"
        else
            echo "SSL_CA_CERT missing. $SSL_CA_CERT"
        fi

        if [ -f "$SSL_CERT_FILE" ]; then
            export PIP_CERT="$SSL_CERT_FILE"
            export REQUESTS_CA_BUNDLE="$SSL_CERT_FILE"
        else
            echo "SSL_CERT_FILE missing. $SSL_CERT_FILE"
        fi

        echo "Darwin certificate configuration complete."
    else
        echo "Curl not installed. Unable to finish certificate set up."
    fi
fi
