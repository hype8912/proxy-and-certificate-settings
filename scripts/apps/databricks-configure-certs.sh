#!/bin/bash

cat << 'EOF' > /usr/local/share/ca-certificates/my-cert.crt
-----BEGIN CERTIFICATE-----
<first-custom-certificate-chain>
-----END CERTIFICATE-----
-----BEGIN CERTIFICATE-----
<second-custom-certificate-chain>
-----END CERTIFICATE-----
EOF

update-ca-certificates

SSL_CERT_FILE="/etc/ssl/certs/my-cert.pem"
JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:bin/java::")
JAVA_KEYSTORE="$JAVA_HOME/lib/security/cacerts"
target_keystore_pass="changeit"

CERTS=$(grep 'END CERTIFICATE' $SSL_CERT_FILE| wc -l)

# To process multiple certs with keytool, you need to extract
# each one from the PEM file and import it into the Java KeyStore.

for N in $(seq 0 $(($CERTS - 1))); do
  ALIAS="$(basename $SSL_CERT_FILE)-$N"
  echo "Adding to keystore with alias:$ALIAS"
  cat $SSL_CERT_FILE |
    awk "n==$N { print }; /END CERTIFICATE/ { n++ }" |
    keytool -noprompt -import -trustcacerts -alias $ALIAS -keystore $JAVA_KEYSTORE -storepass $target_keystore_pass
done

echo "export REQUESTS_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt" >> /databricks/spark/conf/spark-env.sh
echo "export SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt" >> /databricks/spark/conf/spark-env.sh