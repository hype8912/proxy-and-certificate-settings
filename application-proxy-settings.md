# Application Specific Proxy and Certificate Settings

| Application | Name | Test Image[^test_image] | Test Image Size[^test_image] | Proxy Instructions | Certificate Instructions |
|:---:|:---:|---|:---:|---|---|
| | Apache Karaf | apache/karaf:latest | 121MB | | <code class="language-bash" style="white-space:pre-wrap;">export EXTRA_JAVA_OPTS="-Djavax.net.ssl.trustStore=$SSL_KEYSTORE_FILE -Djavax.net.ssl.trustStorePassword={Password}"</code> |
| aws<a name="aws_cli"></a> | AWS CLI | amazon/aws-cli:latest | 127MB | | <code class="language-bash">export AWS_CA_BUNDLE="$SSL_CERT_FILE"</code>[^aws_cli] |
| | Bash-It<a name="bash_it"></a> | ellerbrock/bash-it:latest | 19MB | <pre><code class="language-bash">export BASH_IT_HTTP_PROXY="$HTTP_PROXY"&#13;export BASH_IT_HTTPS_PROXY="$HTTPS_PROXY"&#13;export BASH_IT_NO_PROXY="$NO_PROXY"</code>[^bash_it]</pre> | |
| | Boto | demisto/boto3py3:1.0.0.2587407 | 43MB | | See [AWS CLI](#aws_cli) [^boto] |
| checkov<a name="checkov"></a> | Checkov[^checkov] | bridgecrew/checkov:latest | 173MB | <pre><code class="language-bash">export PROXY_URL="$HTTP_PROXY"</code></pre> | <pre><code class="language-bash">export BC_CA_BUNDLE="$SSL_CERT_FILE"&#13;export PROXY_CA_PATH="$SSL_CERT_FILE"</code></pre> |
| docker | Docker Service[^docker_service] | | | `/etc/systemd/system/docker.service.d/http-proxy.conf`<pre><code class="language-ini">[Service]&#13;Environment="HTTP_PROXY=$HTTP_PROXY"&#13;Environment="HTTPS_PROXY=$HTTPS_PROXY"&#13;Environment="NO_PROXY=$NO_PROXY"</code></pre>`~/.docker/config.json`<pre><code class="language-json">{&#13;  "proxies": {&#13;    "default": {&#13;      "httpProxy": "$HTTP_PROXY",&#13;      "httpsProxy": "$HTTPS_PROXY",&#13;      "noProxy": "$NO_PROXY"&#13;    }&#13;  }&#13;}</code></pre> | |
| git<br>git-lfs<a name="git"></a> | | alpine/git:latest | 32MB | | <pre><code class="language-bash">export GIT_SSL_CAINFO="$SSL_CERT_FILE"&#13;export GIT_SSL_CAPATH="$SSL_CERT_DIR"&#13;git config --global http.sslverify true&#13;git config --global http.sslbackend schannel</code>[^git_cainfo] [^git_capath]</pre>Windows-only:<br><code class="language-batchfile">git config --global credential.helper wincred</code><br><br>Mac-only:<br><code class="language-bash">git config --global credential.helper osxkeychain</code> |
| | GitLab Runner Service | gitlab/gitlab-runner:latest | 106MB | `/etc/systemd/system/gitlab-runner.service.d/http-proxy.conf`[^gitlab_runner_proxy_conf]<pre><code class="language-ini" style="white-space:pre-wrap;">[Service]&#13;Environment="HTTP_PROXY=$HTTP_PROXY"&#13;Environment="HTTPS_PROXY=$HTTPS_PROXY"&#13;Environment="NO_PROXY=$NO_PROXY"</code></pre>`/etc/gitlab-runner/config.toml`[^gitlab_runner_proxy_docker]<pre><code class="language-toml" style="white-space:pre-wrap;">[[runners]]&#13;pre_get_sources_script = "git config --global http.proxy $HTTP_PROXY; git config --global https.proxy $HTTPS_PROXY"&#13;environment = ["https_proxy=$HTTPS_PROXY", "http_proxy=$HTTP_PROXY", "HTTPS_PROXY=$HTTPS_PROXY", "HTTP_PROXY=$HTTP_PROXY"]</code></pre> | `/etc/gitlab-runner/config.toml`[^gitlab_runner]<pre><code class="language-toml" style="white-space:pre-wrap;">[[runners]]&#13;tls-ca-file = "$SSL_CERT_FILE"&#13;&#13;[runners.docker]&#13;volumes = ["/path/to-ca-cert-dir/ca.crt:/etc/gitlab-runner/certs/ca.crt:ro"]</code></pre>`.gitlab-ci.yml`<pre><code class="language-yaml">variables:&#13;  ADDITIONAL_CA_CERT_BUNDLE: "$SSL_CERT_FILE"</code></pre> |
| gcloud<a name="gcloud"></a> | Google Cloud SDK | | | | <code class="language-bash">gcloud config set core/custom_ca_certs_file "$SSL_CERT_FILE"</code>[^gcloud] |
| grype<a name="grype"></a> | | anchore/grype:latest | 22MB | | <code class="language-bash">export GRYPE_DB_CA_CERT="$SSL_CA_CERT"</code>[^grype] |
| hpm | DevEco OpenHarmony | | | <pre><code class="language-bash">hpm config set http_proxy $HTTP_PROXY&#13;hpm config set https_proxy $HTTPS_PROXY</code>[^hpm]</pre> | |
| java<a name="java"></a> | OpenJDK | openjdk:25-slim | 233MB | <code class="language-bash" style="white-space:pre-wrap;">export JAVA_OPTS="$JAVA_OPTS -Dhttp.proxyHost=$HTTP_PROXY_HOST -Dhttp.proxyPort=$HTTP_PROXY_PORT -Dhttps.proxyHost=$HTTPS_PROXY_HOST -Dhttps.proxyPort=$HTTPS_PROXY_PORT"</code> | Linux and Darwin:<br><code class="language-bash" style="white-space:pre-wrap;">keytool -importkeystore -srckeystore $SSL_KEYSTORE_FILE -destkeystore $JAVA_HOME/lib/security/cacerts</code><br><br>Windows:<br><code class="language-batchfile" style="white-space:pre-wrap;">keytool -importkeystore -srckeystore %SSL_KEYSTORE_FILE% -destkeystore %JAVA_HOME%\lib\security\cacerts</code> |
| k3s | K3s | | | `/etc/systemd/system/k3s.service.env`[^k3s_proxy]<pre><code class="language-text">HTTP_PROXY=$HTTP_PROXY&#13;HTTPS_PROXY=$HTTPS_PROXY&#13;NO_PROXY=$NO_PROXY</code></pre>`/etc/systemd/system/k3s-agent.service.env`<pre><code class="language-text">HTTP_PROXY=$HTTP_PROXY&#13;HTTPS_PROXY=$HTTPS_PROXY&#13;NO_PROXY=$NO_PROXY</code></pre> | |
| kaniko | Kaniko | gcr.io/kaniko-project/executor:debug | 39MB | | <code class="language-bash">cp -f "$SSL_CERT_FILE" "/kaniko/ssl/certs/ca-certificates.crt"</code> |
| | Microsoft Azure CLI | mcr.microsoft.com/azure-cli:latest | | | <code class="language-bash">export REQUESTS_CA_BUNDLE="$SSL_CERT_FILE"</code>[^azure_cli] |
| | minikube | | | | <code class="language-bash">cp "$SSL_CERT_FILE" "~/.minikube/files/etc/ssl/certs"&#13;minikube delete&#13;minikube start --embed-certs</code>[^minikube_cert] |
| | .Net Framework Application | | | `appname.exe.config` or `web.config`[^net_framework_proxy]<pre><code class="language-xml"> &lt;configuration&gt;&#13;  &lt;system.net&gt;&#13;    &lt;defaultProxy enabled="true" useDefaultCredentials="true"&gt;&#13;      &lt;proxy address="%HTTP_PROXY%" /&gt;&#13;    &lt;/defaultProxy&gt;&#13;  &lt;/system.net&gt;&#13;&lt;/configuration&gt;</code></pre> | |
| | Netbeans IDE | | | 1. Open Netbeans, go to **Tools** then **Options** menu item.<br>2. Click the **General** tab.<br>3. Select **Manual Proxy Settings**.<br>4. Set **Address** to "$HTTP_PROXY_HOST" and **Port** to "$HTTP_PROXY_PORT".| |
| | Periscope Authenticator | | | <pre><code class="language-bash" style="white-space:pre-wrap;">git config --global lfs.transfer.enablehrefrewrite true&#13;&#13;git config --global url."http://localhost:[Local Port]".insteadOf"[Git Host URL]"</code></pre> | |
| pio | PlatformIO Core | | | | <code class="language-bash">export REQUESTS_CA_BUNDLE="$SSL_CERT_FILE"</code>[^platformio_cert] |
| subscription-manager | RHEL Subscription Manager | redhat/ubi9:latest | 84MB | <code class="language-bash" style="white-space:pre-wrap;">subscription-manager config --server.proxy_hostname "$HTTP_PROXY_HOST" --server.proxy_port "$HTTP_PROXY_PORT" --server.no_proxy "$NO_PROXY"</code> | |
| svn | Subversion | elleflorio/svn-server:latest | 18MB | `~/.subversion/servers` or `%APPDATA%\Subversion\servers`[^svn]<pre><code class="language-ini">[global]&#13;http-proxy-host=$HTTP_PROXY_HOST&#13;http-proxy-port=$HTTP_PROXY_PORT</code></pre> | `~/.subversion/servers` or `%APPDATA%\Subversion\servers`<pre><code class="language-ini">[global]&#13;ssl-trust-default-ca=no&#13;ssl-authority-files=$SSL_CERT_FILE</code></pre> |
| <a name="supervisely"></a> | Supervisely | | | | <pre><code class="language-bash">export REQUESTS_CA_BUNDLE="$SSL_CERT_FILE"&#13;export SLY_EXTRA_CA_CERTS="$SSL_CERT_FILE"</code>[^supervisely]</pre> |
| | TerraTeam | ghcr.io/terrateamio/terrat-oss:latest | | | <code class="language-yaml" style="white-space:pre-wrap;">hooks:&#13;  all:&#13;    pre:&#13;      - type: run&#13;        cmd: ['sh', '-c', 'echo "$SELF_SIGNED_CERT" > $SSL_CA_CERT && update-ca-certificates']</code>[^terrateamio] |
| vault | HashiCorp Vault | | | | <code class="language-bash">vault write /auth/jwt/config jwks_ca_pem=$SSL_CERT_FILE</code>[^vault_cert] |
| <a name="vs-code-server"></a> | VS Code Server | | | <code class="language-bash">export VSCODE_PROXY_URI="$HTTP_PROXY"</code>[^vscode_srv] | |
| wget | GNU Wget | alpine:latest | 4MB | | `/etc/wgetrc` or `~/.wgetrc` file[^wget]<pre><code class="language-properties">ca_certificate=$SSL_CERT_FILE&#13;ca_directory=$SSL_CERT_DIR</code></pre> |

## See also

+ [Adding Custom Certificate to an Application-Specific Trust Store](https://help.zscaler.com/zia/adding-custom-certificate-application-specific-trust-store)
+ [Add the certificate to applications](https://developers.cloudflare.com/cloudflare-one/connections/connect-devices/user-side-certificates/manual-deployment/#add-the-certificate-to-applications)

[^test_image]: [Test Image Disclaimer](README.md#test-image)
[^aws_cli]: https://docs.aws.amazon.com/cli/v1/userguide/cli-configure-envvars.html
[^azure_cli]: https://learn.microsoft.com/en-us/cli/azure/use-azure-cli-successfully-troubleshooting#work-behind-a-proxy
[^bash_it]: https://bash-it.readthedocs.io/en/latest/proxy_support/
[^boto]: https://boto3.amazonaws.com/v1/documentation/api/latest/guide/configuration.html
[^checkov]: https://www.checkov.io/2.Basics/CLI%20Command%20Reference.html#environment-variables
[^docker_service]: https://docs.docker.com/engine/daemon/proxy/#systemd-unit-file
[^gcloud]: https://cloud.google.com/sdk/docs/proxy-settings
[^git_cainfo]: https://git-scm.com/docs/git-config#Documentation/git-config.txt-httpsslCAInfo
[^git_capath]: https://git-scm.com/docs/git-config#Documentation/git-config.txt-httpsslCAPath
[^gitlab_runner_proxy_conf]: https://docs.gitlab.com/runner/configuration/proxy/#adding-proxy-variables-to-the-gitlab-runner-configuration
[^gitlab_runner_proxy_docker]: https://docs.gitlab.com/runner/configuration/proxy/#adding-the-proxy-to-the-docker-containers
[^gitlab_runner]: https://docs.gitlab.com/runner/configuration/tls-self-signed.html#trusting-the-certificate-for-the-other-cicd-stages
[^grype]: https://github.com/anchore/grype/issues/653#issuecomment-1059995685
[^hpm]: https://device.harmonyos.com/en/docs/documentation/guide/hpm_proxy-0000001074487706
[^k3s_proxy]: https://docs.k3s.io/advanced#configuring-an-http-proxy
[^minikube_cert]: https://minikube.sigs.k8s.io/docs/handbook/vpn_and_proxy/#x509-certificate-signed-by-unknown-authority
[^net_framework_proxy]: https://learn.microsoft.com/en-us/dotnet/framework/configure-apps/file-schema/network/proxy-element-network-settings
[^platformio_cert]: https://docs.platformio.org/en/latest/core/installation/proxy-configuration.html
[^supervisely]: https://developer.supervisely.com/app-development/advanced/custom-configuration/fixing-ssl-certificate-errors-in-supervisely
[^svn]: https://subversion.apache.org/faq.html#proxy
[^terrateamio]: https://docs.terrateam.io/security-and-compliance/self-signed-certificates/
[^vault_cert]: https://developer.hashicorp.com/vault/api-docs/auth/jwt#jwks_ca_pem
[^vscode_srv]: https://github.com/coder/code-server/blob/main/patches/proxy-uri.diff
[^wget]: https://www.gnu.org/software/wget/manual/html_node/Wgetrc-Commands.html#Wgetrc-Commands-1
