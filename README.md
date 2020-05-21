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
SHELLCHECK_VERSION=0.7.1
docker run --rm -it -v `pwd`:/scripts peterdavehello/shellcheck:$SHELLCHECK_VERSION shellcheck /scripts/script.sh
```

### In GitLab CI

```yaml
shellcheck:
  stage: test
  image: peterdavehello/shellcheck:0.7.1
  only:
    changes:
      - "**/*.bash"
  before_script:
    - shellcheck --version
  script:
    - find . -name "*.sh" | xargs -n 1 shellcheck --color=always
  tags:
    - docker
```
