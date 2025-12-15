#!/bin/sh

#######################################
# Sets up SSL certificate environment variables and copies certificate files to a specified directory.
# Globals:
#   SSL_CERT_DIR: Set to the provided directory path.
#   SSL_CERT_FILE: Set to the path of the PEM certificate file.
#   SSL_CA_CERT: Set to the path of the CA certificate file.
#   PIP_CERT: Set to the same value as SSL_CERT_FILE.
#   REQUESTS_CA_BUNDLE: Set to the same value as SSL_CERT_FILE.
#   CURL_CA_BUNDLE: Set to the same value as SSL_CA_CERT.
#   GITLAB_CERTIFICATE_PATH: Set to the same value as SSL_CA_CERT.
#   GRYPE_DB_CA_CERT: Set to the same value as SSL_CA_CERT.
#   LOCAL_CERTS_PEM_NAME: Read for certificate name.
#   LOCAL_CERTS_CRT_NAME: Read for certificate name.
#   certs_url: The URL for downloading the certificates file.
# Arguments:
#   $1: Directory path where certificates will be stored.
# Outputs:
#   Progress messages and error messages if certificate files are missing.
# Returns:
#   0 (success)
#######################################
configure_ssl_variables_and_certs() {
    export SSL_CERT_DIR="$1"
    if [ ! -d "$SSL_CERT_DIR" ]; then
        mkdir -p "$SSL_CERT_DIR"
    fi

    temp_ssl_cert_file="$SSL_CERT_DIR/$LOCAL_CERTS_PEM_NAME"
    temp_ssl_ca_cert="$SSL_CERT_DIR/$LOCAL_CERTS_CRT_NAME"

    export SSL_CERT_FILE="$temp_ssl_cert_file"
    echo "Downloading $LOCAL_CERTS_PEM_NAME CA Certificates."
    download_file "$certs_url" "$SSL_CERT_FILE"

    export SSL_CA_CERT="$temp_ssl_ca_cert"
    if [ -f "$SSL_CERT_FILE" ]; then
        export PIP_CERT="$SSL_CERT_FILE"
        export REQUESTS_CA_BUNDLE="$SSL_CERT_FILE"

        chmod 644 "$SSL_CERT_FILE"

        if command -v zypper >/dev/null 2>&1; then
            cp "$SSL_CERT_FILE" "$SSL_CA_CERT"
        else
            ln -s -f "$SSL_CERT_FILE" "$SSL_CA_CERT"
        fi
    else
        echo "SSL_CERT_FILE missing. $SSL_CERT_FILE"
    fi

    if [ -f "$SSL_CA_CERT" ]; then
        export CURL_CA_BUNDLE="$SSL_CA_CERT"
        export GITLAB_CERTIFICATE_PATH="$SSL_CA_CERT"
        export GRYPE_DB_CA_CERT="$SSL_CA_CERT"
    else
        echo "SSL_CA_CERT missing. $SSL_CA_CERT"
    fi

    return 0
}

#######################################
# Extracts and installs individual certificates using the Small Step CLI tool.
# Globals:
#   certs_tar_url: The URL for downloading the certificates file.
#   LOCAL_CERTS_TAR_NAME: Read for certificate tarball name.
# Arguments:
#   None
# Outputs:
#   Progress messages and error messages if required tools are missing.
# Returns:
#   None explicitly
#######################################
configure_individual_certs_with_step() {
    echo "Downloading $LOCAL_CERTS_TAR_NAME Certificates."
    download_file "$certs_tar_url" "/$LOCAL_CERTS_TAR_NAME"

    if [ -e "/$LOCAL_CERTS_TAR_NAME" ]; then
        if command -v tar >/dev/null 2>&1; then
            echo "Extracting $LOCAL_CERTS_TAR_NAME file."
            tar -xf "/$LOCAL_CERTS_TAR_NAME"

            if [ -d "Certificates" ]; then
                cd "Certificates" ||:

                if command -v find >/dev/null 2>&1; then
                    if command -v step >/dev/null 2>&1; then
                        find . -type f -exec step certificate install --all {} \;
                    elif command -v step-cli >/dev/null 2>&1; then
                        find . -type f -exec step-cli certificate install --all {} \;
                    else
                        echo "Small step package not installed."
                    fi

                    cd ".." && rm -r "Certificates" >/dev/null 2>&1
                else
                    echo "Findutils package not installed."
                fi
            fi
        else
            echo "Tar package not installed."
        fi
    fi
}

#######################################
# Downloads a file from a URL to a specified location.
# Globals:
#   CURL_CA_BUNDLE: Used to determine if curl should use the -k flag.
# Arguments:
#   $1: URL to download from.
#   $2: File path to save the downloaded content.
# Outputs:
#   Error message if no suitable download tool is available.
# Returns:
#   None explicitly
#######################################
download_file() {
    if command -v wget >/dev/null 2>&1; then
        wget --no-check-certificate -O "$2" "$1"
    elif command -v curl >/dev/null 2>&1; then
        if [ -n "${CURL_CA_BUNDLE}" ]; then
            curl -Lk "$1" -o "$2"
        else
            curl -L "$1" -o "$2"
        fi
    else
        echo "No download tool command (wget, curl) found, certificates may need manual configuration."
    fi
}

#######################################
# Updates the system's CA certificate store.
# Globals:
#   None
# Arguments:
#   None
# Outputs:
#   Progress messages and warning if no update mechanism is found.
# Returns:
#   None explicitly
#######################################
update_certificates() {
    echo "Updating ca-certificates."
    if command -v update-ca-trust >/dev/null 2>&1; then
        update-ca-trust extract
    elif command -v update-ca-certificates >/dev/null 2>&1; then
        update-ca-certificates
    elif command -v eopkg >/dev/null 2>&1; then
        c_rehash
        cat /etc/ssl/certs/*.0 > /etc/ssl/certs/ca-certificates.crt
    else
        echo "No certificate update command found, certificates may need manual configuration."
    fi
}

#######################################
# Updates repository URLs for end-of-life CentOS versions to use archive mirrors.
# Globals:
#   None
# Arguments:
#   None
# Outputs:
#   Progress messages when updating CentOS repository mirrors.
# Returns:
#   0 if not a Red Hat system (skips processing)
#######################################
centos_update_eol_repos() {
    if [ ! -f "/etc/redhat-release" ]; then
        return 0
    fi

    if grep -q "^CentOS release 6" "/etc/redhat-release"; then
        echo "Updating CentOS 6 repository mirrors."
        # shellcheck disable=SC2016
        sed -i -e '/^mirrorlist=/d' -e 's;^#\(baseurl=\)http://mirror\.centos\.org/centos/\$releasever/\(.*\)$;\1http://archive.kernel.org/centos-vault/centos/6/\2;' "/etc/yum.repos.d/CentOS-"*.repo
    fi

    if grep -q "^CentOS Linux release 7" "/etc/redhat-release"; then
        echo "Updating CentOS 7 repository mirrors."
        # shellcheck disable=SC2016
        sed -i -e '/^mirrorlist=/d' -e 's;^#\(baseurl=\)http://mirror\.centos\.org/centos/\$releasever/\(.*\)$;\1http://archive.kernel.org/centos-vault/centos/7/\2;' "/etc/yum.repos.d/CentOS-"*.repo
    fi

    if grep -q "^CentOS Linux release 8" "/etc/redhat-release"; then
        echo "Updating CentOS 8 repository mirrors."
        # shellcheck disable=SC2016
        sed -i -e '/^mirrorlist=/d' -e 's;^#\(baseurl=\)http://mirror\.centos\.org/centos/\$releasever/\(.*\)$;\1http://archive.kernel.org/centos-vault/centos/8/\2;' "/etc/yum.repos.d/CentOS-"*.repo
    fi
}

#######################################
# Updates repository URLs for Debian Buster to use archive mirrors.
# Globals:
#   None
# Arguments:
#   $1: Path to the sources list file to modify.
# Outputs:
#   None
# Returns:
#   None explicitly
#######################################
debian_update_eol_repos() {
    if [ -f "/etc/os-release" ] && grep -q "VERSION_CODENAME=buster" "/etc/os-release"; then
        if [ -w "$1" ]; then
            sed -i -e "s;^deb http://deb.debian.org;deb http://archive.debian.org;g" "$1"  # DevSkim: ignore DS137138
            sed -i -e "s;^deb http://security.debian.org;deb http://archive.debian.org;g" "$1"  # DevSkim: ignore DS137138
        fi
    fi
}

#######################################
# Updates repository URLs for end-of-life Ubuntu versions to use old-releases mirrors.
# Globals:
#   None
# Arguments:
#   $1: Path to the sources list file to modify.
# Outputs:
#   None
# Returns:
#   None explicitly
#######################################
ubuntu_update_eol_repos() {
    if [ -f "/etc/os-release" ] && grep -q "VERSION_CODENAME=oracular" "/etc/os-release"; then
        if [ -w "$1" ]; then
            sed -i -e "s;http://archive.ubuntu.com/ubuntu;http://old-releases.ubuntu.com/ubuntu;g" "$1"  # DevSkim: ignore DS137138
            sed -i -e "s;http://security.ubuntu.com/ubuntu;http://old-releases.ubuntu.com/ubuntu;g" "$1"  # DevSkim: ignore DS137138
        fi
    fi
}
