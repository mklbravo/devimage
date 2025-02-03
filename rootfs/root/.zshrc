export ZSH="$HOME/.oh-my-zsh"

export EDITOR='nvim'
export TERM='xterm-256color'

plugins=(
    git
    tmux
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

eval "$(starship init zsh)"

