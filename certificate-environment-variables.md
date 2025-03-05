See also applicable [Proxy](proxy-environment-variables.md) environment variables.

# Certificate Environment Variables

| Variable name | Use | Linux Settings | Windows Settings |
|---|:---:|---|---|
| ADDITIONAL_CA_CERT_BUNDLE[^gitlab_dps] | GitLab Dependency Scanning | $SSL_CERT_FILE | %SSL_CERT_FILE% |
| AWS_CA_BUNDLE | [AWS CLI](application-proxy-settings.md#aws_cli) | $SSL_CERT_FILE | %SSL_CERT_FILE% |
| CA_CERT[^suse] | SUSE Manager | $SSL_CERT_FILE | |
| CA_CERTS_FILE[^libcloud] | Apache Libcloud | $SSL_CERT_FILE | %SSL_CERT_FILE% |
| CARGO_HTTP_CAINFO | [Cargo](package-manager-settings.md#cargo) | $SSL_CERT_FILE | %SSL_CERT_FILE% |
| COMPOSER_CAFILE | [Composer](package-manager-settings.md#composer) | $SSL_CERT_FILE | %SSL_CERT_FILE% |
| CONAN_CACERT_PATH | [Conan](package-manager-settings.md#conan) | $SSL_CERT_FILE | %SSL_CERT_FILE% |
| CURL_CA_BUNDLE[^curl] | curl | $SSL_CA_CERT | %SSL_CA_CERT% |
| DENO_CERT | [Deno](package-manager-settings.md#deno) | $SSL_CERT_FILE | %SSL_CERT_FILE% |
| ELASTICSEARCH_CA[^elasticsearch] | ElasticSearch | $SSL_CERT_FILE | %SSL_CERT_FILE% |
| GIT_SSL_CAINFO | [Git](application-proxy-settings.md#git) | $SSL_CERT_FILE | %SSL_CERT_FILE% |
| GIT_SSL_CAPATH | [Git](application-proxy-settings.md#git) | $SSL_CERT_DIR | %SSL_CERT_DIR% |
| GITLAB_CERTIFICATE_PATH[^megalinter] | MegaLinter | $SSL_CERT_FILE | %SSL_CERT_FILE% |
| GRYPE_DB_CA_CERT | [Grype](application-proxy-settings.md#grype) | $SSL_CA_CERT | %SSL_CA_CERT% |
| HEX_CACERTS_PATH | [Hex](package-manager-settings.md#hex) | $SSL_CERT_FILE | %SSL_CERT_FILE% |
| KIBANA_CA[^elasticsearch] | Kibana | $SSL_CERT_FILE | %SSL_CERT_FILE% |
| MAVEN_OPTS | [Maven](package-manager-settings.md#mvn) | <code class="language-bash" style="white-space:pre-wrap;">-Djavax.net.ssl.trustStore=$SSL_KEYSTORE_FILE -Djavax.net.ssl.trustStorePassword={Password}</code> | <code class="language-batchfile" style="white-space:pre-wrap;">-Djavax.net.ssl.trustStore=%SSL_KEYSTORE_FILE% -Djavax.net.ssl.trustStorePassword={Password}</code> |
| NEXTCLADE_EXTRA_CA_CERTS[^nextclade_cli] | Nextclade CLI | $SSL_CERT_FILE | %SSL_CERT_FILE% |
| NIX_SSL_CERT_FILE | [NixOS](package-manager-settings.md#nix) | $SSL_CERT_FILE | |
| NODE_EXTRA_CA_CERTS | [Node](package-manager-settings.md#npm) | $SSL_CERT_FILE | %SSL_CERT_FILE% |
| PIP_CERT | [Python](package-manager-settings.md#pip) | $SSL_CERT_FILE | %SSL_CERT_FILE% |
| REGISTRY_CA_PATH[^tanzu] | Tanzu Application Platform | $SSL_CA_CERT | %SSL_CA_CERT% |
| REQUESTS_CA_BUNDLE[^py_requests] | Python | $SSL_CERT_FILE | %SSL_CERT_FILE% |
| SLY_EXTRA_CA_CERTS | [Supervisely](application-proxy-settings.md#supervisely) | $SSL_CERT_FILE | %SSL_CERT_FILE% |
| SSL_CA_CERT | standard | $SSL_CERT_DIR/mycert.crt | %SSL_CERT_DIR%\mycert.crt |
| SSL_CERT_DIR[^openssl] | OpenSSL | See [Image Distro Certs](image-os-distro-settings.md) for location. | |
| SSL_CERT_FILE[^openssl] | OpenSSL | $SSL_CERT_DIR/mycert.pem | %SSL_CERT_DIR%\mycert.pem |
| SYSTEM_CERTIFICATE_PATH | [Haskell Stack](package-manager-settings.md#stack) | $SSL_CERT_DIR | %SSL_CERT_DIR% |
| TEMPORAL_TLS_CA[^temporal] | Temporal | $SSL_CERT_FILE | %SSL_CERT_FILE% |
| TENSORSTORE_CA_BUNDLE[^tensorstore] | TensorStore | $SSL_CERT_FILE | %SSL_CERT_FILE% |
| TENSORSTORE_CA_PATH[^tensorstore] | TensorStore | $SSL_CERT_DIR | %SSL_CERT_DIR% |
| TLS_CA_FILE[^mongo] | MongoDB | $SSL_CERT_FILE | %SSL_CERT_FILE% |
| TWINE_CERT | [Twine](package-manager-settings.md#twine) | $SSL_CERT_FILE | %SSL_CERT_FILE% |

# Optional Suggested
| Variable name | Use | Linux Settings | Windows Settings |
|---|:---:|---|---|
| SSL_KEYSTORE_FILE | Custom | $SSL_CERT_DIR/myjks.keystore | %SSL_CERT_DIR%\myjks.keystore |

[^gitlab_dps]: https://docs.gitlab.com/ee/user/application_security/dependency_scanning/#global-analyzer-settings
[^suse]: https://documentation.suse.com/suma/4.3/en/suse-manager/administration/ssl-certs-mported.html#_import_certificates_for_new_installations
[^curl]: https://curl.se/docs/sslcerts.html
[^elasticsearch]: https://www.elastic.co/guide/en/fleet/7.17/agent-environment-variables.html
[^libcloud]: https://libcloud.readthedocs.io/en/latest/other/ssl-certificate-validation.html#using-a-custom-ca-certificate
[^megalinter]: https://megalinter.io/v5/reporters/GitlabCommentReporter/
[^mongo]: https://www.mongodb.com/docs/languages/cpp/cpp-driver/current/connect/tls/#specify-a-ca-file
[^nextclade_cli]: https://docs.nextstrain.org/projects/nextclade/en/3.9.0/user/nextclade-cli/reference.html#nextclade-dataset-get
[^py_requests]: https://requests.readthedocs.io/en/latest/user/advanced/#proxies
[^openssl]: https://docs.openssl.org/master/man3/SSL_CTX_load_verify_locations/#description
[^tanzu]: https://github.com/halkyonio/tap
[^temporal]: https://docs.temporal.io/references/web-ui-environment-variables
[^tensorstore]: https://google.github.io/tensorstore/environment.html#tls-ca-certificates
