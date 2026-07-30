#!/bin/bash

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
ZSH_CUSTOM="${HOME}/.oh-my-zsh/custom"

echo "Installing dotfiles..."

# Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install Powerlevel10k
if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
    git clone --depth=1 \
      https://github.com/romkatv/powerlevel10k.git \
      "$ZSH_CUSTOM/themes/powerlevel10k"
fi

# Install Autosuggestions
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions \
      "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

# Install Syntax Highlighting
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting \
      "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

# Copy configuration
cp "$DOTFILES_DIR/.zshrc" ~/.zshrc
cp "$DOTFILES_DIR/.p10k.zsh" ~/.p10k.zsh

echo ""
echo "✅ Installation complete."
echo "Run:"
echo "exec zsh"
