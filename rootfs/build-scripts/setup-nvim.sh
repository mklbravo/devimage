#!/bin/sh

echo "Setting-Up Neovim..."

echo "Installing required packages..."
/build-scripts/package-manager.sh install \
  build-essential \
  curl \
  git \
  python3 \
  python3-venv \
  ripgrep

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
git clone --depth 1 --branch "${NVIM_CONFIG_VERSION}" https://github.com/mklbravo/nvim-config.git ~/.config/nvim

echo "Install Lazy dependencies..."
nvim --headless +Lazy install +qall
