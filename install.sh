#!/bin/bash

# 1. Setup paths for custom Zsh plugins
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

# 2. Install Oh My Zsh silently if missing
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# 3. Clone the Auto-Suggestions Plugin securely
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions \
"$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

# 4. Clone the Syntax Highlighting Plugin securely
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting \
"$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

# 5. Enable the plugins and theme inside the Zsh configuration file (~/.zshrc)
# This replaces the default plugin line with git, autosuggestions, and highlighting
sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/g' ~/.zshrc

# 6. Set the default theme to a highly readable layout
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="bira"/g' ~/.zshrc

# 7. Apply the neon green background color fix globally to the Zsh profile
if ! grep -q "LS_COLORS" ~/.zshrc; then
  echo 'export LS_COLORS="$LS_COLORS:ow=01;34:tw=01;34:"' >> ~/.zshrc
fi

cp .zshrc ~/.zshrc

echo ""
echo "✅ Installation complete."
echo "Run:"
echo "exec zsh"


