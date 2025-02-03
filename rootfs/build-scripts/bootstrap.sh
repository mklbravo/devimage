#!/bin/sh

# Exit immediately if a command exits with a non-zero status.
set -e

executeBuildScript() {
  sh -e "/build-scripts/${1}.sh"
}

# Update repositories info
/build-scripts/package-manager.sh update
/build-scripts/package-manager.sh upgrade

# Setup tools
executeBuildScript "setup-s6overlay"
executeBuildScript "setup-shell"
executeBuildScript "setup-nodejs"
executeBuildScript "setup-nvim"
executeBuildScript "setup-lazygit"
executeBuildScript "setup-secrets"
executeBuildScript "setup-github-cli"

# Clean Up
apt-get clean
rm -rf /var/lib/apt/lists/*
