#!/bin/sh

echo "Setting-Up Neovim..."

echo "Installing required packages..."
/build-scripts/package-manager.sh install \
  build-essential \
  git \
  python3 \
  python3-venv \
  ripgrep

echo "Checking system architecture..."
UNAME_OUT="$(uname)"
ARCH="$(uname -m)"

case "$UNAME_OUT" in
Darwin)
  OS="macos"
  ;;
Linux)
  OS="linux"
  ;;
*)
  echo "Unsupported OS: $UNAME_OUT"
  exit 1
  ;;
esac

case "$ARCH" in
x86_64)
  ARCH="x86_64"
  ;;
arm64 | aarch64)
  ARCH="arm64"
  ;;
*)
  echo "Unsupported architecture: $ARCH"
  exit 1
  ;;
esac

NVIM_RELEASE="nvim-${OS}-${ARCH}"
echo "Determined Neovim release: $NVIM_RELEASE"

echo "Downloading Neovim..."
curl -LO https://github.com/neovim/neovim/releases/latest/download/${NVIM_RELEASE}.tar.gz

echo "Extracting Neovim..."
tar -C /opt -xzf ${NVIM_RELEASE}.tar.gz

echo "Creating symbolic link for nvim..."
ln -s /opt/${NVIM_RELEASE}/bin/nvim /usr/bin/nvim

echo "Cloning Neovim configuration..."
git clone --depth 1 https://github.com/mklbravo/nvim-config.git ~/.config/nvim

echo "Install Lazy dependencies..."
nvim --headless +"Lazy install" +"qall"

echo "Update mason registries..."
nvim --headless +"MasonUpdate" +"qall"
