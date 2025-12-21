#!/usr/bin/env bash
set -e

ZSHRC="$HOME/.zshrc"
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

echo "[*] Ensuring Zsh is installed"
if ! command -v zsh >/dev/null 2>&1; then
    apt update
    apt install -y zsh
fi

echo "[*] Installing Oh My Zsh (if missing)"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    RUNZSH=no CHSH=no sh -c \
      "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

echo "[*] Ensuring ~/.zshrc exists"
if [ ! -f "$ZSHRC" ]; then
    touch "$ZSHRC"
fi

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

echo "[*] Configuring plugins in ~/.zshrc"
if ! grep -q "^plugins=" "$ZSHRC"; then
    echo "plugins=(git zsh-autosuggestions zsh-syntax-highlighting)" >> "$ZSHRC"
else
    sed -i 's/^plugins=.*/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' "$ZSHRC"
fi

echo "[*] Ensuring completion system"
if ! grep -q "autoload -U compinit" "$ZSHRC"; then
    cat >> "$ZSHRC" << 'EOF'

autoload -U compinit
compinit
EOF
fi

echo "[*] Installing custom prompt"
if ! grep -q "CUSTOM ZSH PROMPT START" "$ZSHRC"; then
    cat >> "$ZSHRC" << 'EOF'

# ===== CUSTOM ZSH PROMPT START =====
EOF
    cat custom_zsh_prompt.sh >> "$ZSHRC"
    cat >> "$ZSHRC" << 'EOF'
# ===== CUSTOM ZSH PROMPT END =====
EOF
fi

echo "[*] Done."
echo "[*] To use it now: exec zsh"
