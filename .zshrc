export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="bira"

plugins=(
git
zsh-autosuggestions
zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

source ~/dotfiles/aliases.zsh
source ~/dotfiles/exports.zsh