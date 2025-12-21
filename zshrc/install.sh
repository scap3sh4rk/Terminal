#!/usr/bin/env bash
set -e

echo "[*] Installing Zsh (if missing)"
if ! command -v zsh >/dev/null 2>&1; then
    sudo apt update
    sudo apt install -y zsh
fi

echo "[*] Installing Oh My Zsh (if missing)"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

echo "[*] Installing Oh My Zsh plugins"
mkdir -p "$ZSH_CUSTOM/plugins"

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions \
        "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting \
        "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

echo "[*] Configuring ~/.zshrc"

if ! grep -q "plugins=(git zsh-autosuggestions zsh-syntax-highlighting)" "$HOME/.zshrc"; then
    sed -i 's/^plugins=.*/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' "$HOME/.zshrc"
fi

if ! grep -q "autoload -U compinit" "$HOME/.zshrc"; then
    cat >> "$HOME/.zshrc" << 'EOF'

autoload -U compinit
compinit
EOF
fi

if ! grep -q "CUSTOM ZSH PROMPT START" "$HOME/.zshrc"; then
    echo "[*] Appending custom prompt configuration"
    cat >> "$HOME/.zshrc" << 'EOF'

# ===== CUSTOM ZSH PROMPT START =====
EOF
    cat custom_zsh_prompt.sh >> "$HOME/.zshrc"
    cat >> "$HOME/.zshrc" << 'EOF'
# ===== CUSTOM ZSH PROMPT END =====
EOF
fi

echo "[*] Installation complete"
echo "[*] Restart the terminal or run: source ~/.zshrc"
