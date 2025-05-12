# Red Hat Linux Image Diagram

```mermaid
---
title: Red Hat Linux
---
flowchart LR
  fedora:28 ---> centos8:latest
  fedora:28 --> fedora:29
  fedora:29 --> fedora:30
  fedora:30 --> fedora:31
  fedora:31 --> fedora:32
  fedora:32 --> fedora:33
  fedora:33 --> fedora:34
  fedora:34 --> centos:stream9
  fedora:34 --> fedora:35
  fedora:35 --> fedora:36
  fedora:36 --> amazonlinux:latest["`amazonlinux:latest
  (2023)`"]
  fedora:36 --> fedora:37
  fedora:37 --> fedora:38
  fedora:38 --> fedora:39
  fedora:39 --> fedora:40
  centos8:latest --> almalinux:8
  centos8:latest --> eurolinux-8:latest
  centos8:latest --> rockylinux:8
  centos8:latest --> redhat/ubi8:latest
  centos8:latest --> oraclelinux:8
  centos8:latest ---> centos:stream8
  centos:stream8 --> centos:stream9
  centos:stream9 --> almalinux:9
  centos:stream9 --> eurolinux-9:latest
  centos:stream9 --> rockylinux:9
  centos:stream9 --> redhat/ubi9:latest
  centos:stream9 --> oraclelinux:9
  centos:stream9 ----> centos:stream10
  fedora:40 --> centos:stream10
  fedora:40 --> fedora:41
  fedora:41 --> fedora:42["`fedora:42
  (latest)`"]
  fedora:42 --> fedora:43["`fedora:43
  (rawhide)`"]
  centos:stream10 --> almalinux:10-kitten
  centos:stream10 --> redhat/ubi:10
  fedora:43 --> fedora:44["`fedora:44
  (8-12-2025)`"]
```

## Disclaimer

This diagram is meant for general information to show the upstreams from various images to mimic Red Hat Enterprise Linux (RHEL). Red Hat stopped publishing the source code to RHEL in 2023. The area from version 8 may not be 100% correct.

## Release Cadence

### Fedora

- Release: 6 months
- Active: 1 year

### CentOS Stream

- Release: 3 years
- Active: ~5 years

### Red Hat Enterprise Linux

- Release: 3 years
- Active: 10 years