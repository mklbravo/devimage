#!/bin/sh

# POSIX dot notation sources the file into this shell, making its functions available here.
. /build-scripts/lib/architecture.sh

# See: https://github.com/jesseduffield/lazygit
echo "Setting-Up Lazygit..."

echo "Installing required packages..."
/build-scripts/package-manager.sh install \
  curl \
  tar

echo "Getting Lazygit latest version..."
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')

LAZYGIT_ARCH=$(get_architecture lazygit)

echo "Downloading Lazygit for ${LAZYGIT_ARCH}..."
curl -Lo /tmp/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_${LAZYGIT_ARCH}.tar.gz"

echo "Extracting Lazygit..."
tar xf /tmp/lazygit.tar.gz --directory /tmp lazygit

echo "Moving Lazygit to /usr/local/bin..."
install /tmp/lazygit /usr/local/bin

echo "Removing Lazygit package..."
rm -rf /tmp/lazygit*
