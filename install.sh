#!/bin/bash

set -e

# ==========================================================
# Dotfiles Installer
# ==========================================================

DOTFILES_VERSION="1.0.1"
ZSH_THEME_NAME="powerlevel10k/powerlevel10k"

echo
echo "========================================="
echo "🚀 Installing Dotfiles v${DOTFILES_VERSION}"
echo "========================================="
echo

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
ZSH_CUSTOM="${HOME}/.oh-my-zsh/custom"

# ==========================================================
# Install Oh My Zsh
# ==========================================================

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# ==========================================================
# Install Theme
# ==========================================================

if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
    echo "Installing Powerlevel10k..."
    git clone --depth=1 \
        https://github.com/romkatv/powerlevel10k.git \
        "$ZSH_CUSTOM/themes/powerlevel10k"
fi

# ==========================================================
# Install Plugins
# ==========================================================

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    echo "Installing zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions \
        "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    echo "Installing zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting \
        "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

# ==========================================================
# Configure ~/.zshrc
# ==========================================================

# Update theme
CURRENT_THEME=$(grep '^ZSH_THEME=' "$HOME/.zshrc" | cut -d'"' -f2 || true)

if [ "$CURRENT_THEME" != "$ZSH_THEME_NAME" ]; then
    sed -i "s|^ZSH_THEME=.*|ZSH_THEME=\"$ZSH_THEME_NAME\"|" "$HOME/.zshrc"
fi

# Update plugins
if ! grep -q "zsh-autosuggestions" "$HOME/.zshrc"; then
    sed -i '/^plugins=/c\
plugins=(\
  git\
  zsh-autosuggestions\
  zsh-syntax-highlighting\
)' "$HOME/.zshrc"
fi

# Append managed block only once
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

# ==========================================================
# Copy Configuration Files
# ==========================================================

cp "$DOTFILES_DIR/.p10k.zsh" "$HOME/.p10k.zsh"

# ==========================================================
# Save Installed Version
# ==========================================================

echo "$DOTFILES_VERSION" > "$HOME/.dotfiles-version"

# ==========================================================
# Set Default Shell (Best Effort)
# ==========================================================

if command -v chsh >/dev/null 2>&1; then
    chsh -s "$(command -v zsh)" "$USER" >/dev/null 2>&1 || true
fi

# ==========================================================
# Done
# ==========================================================

echo
echo "========================================="
echo "✅ Dotfiles v${DOTFILES_VERSION} installed successfully!"
echo
echo "Installed version:"
cat "$HOME/.dotfiles-version"
echo
echo "Next step:"
echo "    exec zsh"
echo "========================================="