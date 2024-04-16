#!/bin/sh

# Update repositories info
/build-scripts/package-manager.sh update

# Setup tools
/build-scripts/setup-s6overlay.sh
/build-scripts/setup-shell.sh
/build-scripts/setup-nvim.sh
/build-scripts/setup-lazygit.sh
/build-scripts/setup-secrets.sh

# Clean Up
apt-get clean
rm -rf /var/lib/apt/lists/*
