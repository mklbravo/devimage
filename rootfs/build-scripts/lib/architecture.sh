#!/bin/sh

normalize_architecture() {
  case "$1" in
  amd64 | x86_64)
    echo "amd64"
    ;;
  arm64 | aarch64)
    echo "arm64"
    ;;
  *)
    echo "Unsupported architecture: $1" >&2
    return 1
    ;;
  esac
}

get_architecture() {
  ARCHITECTURE=$(normalize_architecture "${TARGETARCH:-$(uname -m)}") || return 1

  case "${1:-canonical}:${ARCHITECTURE}" in
  canonical:amd64 | canonical:arm64)
    echo "$ARCHITECTURE"
    ;;
  node:amd64)
    echo "x64"
    ;;
  node:arm64 | neovim:arm64 | lazygit:arm64)
    echo "arm64"
    ;;
  neovim:amd64 | s6:amd64 | lazygit:amd64)
    echo "x86_64"
    ;;
  s6:arm64)
    echo "aarch64"
    ;;
  *)
    echo "Unsupported architecture format: ${1:-canonical}" >&2
    return 1
    ;;
  esac
}
