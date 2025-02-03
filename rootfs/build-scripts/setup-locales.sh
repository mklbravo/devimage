#!/bin/sh

echo "Setting up locales..."

echo "Installing locales package..."
/build-scripts/package-manager.sh install locales

echo "Generating locales..."
locale-gen en_US.UTF-8
