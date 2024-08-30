#!/bin/bash

echo "Installing required packages..."
/build-scripts/package-manager.sh install openssh-client

# Prepare the SSH configuration
mkdir -p /root/.ssh
ln -s /run/secrets/ssh_private_key /root/.ssh/id_rsa
touch /root/.ssh/known_hosts
ssh-keyscan -H github.com >>/root/.ssh/known_hosts
