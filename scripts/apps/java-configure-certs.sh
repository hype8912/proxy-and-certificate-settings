#!/bin/bash

# Define external file sources
certs_keystore="http://mycompany.com/Company_jks.keystore"
certs_keystore_pass=""
target_keystore_pass="changeit"

# Define basic variables
LOCAL_CERTS_JKS_NAME="Company_jks.keystore"

if command -v java >/dev/null 2>&1; then
    echo "Updating Java keystore certificates."
    export SSL_KEYSTORE_FILE="$SSL_CERT_DIR/$LOCAL_CERTS_JKS_NAME"

    if [ -f "$JAVA_HOME/lib/security/cacerts" ]; then
        # Java 9 and later
        export JAVA_KEYSTORE="$JAVA_HOME/lib/security/cacerts"
    else
        # JDK 8 and earlier
        export JAVA_KEYSTORE="$JAVA_HOME/jre/lib/security/cacerts"
    fi

    echo "Downloading $LOCAL_CERTS_JKS_NAME CA keystore."
    if command -v curl >/dev/null 2>&1; then
        curl -L "$certs_keystore" -o "$SSL_KEYSTORE_FILE"
    else
        wget --proxy off -O "$SSL_KEYSTORE_FILE" "$certs_keystore"
    fi

    if [ -f "$SSL_KEYSTORE_FILE" ]; then
        if [ -f "$JAVA_HOME/bin/keytool" ]; then
            "$JAVA_HOME/bin/keytool" -importkeystore -srckeystore "$SSL_KEYSTORE_FILE" -srcstorepass "$certs_keystore_pass" -destkeystore "$JAVA_KEYSTORE" -deststorepass "$target_keystore_pass" -noprompt
        else
            # shellcheck disable=SC2016
            echo 'Java keytool not found. $JAVA_HOME/bin/keytool'
        fi
    else
        echo "Keystore download file not found. $SSL_KEYSTORE_FILE"
    fi

    echo "Java keystore configuration complete."
fi
