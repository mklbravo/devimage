export ZSH="$HOME/.oh-my-zsh"

# Override language settings to avoid issues with special characters
export LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8

plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

eval "$(starship init zsh)"

