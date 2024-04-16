#!/bin/sh

# See: https://github.com/jesseduffield/lazygit
echo "Setting-Up Lazygit..."

echo "Installing required packages..."
/scripts/package-manager.sh install \
  curl \
  tar

echo "Getting Lazygit latest version..."
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')

echo "Downloading Lazygit..."
curl -Lo /tmp/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"

echo "Extracting Lazygit..."
tar xf /tmp/lazygit.tar.gz --directory /tmp lazygit

echo "Moving Lazygit to /usr/local/bin..."
install /tmp/lazygit /usr/local/bin

echo "Removing Lazygit package..."
rm -rf /tmp/lazygit*
