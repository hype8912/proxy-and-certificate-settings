# Image/OS/Distro Information

This is a list of ways to determine what image/distro/os you are possibly dealing with.

| OS/Distro | Image Base | Test Image[^test_image] | Test Image Size[^test_image] | Commands |
| --- | :---: | --- | :---: | --- |
| Linux | | | | <code class="language-bash">cat /etc/*elease</code> |
| Linux | | | | <code class="language-bash">cat /etc/*version</code> |
| Linux | | | | <code class="language-bash">cat /proc/version</code> |
| Linux | | | | <code class="language-bash">hostname</code> |
| Linux | | | | <code class="language-bash">hostnamectl</code> |
| Linux | | | | <code class="language-bash">ls --help 2>&1 \| head -1</code> |
| Linux | | | | <code class="language-bash">uname -a</code> |
| Linux | | | | <code class="language-bash">uname -m</code> |
| Windows | | | | <code class="language-batchfile">systeminfo</code> |

## See also

* [How to identify Linux Distro](https://unix.stackexchange.com/a/35190/589264)

## References

[^test_image]: [Test Image Disclaimer](../README.md#test-image)
