# Dockerized ShellCheck

[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](https://github.com/MyDockerfiles/ShellCheck)
[![Docker Hub pulls](https://img.shields.io/docker/pulls/peterdavehello/shellcheck.svg)](https://hub.docker.com/r/peterdavehello/shellcheck/)
[![Docker image layers](https://images.microbadger.com/badges/image/peterdavehello/shellcheck.svg)](https://microbadger.com/images/peterdavehello/shellcheck/)
[![Docker image version](https://images.microbadger.com/badges/version/peterdavehello/shellcheck.svg)](https://hub.docker.com/r/peterdavehello/shellcheck/tags/)

[![Docker Hub badge](https://dockeri.co/image/peterdavehello/shellcheck)](https://hub.docker.com/r/peterdavehello/shellcheck/)

## About ShellCheck

A static analysis tool for shell scripts, homepage and repository below:

- <https://www.shellcheck.net>
- <https://github.com/koalaman/shellcheck>

Please note that this Docker image repository is not part of the ShellCheck project.

## Available image tags

See [tags](https://hub.docker.com/r/peterdavehello/shellcheck/tags) page on Docker Hub

## Usage

### Command line

```sh
SHELLCHECK_VERSION=0.8.0
docker run --rm -u "$(id -u):$(id -g)" -v "$PWD:$PWD" -w "$PWD" peterdavehello/shellcheck:$SHELLCHECK_VERSION
```

### In GitLab CI

```yaml
shellcheck:
  stage: test
  image: peterdavehello/shellcheck:0.8.0
  only:
    changes:
      - "**/*.sh"
  before_script:
    - shellcheck --version
  script:
    - find . -type f -name '*.sh' -print0 | xargs -0r shellcheck --color=always
  tags:
    - docker
```
