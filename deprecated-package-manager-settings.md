# Deprecated Package Managers

If no information is provided in the `Proxy Instructions` or `Certificate Instructions` means they use the typical OS or Distro environment values and will work just by setting those value(s).

| Package manager | Name | Image Base | Test Image[^test_image] | Test Image Size[^test_image] | Proxy Instructions | Certificate Instructions | Alternative |
| :---: | :---: | :---: | --- | :---: | --- | --- | --- |
| apm | Atom Package Manager[^apm] | | | | <code class="language-bash">apm config set https-proxy "$HTTPS_PROXY"</code>[^apm_proxy] | | |
| appget | AppGet[^appget] | | | | | | [winget](package-manager-settings.md#winget) |
| apt-rpm | APT-RPM[^apt4rpm] | | | | | | [smart](#smart) |
| clj | Clj[^clj] (Clojure) | | | | | | [lein](package-manager-settings.md#lein) |
| cljr | Cljr[^cljr] (Clojure) | | | | | | [lein](package-manager-settings.md#lein) |
| ipkg | Itsy Package Manager[^ipkg] | | | | | | [opkg](package-manager-settings.md#opkg) |
| just-install | Just Install[^just-install] | | | | | | [winget](package-manager-settings.md#winget) |
| necro | Necropolis[^necro] (Cobol) | | | | | | |
| rye | Rye (python)[^rye] | Debian | jfxs/rye:latest | 215MB | | See [pip](package-manager-settings.md#pip). | [uv](package-manager-settings.md#uv) |
| smart<a name="smart"></a> | Smart Package Manager[^smart] | | | | | | |
| upm | Unity Package Manger CLI | | | | | | [openupm](package-manager-settings.md#openupm) |

[^apm_proxy]: https://github.com/atom/apm?tab=readme-ov-file#using-a-proxy
[^apm]: https://github.com/atom/apm
[^appget]: https://github.com/appget/appget
[^apt4rpm]: https://apt4rpm.sourceforge.net
[^clj]: https://github.com/ghoseb/clj
[^cljr]: https://github.com/liebke/cljr
[^ipkg]: https://wiki.qnap.com/wiki/Optware_IPKG
[^just-install]: https://github.com/just-install/just-install
[^necro]: https://github.com/Avuxo/Necropolis
[^rye]: https://github.com/astral-sh/rye
[^smart]: https://github.com/smartpm/smart
[^test_image]: [Test Image Disclaimer](README.md#test-image)
