#!/bin/sh

echo "Setting-Up Neovim..."

echo "Installing required packages..."
/scripts/package-manager.sh install \
  curl \
  git

echo "Getting Neovim package..."
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage

echo "Extracting Neovim..."
./nvim.appimage --appimage-extract

echo "Removing Neovim package..."
rm ./nvim.appimage

INSTALL_FOLDER=/etc/neovim

echo "Moving Neovim to ${INSTALL_FOLDER}..."
mv ./squashfs-root ${INSTALL_FOLDER}

echo "Creating Neovim symlink..."
ln -s "$INSTALL_FOLDER/AppRun" /usr/bin/nvim

echo "Cloning Neovim configuration..."
git clone https://github.com/mklbravo/nvim-config.git ~/.config/nvim
