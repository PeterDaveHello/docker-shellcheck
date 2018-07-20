FROM alpine:latest

MAINTAINER Peter Dave Hello <hsu@peterdavehello.org>

ENV SHELLCHECK_VERSION=0.5.0

RUN apk add --no-cache bash findutils

RUN wget https://storage.googleapis.com/shellcheck/shellcheck-v$SHELLCHECK_VERSION.linux.x86_64.tar.xz -O- | tar xJvf - shellcheck-v$SHELLCHECK_VERSION/shellcheck && \
    mv shellcheck-v$SHELLCHECK_VERSION/shellcheck /bin && \
    rmdir shellcheck-v$SHELLCHECK_VERSION/ && \
    shellcheck -V
