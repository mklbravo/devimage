#!/bin/bash

echo "Installing required packages..."
/build-scripts/package-manager.sh install openssh-client

# Prepare the SSH configuration. Keys are provided by the host SSH agent socket.
mkdir -p /root/.ssh
chmod 700 /root/.ssh
touch /root/.ssh/known_hosts
ssh-keyscan -H github.com >>/root/.ssh/known_hosts
