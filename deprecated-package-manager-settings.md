# Deprecated Package Managers

If no information is provide in the `Proxy Instructions` or `Certificate Instructions` means they use the typical OS or Distro environment values and will work just by setting those value.

| Package manager | Name | Image Base | Test Image[^test_image] | Test Image Size[^image_size] | Proxy Instructions | Certificate Instructions | Alternative |
|:---:|:---:|:---:|---|:---:|---|---|---|
| clj | Clj[^clj] (Clojure) | | | | | | [lein](https://gist.github.com/hype8912/c61c5d62548ccdad95293c42111b8e8a#lein) |
| cljr | Cljr[^cljr] (Clojure) | | | | | | [lein](https://gist.github.com/hype8912/c61c5d62548ccdad95293c42111b8e8a#lein) |
| necro | Necropolis[^necro] (Cobol) | | | | | | |

[^test_image]: Every attempt is made to find the recently updated images from known publishers but some images are very old or published by individuals and should be used at your own risk.
[^image_size]: `Test Image Size` are approximate and mainly given for managing bandwidth when testing in a pipeline. Image sizes could change at any time.
[^clj]: https://github.com/ghoseb/clj
[^cljr]: https://github.com/liebke/cljr
[^necro]: https://github.com/Avuxo/Necropolis
