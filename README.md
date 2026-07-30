# dotfiles

# 🚀 My Dotfiles

Personal terminal configuration for GitHub Codespaces and future Linux/macOS development environments.

## Features

- Oh My Zsh
- Powerlevel10k
- zsh-autosuggestions
- zsh-syntax-highlighting
- Custom aliases
- Custom exports
- Custom functions
- Automatic installation
- GitHub Codespaces friendly

---

# Repository Structure

```
dotfiles/
├── install.sh
├── aliases.zsh
├── exports.zsh
├── functions.zsh
├── .p10k.zsh
└── README.md
```

---

# First Time Setup

Clone the repository:

```bash
git clone https://github.com/<YOUR_USERNAME>/dotfiles.git ~/dotfiles
```

Run the installer:

```bash
cd ~/dotfiles

chmod +x install.sh

./install.sh
```

Restart the shell:

```bash
exec zsh
```

---

# Updating Existing Codespaces

If only aliases/functions/exports changed:

```bash
cd ~/dotfiles

git pull

exec zsh
```

If install.sh changed:

```bash
cd ~/dotfiles

git pull

./install.sh

exec zsh
```

---

# Updating Dotfiles Repository

```bash
git status

git add .

git commit -m "Describe changes"

git push
```

Test changes:

```bash
./install.sh

exec zsh
```

---

# Emergency Reset

If local changes accidentally exist:

```bash
cd ~/dotfiles

git fetch

git reset --hard origin/main

exec zsh
```

---

# Check Installed Version

```bash
cat ~/.dotfiles-version
```

Example:

```
1.0.0
```

---

# Versioning

Semantic Versioning is used.

Examples:

- 1.0.0 – Initial stable release
- 1.0.1 – Bug fixes
- 1.1.0 – New aliases/functions
- 1.2.0 – New plugins
- 2.0.0 – Major redesign

---

# Notes

- The `~/dotfiles` directory should be treated as read-only in project Codespaces.
- Make changes only in the dedicated Dotfiles repository.
- Re-run `install.sh` only when the installer or installed components change.
- For aliases, exports, or functions, simply `git pull` and `exec zsh`.