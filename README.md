# Proxy and Certificate Settings

[[_TOC_]]

## Overview

The repository contains a collection of information for running package managers, applications, operating systems, containers, and various distros behind a corporate firewall and proxy also known as a Man-in-the-Middle firewall.

The expectation is for this to be a one-stop location for developers to get all the proxy information they need for running applications behind a corporate firewall.

## Disclaimer

We do our best to test every single bit of information that is published in our private network behind a firewall, but we can't guarantee everything provided will work for every firewall.

## Test Image

Every attempt is made to find the recently updated docker images from known publishers, but some images are very old or published by individuals and should be used at your own risk. You can use tools like [Trivy](https://trivy.dev/latest/) to scan images for vulnerabilities.

## Test Image Size

Container and distro image sizes are approximate and mainly given for managing bandwidth when testing in a pipeline. Image sizes could change at any time.

## Documentation Structure

This repository is organized into several key files:

- **application-proxy-settings.md**: Settings for specific applications
- **certificate-environment-variables.md**: Certificate-related environment variables
- **package-manager-settings.md**: Settings for various package managers
- **proxy-environment-variables.md**: Proxy-related environment variables
- **image-os-distro-settings.md**: OS/distro-specific settings
- **scripts/**: Configuration scripts for automated setup

### Quick Start

For the most common scenario (Ubuntu + npm + Node.js):

1. Set proxy environment variables:

   ```bash
   export HTTP_PROXY="http://proxy.example.com:8080"
   export HTTPS_PROXY="http://proxy.example.com:8080"
   export NO_PROXY="localhost,127.0.0.1,.example.com"
   ```

2. Configure Node.js certificates:

   ```bash
   export NODE_EXTRA_CA_CERTS="/path/to/your/cert.pem"
   export NODE_TLS_REJECT_UNAUTHORIZED=1
   ```

3. Configure npm:

   ```bash
   npm config set proxy "$HTTP_PROXY"
   npm config set https-proxy "$HTTPS_PROXY"
   npm config set noproxy "$NO_PROXY"
   ```
