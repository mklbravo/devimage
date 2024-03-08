#!/bin/sh

echo "Setting-Up s6-overlay..."

echo "Installing required packages..."
/scripts/package-manager.sh install \
  curl \
  tar \
  xz-utils

S6_OVERLAY_VERSION=3.1.6.0

# See: https://github.com/just-containers/s6-overlay#installation
curl -LO https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz
tar -C / -Jxpf ./s6-overlay-noarch.tar.xz
rm ./s6-overlay-noarch.tar.xz

# TODO: Make sure to use the correct architecture
curl -LO https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-x86_64.tar.xz
tar -C / -Jxpf ./s6-overlay-x86_64.tar.xz
rm ./s6-overlay-x86_64.tar.xz
