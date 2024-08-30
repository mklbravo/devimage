#!/bin/sh
# See: https://github.com/cli/cli?tab=readme-ov-file#installation
# NOTE: This only works for Debian based linux distros. Adapt it when required

echo "Installing required packages..."
/build-scripts/package-manager.sh install wget

echo "Creating /etc/apt/keyrings folder"
mkdir -p /etc/apt/keyrings

echo "Save GitHub CLI keyring"
wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | tee /etc/apt/keyrings/githubcli-archive-keyring.gpg >/dev/null

echo "Change newly added keyring file permission"
chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg

echo "Adding GitHub CLI repository"
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list >/dev/null

echo "Update repositories info"
/build-scripts/package-manager.sh update

echo "Installing gh..."
/build-scripts/package-manager.sh install gh
