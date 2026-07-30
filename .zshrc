export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Locate dotfiles automatically
if [[ -d "$HOME/dotfiles" ]]; then
    DOTFILES="$HOME/dotfiles"
elif [[ -d "/workspaces/dotfiles" ]]; then
    DOTFILES="/workspaces/dotfiles"
fi

[[ -f "$DOTFILES/aliases.zsh" ]] && source "$DOTFILES/aliases.zsh"
[[ -f "$DOTFILES/exports.zsh" ]] && source "$DOTFILES/exports.zsh"
[[ -f "$DOTFILES/functions.zsh" ]] && source "$DOTFILES/functions.zsh"
[[ -f "$DOTFILES/.p10k.zsh" ]] && source "$DOTFILES/.p10k.zsh"
