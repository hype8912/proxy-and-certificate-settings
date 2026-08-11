# Proxy and Certificate Settings

[[_TOC_]]

## Overview

Developers working behind a corporate firewall or a Man-in-the-Middle (MITM) TLS-inspecting proxy constantly hit the same wall: a package manager, CLI tool, or application fails to connect or throws a certificate validation error, and there's no single place that explains which proxy variable or certificate setting it actually needs.

This repository is a reference collection of proxy and certificate configuration information for package managers, applications, operating systems/distros, and containers, so you can quickly look up the right environment variable, config file, or command instead of re-discovering it from scratch every time.

It's aimed at developers, DevOps/platform engineers, and anyone building Docker images or CI/CD pipelines that need to work behind a corporate proxy and trust a custom/internal CA certificate.

## Disclaimer

We do our best to test every single bit of information that is published in our private network behind a firewall, but we can't guarantee everything provided will work for every firewall.

## Test Image

Every attempt is made to find the recently updated docker images from known publishers, but some images are very old or published by individuals and should be used at your own risk. You can use tools like [Trivy](https://trivy.dev/latest/) to scan images for vulnerabilities.

## Test Image Size

Container and distro image sizes are approximate and mainly given for managing bandwidth when testing in a pipeline. Image sizes could change at any time.

## Documentation Structure

This repository is organized into several key files and folders:

- **proxy-environment-variables.md**: Proxy-related environment variables (standard and application-specific), with Linux/Windows equivalents
- **certificate-environment-variables.md**: Certificate-related environment variables (standard and application-specific), with Linux/Windows equivalents
- **image-os-distro-settings.md**: OS/distro-specific certificate storage locations and update commands
- **package-manager-settings.md**: Proxy and certificate settings for currently supported/tested package managers, plus lists of package managers that still need research (`Further Research Package Managers`) and a link to [deprecated-package-manager-settings.md](deprecated-package-manager-settings.md)
- **application-proxy-settings.md**: Proxy and certificate settings for specific applications and services (Git, Docker, GitLab Runner, VS Code, etc.)
- **untested-package-managers.md**: A running list of package managers that are known to exist but haven't been tested/documented yet
- **scripts/**: Shell scripts that automate certificate configuration
  - `common-functions.sh`: Shared helper functions used by the OS-specific scripts below
  - Per-OS/distro scripts (`alpine/`, `arch/`, `debian/`, `gentoo/`, `nixos/`, `redhat/`, `slackware/`, `solus/`, `suse/`, `busybox/`, `darwin/`): download and install a company CA certificate for that OS's trust store
  - `apps/`: per-application scripts (`cargo`, `conda`, `node`, `python`, `java`, etc.) that export the relevant certificate environment variable(s) once a cert is in place
  - `identify-image.sh`, `find-image-tags.sh`, `list-pm.sh`: diagnostic helpers for identifying an image's OS, finding matching image tags/digests, and checking which package managers are installed
- **docker/**: Example Dockerfiles (Homebrew, OpenUPM, Twine) used to build/verify some of the test images referenced throughout the docs
- **other/**: Supplementary reference material that goes beyond proxy/certificate settings, including exhaustive catalogs of [OS/distro → package manager](other/os-to-package-managers.md) and [programming language → package manager](other/programming-languages-to-package-managers.md) mappings, [meta package managers](other/meta-package-managers.md), [Red Hat family image/version info](other/redhat-image-distros.md), and general [notes](other/notes.md)

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
   ```

3. Configure npm:

   ```bash
   npm config set proxy "$HTTP_PROXY"
   npm config set https-proxy "$HTTPS_PROXY"
   npm config set noproxy "$NO_PROXY"
   ```

For anything not covered by this example, start with [image-os-distro-settings.md](image-os-distro-settings.md) to find where your OS/distro stores CA certificates, then check [package-manager-settings.md](package-manager-settings.md) and [application-proxy-settings.md](application-proxy-settings.md) for the specific proxy/certificate variables that tool needs.

## Contributing

When adding new information, please follow the existing conventions:

- Use the `Test Image`/`Test Image Size` columns only when you've actually verified against a real image; leave them blank otherwise rather than guessing.
- Add a footnote (`[^some_ref]`) linking to the official documentation for any new variable, command, or setting.
- If no `Proxy Instructions`/`Certificate Instructions` are given for a package manager, it means the standard OS/distro-level certificate and proxy settings apply.
- Package managers/applications that need more research belong in `Further Research Package Managers` (in [package-manager-settings.md](package-manager-settings.md)) or [untested-package-managers.md](untested-package-managers.md) until they're verified.

## License

This project is licensed under the [MIT License](LICENSE).
