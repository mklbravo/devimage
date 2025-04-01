#!/bin/sh
# NOTE: This script will configure oh-my-zsh for the root user

echo "Setting-Up shell..."

echo "Installing required packages..."
/build-scripts/package-manager.sh install \
  curl \
  git \
  tar \
  tmux \
  tmuxinator \
  zsh

# See: https://ohmyz.sh/#install
echo "Installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc

echo "Setting zsh as the default shell..."
chsh -s "$(which zsh)"

echo "Installing Oh My Zsh plugins..."
# See: https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh
git clone https://github.com/zsh-users/zsh-autosuggestions /root/.oh-my-zsh/custom/plugins/zsh-autosuggestions
# See: https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md#oh-my-zsh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /root/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

# See: https://starship.rs/installing/
echo "Installing Sartship..."
curl -sS https://starship.rs/install.sh | sh -s -- --yes

# See: https://github.com/tmux-plugins/tpm
echo "Installing Tmux Plugin Manager..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
~/.tmux/plugins/tpm/bin/install_plugins

# See: https://github.com/junegunn/fzf
echo "Install Fuzzy Finder..."
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all --no-bash --no-fish

# See: https://github.com/charmbracelet/gum
GUM_VERSION="0.16.0"
echo "Installing Gum version ${GUM_VERSION} for ${TARGETARCH} architecture..."
curl -L "https://github.com/charmbracelet/gum/releases/download/v${GUM_VERSION}/gum_${GUM_VERSION}_$(uname -s)_${TARGETARCH}.tar.gz" -o "/tmp/gum.tar.gz"
tar -xzf "/tmp/gum.tar.gz" -C "/usr/local/bin" --strip-components=1
