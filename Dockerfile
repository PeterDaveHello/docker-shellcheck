FROM alpine:3.23

# You'll also need to change shellcheck version in from scratch image
ARG shellcheck=0.8.0
ARG dumb_init=1.2.5

SHELL ["/bin/sh", "-exc"]
RUN apk add --no-cache bash

SHELL ["/bin/bash", "-exo", "pipefail", "-c"]
# Prerequisites
RUN \
  # Directory structure and permissions
  mkdir -p base/bin base/tmp base/var/tmp base/etc base/home/nonroot base/sbin base/root; \
  chmod 700 /root; \
  chown root:root /root; \
  chmod 1777 base/tmp base/var/tmp; \
  chown 65532:65532 base/home/nonroot; \
  chmod 750 base/home/nonroot; \
  # UID and GID
  echo 'root:x:0:' > /base/etc/group; \
  echo 'nonroot:x:65532:' >> /base/etc/group; \
  echo 'root:x:0:0:root:/root:/sbin/nologin' > /base/etc/passwd; \
  echo 'nonroot:x:65532:65532:nonroot:/home/nonroot:/sbin/nologin' >> /base/etc/passwd; \
  # init binary
  wget -O base/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v${dumb_init}/dumb-init_${dumb_init}_"`uname -m`"; \
  chmod 755 base/bin/dumb-init; \
  # copy busybox and musl
  mkdir -p base/usr/bin base/lib; \
  cp /lib/ld-musl-*.so.1 base/lib; \
  cp /bin/busybox base/bin/; \
  find /usr/bin -type l -exec /bin/sh -c 'function e() { if [ "`readlink "$1"`" = /bin/busybox ]; then echo "$1"; fi; }; e {}' \; \
    | tr '\n' '\0' | xargs -0 -I{} cp -a {} base/usr/bin/; \
  find /bin -type l -exec /bin/sh -c 'function e() { if [ "`readlink "$1"`" = /bin/busybox ]; then echo "$1"; fi; }; e {}' \; \
    | tr '\n' '\0' | xargs -0 -I{} cp -a {} base/bin/; \
  echo "Distroless shellcheck ${shellcheck}" > base/etc/issue; \
  echo "https://github.com/PeterDaveHello/docker-shellcheck" >> base/etc/issue

RUN wget https://github.com/koalaman/shellcheck/releases/download/v${shellcheck}/shellcheck-v${shellcheck}.linux."`uname -m`".tar.xz -O- | \
    tar xJv shellcheck-v${shellcheck}/shellcheck; \
    mv shellcheck-v${shellcheck}/shellcheck base/bin/

FROM scratch
ARG shellcheck=0.8.0
LABEL maintainer="Peter Dave Hello <hsu@peterdavehello.org>"
LABEL name="shellcheck"
LABEL version="${shellcheck}"
COPY --from=0 /base/ /
ENTRYPOINT ["/bin/dumb-init", "--"]
USER nonroot
ENV HOME=/home/nonroot USER=nonroot PATH="/bin:/sbin:/usr/bin"
WORKDIR /home/nonroot
CMD ["/bin/sh", "-exc", "find . -type f -name '*.sh' -print0 | xargs -0r shellcheck"]
