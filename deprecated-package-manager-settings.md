# Deprecated Package Managers

If no information is provide in the `Proxy Instructions` or `Certificate Instructions` means they use the typical OS or Distro environment values and will work just by setting those value.

| Package manager | Name | Image Base | Test Image[^test_image] | Test Image Size[^test_image] | Proxy Instructions | Certificate Instructions | Alternative |
|:---:|:---:|:---:|---|:---:|---|---|---|
| apm | Atom Package Manager[^apm] | | | | <code class="language-bash">apm config set https-proxy "$HTTPS_PROXY"</code>[^apm_proxy] | | |
| clj | Clj[^clj] (Clojure) | | | | | | [lein](package-manager-settings.md#lein) |
| cljr | Cljr[^cljr] (Clojure) | | | | | | [lein](package-manager-settings.md#lein) |
| ipkg | Itsy Package Manager[^ipkg] | | | | | | [opkg](package-manager-settings.md#opkg) |
| necro | Necropolis[^necro] (Cobol) | | | | | | |
| upm | Unity Package Manger CLI | | | | | | [openupm](package-manager-settings.md#openupm) |

[^test_image]: [Test Image Disclaimer](README.md#test-image)
[^apm]: https://github.com/atom/apm
[^apm_proxy]: https://github.com/atom/apm?tab=readme-ov-file#using-a-proxy
[^clj]: https://github.com/ghoseb/clj
[^cljr]: https://github.com/liebke/cljr
[^ipkg]: https://wiki.qnap.com/wiki/Optware_IPKG
[^necro]: https://github.com/Avuxo/Necropolis
