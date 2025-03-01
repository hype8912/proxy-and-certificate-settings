See also applicable [Certificate](certificate-environment-variables.md) environment variables.

# Proxy Environment Variables

| Variable name | Use | Linux Settings | Windows Settings |
|---|:---:|---|---|
| ALL_PROXY | standard | | |
| all_proxy | standard | $ALL_PROXY | %ALL_PROXY% |
| BASH_IT_HTTP_PROXY | [Bash-It](application-proxy-settings.md#bash_it) | $HTTP_PROXY | %HTTP_PROXY% |
| BASH_IT_HTTPS_PROXY | [Bash-It](application-proxy-settings.md#bash_it) | $HTTPS_PROXY | %HTTPS_PROXY% |
| BASH_IT_NO_PROXY | [Bash-It](application-proxy-settings.md#bash_it) | $NO_PROXY | %NO_PROXY% |
| CGI_HTTP_PROXY | [Composer](package-manager-settings.md#composer) | $HTTP_PROXY | %HTTP_PROXY% |
| CURLOPT_NOPROXY[^curl_npx] | libcurl | $NO_PROXY | %NO_PROXY% |
| CURLOPT_PROXY[^curl_px] | libcurl | $HTTP_PROXY | %HTTP_PROXY% |
| EC2_JVM_ARGS[^aws_cloudwatch] | AWS | <pre lang="bash" style="white-space:pre-wrap; max-width:276px;">-Dhttp.proxySet=true -Dhttp.proxyHost=$HTTP_PROXY_HOST -Dhttp.proxyPort=$HTTP_PROXY_PORT -Dhttps.proxyHost=$HTTPS_PROXY_HOST -Dhttps.proxyPort=$HTTPS_PROXY_PORT -Dhttp.nonProxyHosts=$NO_PROXY</pre> | <pre lang="bat" style="white-space:pre-wrap; max-width:276px;">-Dhttp.proxySet=true -Dhttp.proxyHost=%HTTP_PROXY_HOST% -Dhttp.proxyPort=%HTTP_PROXY_PORT% -Dhttps.proxyHost=%HTTPS_PROXY_HOST% -Dhttps.proxyPort=%HTTPS_PROXY_PORT% -Dhttp.nonProxyHosts=%NO_PROXY%</pre> |
| FTP_PROXY | standard | | |
| ftp_proxy | standard | $FTP_PROXY | %FTP_PROXY% |
| GLOBAL_AGENT_HTTP_PROXY[^npm] | npm - global agent | $HTTP_PROXY | %HTTP_PROXY% |
| GLOBAL_AGENT_HTTPS_PROXY[^npm] | npm - global agent | $HTTPS_PROXY | %HTTPS_PROXY% |
| GLOBAL_AGENT_NO_PROXY[^npm] | npm - global agent | $NO_PROXY | %NO_PROXY% |
| HTTP_PROXY | standard | $HTTP_PROXY_HOST:$HTTP_PROXY_PORT | %HTTP_PROXY_HOST%:%HTTP_PROXY_PORT% |
| http_proxy | standard | $HTTP_PROXY | %HTTP_PROXY% |
| HTTPS_PROXY | standard | $HTTPS_PROXY_HOST:$HTTPS_PROXY_PORT | %HTTPS_PROXY_HOST%:%HTTPS_PROXY_PORT% |
| https_proxy | standard | $HTTPS_PROXY | %HTTPS_PROXY% |
| NO_PROXY | standard | | |
| no_proxy | standard | $NO_PROXY | %NO_PROXY% |
| RSYNC_PROXY[^rsync] | rsync | | |
| rsync_proxy[^rsync] | rsync | $RSYNC_PROXY | %RSYNC_PROXY% |
| SERVICE_JVM_ARGS[^aws_cloudwatch] | AWS Cloudwatch | $EC2_JVM_ARGS | |
| SFTP_PROXY | standard | | |
| sftp_proxy | standard | $SFTP_PROXY | %SFTP_PROXY% |
| socks5_proxy | standard | | |
| ssh_proxy | standard | | |
| UNITY_NOPROXY[^unity] | Unity Engine | $NO_PROXY | %NO_PROXY% |
| VSCODE_PROXY_URI[^vscode_srv] | VS Code Server | $HTTP_PROXY | |

# Non-standard Suggested Variables

Using the below variables will make it easier when having to set the values for java based applications as shown above.

| Variable name | Use | Linux Settings | Windows Settings |
|---|:---:|---|---|
| HTTP_PROXY_AUTH | | $HTTP_PROXY_USER:$HTTP_PROXY_PASSWORD | %HTTP_PROXY_USER%:%HTTP_PROXY_PASSWORD% |
| HTTP_PROXY_HOST | Custom | | |
| HTTP_PROXY_PASSWORD | | | |
| HTTP_PROXY_PORT | Custom | | |
| HTTP_PROXY_USER | | | |
| HTTPS_PROXY_AUTH | | $HTTPS_PROXY_USER:$HTTPS_PROXY_PASSWORD | %HTTPS_PROXY_USER%:%HTTPS_PROXY_PASSWORD% |
| HTTPS_PROXY_HOST | Custom | | |
| HTTPS_PROXY_PASSWORD | | | |
| HTTPS_PROXY_PORT | Custom | | |
| HTTPS_PROXY_USER | | | |

# References

* https://about.gitlab.com/blog/2021/01/27/we-need-to-talk-no-proxy/?utm_medium=social&utm_source=twitter&utm_campaign=blog

[^curl_npx]: https://curl.se/libcurl/c/CURLOPT_NOPROXY.html
[^curl_px]: https://curl.se/libcurl/c/CURLOPT_PROXY.html
[^npm]: https://www.npmjs.com/package/global-agent
[^rsync]: https://ss64.com/bash/rsync.html
[^unity]: https://discussions.unity.com/t/difficulties-in-proxy-environment/774349
[^vscode_srv]: https://github.com/coder/code-server/blob/main/patches/proxy-uri.diff
[^aws_cloudwatch]: https://gist.github.com/atushi/5898322#file-how_to_use_the_cloudwatch_api_about_getting_the_jvm_info_with_proxy-sh
