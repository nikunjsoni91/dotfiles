#!/bin/bash

# ==========================================================
# Dotfiles Installer
# ==========================================================

DOTFILES_VERSION="1.0.0"

echo
echo "========================================="
echo "🚀 Installing Dotfiles v${DOTFILES_VERSION}"
echo "========================================="
echo

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
cp "$DOTFILES_DIR/.p10k.zsh" ~/.p10k.zsh

# Save installed version
echo "$DOTFILES_VERSION" > "$HOME/.dotfiles-version"


# ==========================================================
# Configure ~/.zshrc (only once)
# ==========================================================

if ! grep -q ">>> DOTFILES START >>>" "$HOME/.zshrc"; then

cat <<'EOF' >> "$HOME/.zshrc"

# >>> DOTFILES START >>>

if [[ -f "$HOME/dotfiles/aliases.zsh" ]]; then
    DOTFILES="$HOME/dotfiles"
elif [[ -f "/workspaces/dotfiles/aliases.zsh" ]]; then
    DOTFILES="/workspaces/dotfiles"
fi

[[ -f "$DOTFILES/aliases.zsh" ]] && source "$DOTFILES/aliases.zsh"
[[ -f "$DOTFILES/exports.zsh" ]] && source "$DOTFILES/exports.zsh"
[[ -f "$DOTFILES/functions.zsh" ]] && source "$DOTFILES/functions.zsh"
[[ -f "$HOME/.p10k.zsh" ]] && source "$HOME/.p10k.zsh"

# <<< DOTFILES END >>>

EOF

fi

echo
echo "========================================="
echo "✅ Dotfiles v${DOTFILES_VERSION} installed successfully!"
echo
echo "Restart your shell:"
echo "    exec zsh"
echo
echo "Installed version:"
cat "$HOME/.dotfiles-version"
echo "========================================="
