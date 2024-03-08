#!/bin/sh
# NOTE: This script will configure oh-my-zsh for the root user

echo "Setting-Up shell..."

echo "Installing required packages..."
/scripts/package-manager.sh install \
    curl \
    git \
    zsh

# See: https://ohmyz.sh/#install
echo "Installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc

echo "Setting zsh as the default shell..."
chsh -s $(which zsh)

echo "Installing Oh My Zsh plugins..."
# See: https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh
git clone https://github.com/zsh-users/zsh-autosuggestions /root/.oh-my-zsh/custom/plugins/zsh-autosuggestions
# See: https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md#oh-my-zsh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /root/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

echo "Installinf Sartship..."
curl -sS https://starship.rs/install.sh | sh -s -- --yes

