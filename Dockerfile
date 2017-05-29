FROM ubuntu:latest

MAINTAINER Peter Dave Hello <hsu@peterdavehello.org>

# Prevent dialog during apt install
ENV DEBIAN_FRONTEND noninteractive

# Pick a Ubuntu apt mirror site for better speed
# ref: https://launchpad.net/ubuntu/+archivemirrors
ENV UBUNTU_APT_SITE ubuntu.cs.utah.edu
ENV UBUNTU_APT_SITE ftp.yzu.edu.tw

# Disable src package source
RUN sed -i 's/^deb-src\ /\#deb-src\ /g' /etc/apt/sources.list

# Replace origin apt pacakge site with the mirror site
RUN sed -E -i "s/([a-z]+.)?archive.ubuntu.com/$UBUNTU_APT_SITE/g" /etc/apt/sources.list
RUN sed -i "s/security.ubuntu.com/$UBUNTU_APT_SITE/g" /etc/apt/sources.list

RUN apt update && \
    apt install -y libffi6 libgmp10 cabal-install && \
    apt clean && \
    cabal update && \
    cabal install ShellCheck && \
    mv /root/.cabal/bin/shellcheck /bin && \
    rm -rf /root/.ghc /root/.cabal /var/lib/apt/lists/* && \
    apt remove --purge -y cabal-install && \
    apt autoremove -y
