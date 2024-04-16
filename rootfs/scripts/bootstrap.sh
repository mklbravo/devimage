#!/bin/sh

# Update repositories info
/scripts/package-manager.sh update

# Setup tools
/scripts/setup-s6overlay.sh
/scripts/setup-shell.sh
/scripts/setup-nvim.sh
/scripts/setup-lazygit.sh
/scripts/setup-secrets.sh

# Clean Up
apt-get clean
rm -rf /var/lib/apt/lists/*
