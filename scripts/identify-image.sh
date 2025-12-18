#!/bin/sh

# Basic Information
uname -a
uname -m

if command -v hostnamectl >/dev/null 2>&1; then
    hostnamectl
fi

# Container Detection
if [ -f "/.dockerenv" ]; then
    echo "Running inside Docker container (file indicator)"
elif grep -q docker /proc/self/cgroup > /dev/null 2>&1; then
    echo "Running inside Docker container (cgroup indicator)"
elif grep -q lxc /proc/self/cgroup > /dev/null 2>&1; then
    echo "Running inside LXC container"
elif grep -q kubepods /proc/self/cgroup > /dev/null 2>&1; then
    echo "Running inside Kubernetes pod"
elif [ -f "/run/.containerenv" ]; then
    echo "Running inside Podman container"
fi

# Distro-Specific Files
for file in /etc/*elease /etc/*_version /etc/*-version /etc/issue*; do
    if [ -f "${file}" ]; then
        echo "Content of ${file}:"
        cat "${file}"
    fi
done

if command -v busybox >/dev/null 2>&1; then
    # shellcheck disable=SC2012
    ls --help 2>&1 | head -1
fi

# Check LSB release information
if command -v lsb_release > /dev/null 2>&1; then
    echo "LSB Release information:"
    lsb_release -a 2> /dev/null
fi

# System Information
if [ -f "/proc/version" ]; then
    echo "Kernel version:"
    cat "/proc/version"
fi
