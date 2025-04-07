# Image/OS/Distro Information

This is a list of ways to determine what image/distro/os you are possibly dealing with.

| OS/Distro | Image Base | Test Image[^test_image] | Test Image Size[^image_size] | Commands |
|---|:---:|---|:---:|---|
| Linux | | | | <code class="language-bash">cat /etc/*verion</code> |
| Linux | | | | <code class="language-bash">uname -a</code> |
| Linux | | | | <code class="language-bash">cat /etc/*elease</code> |
| Linux | | | | <code class="language-bash">hostnamectl</code> |
| Windows | | | | <code class="language-batchfile">systeminfo</code> |

## See also

* [How to identify Linux Distro](https://unix.stackexchange.com/a/35190/589264)

## References

[^test_image]: [Test Image Disclaimer](../README.md#test-image)
[^image_size]: [Test Image Size Disclaimer](../README.md#test-image-size)
