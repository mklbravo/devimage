#!/bin/sh

# POSIX dot notation sources the file into this shell, making its functions available here.
. /build-scripts/lib/architecture.sh

# Node is required by some packages installed by Mason on Neovim
NODE_VERSION=v24.13.0
ARCH=$(get_architecture node)

echo "Setting-Up Node.js... (${NODE_VERSION})"

echo "Installing required packages..."
/build-scripts/package-manager.sh install \
  curl \
  tar

# See: https://nodejs.org/en/download/prebuilt-binaries/current
echo "Downloading Node.js prebuilt binaries..."
curl -fsSLO "https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-linux-${ARCH}.tar.xz"

echo "Extracting Node.js..."
tar -xJf "node-${NODE_VERSION}-linux-${ARCH}.tar.xz" -C /usr/local --strip-components=1 --no-same-owner

echo "Removing Node.js downloaded binaries..."
rm "node-${NODE_VERSION}-linux-${ARCH}.tar.xz"
