#!/bin/sh

echo "Setting-Up Neovim..."

echo "Installing required packages..."
/build-scripts/package-manager.sh install \
  build-essential \
  git \
  python3 \
  python3-venv \
  ripgrep

echo "Cloning Neovim configuration..."
git clone --depth 1 --branch "${NVIM_CONFIG_VERSION}" https://github.com/mklbravo/nvim-config.git ~/.config/nvim

echo "Install Lazy dependencies..."
nvim --headless +Lazy install +qall
