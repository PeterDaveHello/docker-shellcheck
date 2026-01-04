# Repository Guidelines

## Project Overview

Dockerized ShellCheck builds a Docker image that bundles the upstream ShellCheck
binary. The published image name is `peterdavehello/shellcheck`.

## Project Structure & Module Organization

- `Dockerfile` defines the image build, pins the Alpine base, sets
  `SHELLCHECK_VERSION`, downloads the release tarball, and verifies via
  `shellcheck -V`.
- `README.md` contains usage examples for local runs and CI integration.
- `renovate.json` configures Renovate to keep dependencies updated.

## Architecture Overview

This repository ships a single Dockerfile based on Alpine Linux that:

1. Downloads the ShellCheck binary from GitHub releases.
2. Installs it to `/bin/shellcheck`.
Versioning is controlled by `SHELLCHECK_VERSION` in `Dockerfile` (currently
`0.11.0`).

## Build, Test, and Development Commands

- `docker build -t peterdavehello/shellcheck:<version> .` Build the image locally.
- `docker build -t peterdavehello/shellcheck . && docker run --rm -it \
  peterdavehello/shellcheck shellcheck --version` Build and smoke-test in one
  step.
- `docker run --rm -v "$PWD":/scripts peterdavehello/shellcheck:<version> \
  shellcheck /scripts/script.sh` Run ShellCheck against local scripts.

## Linting

- `npx dockerfile_lint` Lint the `Dockerfile` if the linter is available in your
  environment.

## Coding Style & Naming Conventions

- Keep Dockerfile instructions uppercase and one per line.
- Use `&& \` continuations with consistent indentation for multi-step `RUN`.
- Keep `LABEL version`, `ENV SHELLCHECK_VERSION`, and README examples in sync.
- Image tags should match upstream ShellCheck releases (for example, `0.11.0`).

## Testing Guidelines

- There is no dedicated test suite or CI config in this repo.
- Validate changes by building the image and running `shellcheck -V` plus a
  sample script check.

## Version Update Checklist

- Update the Alpine base tag in `Dockerfile` when needed.
- Bump `SHELLCHECK_VERSION` and the download URL in the same change.
- Refresh README examples if they hard-code versions or tags.

## Commit & Pull Request Guidelines

- Commit subjects are short, imperative, and capitalized (for example,
  "Update alpine Docker tag to v3.23").
- PRs should describe the version change, list the commands run, and update
  `README.md` when usage or tags change.
- Link relevant issues or Renovate PRs when applicable.
