#!/bin/sh

echo "Setting-Up s6-overlay..."

echo "Installing required packages..."
/build-scripts/package-manager.sh install \
  ca-certificates \
  curl \
  tar \
  xz-utils

S6_OVERLAY_VERSION=3.1.6.0

echo "Determining s6-overlay architecture..."

ARCH_INPUT="$(uname -m)"
echo "Detected architecture: $ARCH_INPUT"

case "$ARCH_INPUT" in
amd64 | x86_64)
  S6_ARCH="x86_64"
  ;;
arm64 | aarch64)
  S6_ARCH="aarch64"
  ;;
*)
  echo "Unsupported architecture: $ARCH_INPUT"
  exit 1
  ;;
esac

echo "Determined s6-overlay architecture: $S6_ARCH"

# See: https://github.com/just-containers/s6-overlay#installation
echo "Installing s6-overlay (noarch)..."
curl -LO https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz
tar -C / -Jxpf ./s6-overlay-noarch.tar.xz
rm ./s6-overlay-noarch.tar.xz

echo "Installing s6-overlay ($S6_ARCH)..."
curl -LO https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-${S6_ARCH}.tar.xz
tar -C / -Jxpf ./s6-overlay-${S6_ARCH}.tar.xz
rm ./s6-overlay-${S6_ARCH}.tar.xz
