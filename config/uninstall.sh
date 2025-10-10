#!/bin/bash
# === Step 1: Remove Powerlevel10k ===
if [ -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
    rm -rf "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
    echo "✅ Powerlevel10k theme removed."
fi

# === Step 2: Remove Oh My Zsh and zsh-autosuggestions ===
if [ -d "$HOME/.oh-my-zsh" ]; then
    rm -rf "$HOME/.oh-my-zsh"
    echo "✅ Oh My Zsh removed."
fi

AUTOSUGGEST_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
if [ -d "$AUTOSUGGEST_DIR" ]; then
    rm -rf "$AUTOSUGGEST_DIR"
    echo "✅ zsh-autosuggestions removed."
fi

# === Step 3: Remove zsh-syntax-highlighting ===
SYNTAX_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
if [ -d "$SYNTAX_DIR" ]; then
    rm -rf "$SYNTAX_DIR"
    echo "✅ zsh-syntax-highlighting removed."
fi

# === Step 4: Remove fastfetch configuration ===
FASTFETCH_DIR="$HOME/.config/fastfetch"
if [ -d "$FASTFETCH_DIR" ]; then
    rm -rf "$FASTFETCH_DIR"
    echo "✅ Fastfetch configuration removed."
fi

# === Step 5: Remove Wezterm configuration ===
WEZTERM_DIR="$HOME/.config/wezterm"
if [ -d "$WEZTERM_DIR" ]; then
    rm -rf "$WEZTERM_DIR"
    echo "✅ Wezterm configuration removed."
fi

# === Step 6: Remove .zshrc and .p10k.zsh ===
if [ -f "$HOME/.zshrc" ]; then
    rm -f "$HOME/.zshrc"
    echo "✅ .zshrc removed."
fi

if [ -f "$HOME/.p10k.zsh" ]; then
    rm -f "$HOME/.p10k.zsh"
    echo "✅ .p10k.zsh removed."
fi

# === Step 7: Uninstall yay and other packages ===
if command -v yay &> /dev/null; then
    yay -Rns --noconfirm yay
    echo "✅ yay removed."
fi

if command -v fastfetch &> /dev/null; then
    sudo pacman -Rns --noconfirm fastfetch
    echo "✅ fastfetch removed."
fi

if command -v fzf &> /dev/null; then
    yay -Rns --noconfirm fzf
    echo "✅ fzf removed."
fi

# === Step 8: Final cleanup ===
# Removing any unnecessary configurations or downloaded files
if [ -d "$HOME/Downloads/Customized-WezTerminal" ]; then
    rm -rf "$HOME/Downloads/Customized-WezTerminal"
    echo "✅ Customized-WezTerminal files removed."
fi

# === Step 9: End of uninstallation ===
echo "🎉 Uninstallation complete. All installed packages and configurations have been removed."
