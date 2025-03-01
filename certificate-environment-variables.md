See also applicable [Proxy](proxy-environment-variables.md) environment variables.

# Certificate Environment Variables

| Variable name | Use | Linux Settings | Windows Settings |
|---|:---:|---|---|
| ADDITIONAL_CA_CERT_BUNDLE[^gitlab_dps] | GitLab Dependency Scanning | $SSL_CERT_FILE | %SSL_CERT_FILE% |
| AWS_CA_BUNDLE | [AWS CLI](application-proxy-settings.md#aws_cli) | $SSL_CERT_FILE | %SSL_CERT_FILE% |
| CA_CERT[^suse] | SUSE Manager | $SSL_CERT_FILE | |
| CA_CERTS_FILE[^libcloud] | Apache Libcloud | $SSL_CERT_FILE | %SSL_CERT_FILE% |
| CARGO_HTTP_CAINFO[^cargo] | Cargo | $SSL_CERT_FILE | %SSL_CERT_FILE% |
| COMPOSER_CAFILE | [Composer](package-manager-settings.md#composer) | $SSL_CERT_FILE | %SSL_CERT_FILE% |
| CONAN_CACERT_PATH[^conan] | Conan | $SSL_CERT_FILE | %SSL_CERT_FILE% |
| CURL_CA_BUNDLE[^curl] | curl | $SSL_CA_CERT | %SSL_CA_CERT% |
| DENO_CERT[^deno] | Deno | $SSL_CERT_FILE | %SSL_CERT_FILE% |
| DENO_TLS_CA_STORE[^deno] | Deno | `system` | `system` |
| ELASTICSEARCH_CA[^elasticsearch] | ElasticSearch | $SSL_CERT_FILE | %SSL_CERT_FILE% |
| GIT_SSL_CAINFO[^git_cainfo] | Git | $SSL_CERT_FILE | %SSL_CERT_FILE% |
| GIT_SSL_CAPATH[^git_capath] | Git | $SSL_CERT_DIR | %SSL_CERT_DIR% |
| GITLAB_CERTIFICATE_PATH[^megalinter] | MegaLinter | $SSL_CERT_FILE | %SSL_CERT_FILE% |
| GRYPE_DB_CA_CERT[^grype] | Grype | $SSL_CA_CERT | %SSL_CA_CERT% |
| HEX_CACERTS_PATH[^hex] | Hex | $SSL_CERT_FILE | %SSL_CERT_FILE% |
| KIBANA_CA[^elasticsearch] | Kibana | $SSL_CERT_FILE | %SSL_CERT_FILE% |
| MAVEN_OPTS[^maven] | Maven | <pre lang="bash">-Djavax.net.ssl.trustStore=$SSL_KEYSTORE_FILE -Djavax.net.ssl.trustStorePassword={Password}</pre> | <pre lang="bash">-Djavax.net.ssl.trustStore=%SSL_KEYSTORE_FILE% -Djavax.net.ssl.trustStorePassword={Password}</pre> |
| NEXTCLADE_EXTRA_CA_CERTS[^nextclade_cli] | Nextclade CLI | $SSL_CERT_FILE | %SSL_CERT_FILE% |
| NIX_SSL_CERT_FILE[^nix] | NixOS | $SSL_CERT_FILE | |
| NODE_EXTRA_CA_CERTS[^node] | Node | $SSL_CERT_FILE | %SSL_CERT_FILE% |
| PIP_CERT[^pip] | Python | $SSL_CERT_FILE | %SSL_CERT_FILE% |
| REGISTRY_CA_PATH[^tanzu] | Tanzu Application Platform | $SSL_CA_CERT | %SSL_CA_CERT% |
| REQUESTS_CA_BUNDLE[^py_requests] | Python | $SSL_CERT_FILE | %SSL_CERT_FILE% |
| SLY_EXTRA_CA_CERTS | [Supervisely](application-proxy-settings.md#supervisely) | $SSL_CERT_FILE | %SSL_CERT_FILE% |
| SSL_CA_CERT | standard | $SSL_CERT_DIR/mycert.crt | %SSL_CERT_DIR%\mycert.crt |
| SSL_CERT_DIR[^openssl] | OpenSSL | See [Image Distro Certs](image-os-distro-settings.md) for location. | |
| SSL_CERT_FILE[^openssl] | OpenSSL | $SSL_CERT_DIR/mycert.pem | %SSL_CERT_DIR%\mycert.pem |
| SYSTEM_CERTIFICATE_PATH[^haskell] | Haskell Stack | $SSL_CERT_DIR | %SSL_CERT_DIR% |
| TEMPORAL_TLS_CA[^temporal] | Temporal | $SSL_CERT_FILE | %SSL_CERT_FILE% |
| TENSORSTORE_CA_BUNDLE[^tensorstore] | TensorStore | $SSL_CERT_FILE | %SSL_CERT_FILE% |
| TENSORSTORE_CA_PATH[^tensorstore] | TensorStore | $SSL_CERT_DIR | %SSL_CERT_DIR% |
| TLS_CA_FILE[^mongo] | MongoDB | $SSL_CERT_FILE | %SSL_CERT_FILE% |
| TWINE_CERT[^twine] | Twine | $SSL_CERT_FILE | %SSL_CERT_FILE% |

# Optional Suggested
| Variable name | Use | Linux Settings | Windows Settings |
|---|:---:|---|---|
| SSL_KEYSTORE_FILE | Custom | $SSL_CERT_DIR/myjks.keystore | %SSL_CERT_DIR%\myjks.keystore |

[^gitlab_dps]: https://docs.gitlab.com/ee/user/application_security/dependency_scanning/#global-analyzer-settings
[^suse]: https://documentation.suse.com/suma/4.3/en/suse-manager/administration/ssl-certs-mported.html#_import_certificates_for_new_installations
[^cargo]: https://doc.rust-lang.org/cargo/reference/config.html#httpcainfo
[^conan]: https://docs.conan.io/1/reference/env_vars.html#conan-cacert-path
[^curl]: https://curl.se/docs/sslcerts.html
[^deno]: https://docs.deno.com/runtime/reference/env_variables/#std%2Fcli
[^elasticsearch]: https://www.elastic.co/guide/en/fleet/7.17/agent-environment-variables.html
[^git_cainfo]: https://git-scm.com/docs/git-config#Documentation/git-config.txt-httpsslCAInfo
[^git_capath]: https://git-scm.com/docs/git-config#Documentation/git-config.txt-httpsslCAPath
[^grype]: https://github.com/anchore/grype/issues/653
[^haskell]: https://github.com/commercialhaskell/stack/blob/123622ab2a2b90d80fc617791b57e486aef725a1/doc/faq.md?plain=1#L218
[^hex]: https://hexdocs.pm/hex/Mix.Tasks.Hex.Config.html
[^libcloud]: https://libcloud.readthedocs.io/en/latest/other/ssl-certificate-validation.html#using-a-custom-ca-certificate
[^maven]: https://maven.apache.org/guides/mini/guide-repository-ssl.html
[^megalinter]: https://megalinter.io/v5/reporters/GitlabCommentReporter/
[^mongo]: https://www.mongodb.com/docs/languages/cpp/cpp-driver/current/connect/tls/#specify-a-ca-file
[^nextclade_cli]: https://docs.nextstrain.org/projects/nextclade/en/3.9.0/user/nextclade-cli/reference.html#nextclade-dataset-get
[^nix]: https://wiki.nixos.org/wiki/Enterprise
[^node]: https://nodejs.org/docs/latest-v4.x/api/cli.html#cli_node_extra_ca_certs_file
[^pip]: https://pip.pypa.io/en/latest/topics/https-certificates/
[^py_requests]: https://requests.readthedocs.io/en/latest/user/advanced/#proxies
[^openssl]: https://docs.openssl.org/master/man3/SSL_CTX_load_verify_locations/#description
[^tanzu]: https://github.com/halkyonio/tap
[^temporal]: https://docs.temporal.io/references/web-ui-environment-variables
[^tensorstore]: https://google.github.io/tensorstore/environment.html#tls-ca-certificates
[^twine]: https://twine.readthedocs.io/en/stable/#environment-variables
