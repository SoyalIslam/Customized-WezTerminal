#!/bin/bash

set -e  # Exit on any error

echo "Installing fastfetch via pacman..."
sudo pacman -Sy --noconfirm fastfetch

echo "Installing zsh via yay..."
if ! command -v yay &> /dev/null; then
    echo "yay not found. Installing yay..."
    sudo pacman -Sy --noconfirm yay
fi
yay -S --noconfirm zsh

echo "✅ zsh installed successfully."

# Create or touch .zshrc
touch ~/.zshrc
echo "✅ ~/.zshrc file created."

# Install Oh My Zsh
echo "Installing Oh My Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "Oh My Zsh is already installed."
fi

# Install zsh-autosuggestions plugin
echo "Cloning zsh-autosuggestions..."
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions || echo "Already cloned"

# Source autosuggestions
echo "source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc
echo "✅ zsh-autosuggestions sourced."

# Install zsh-syntax-highlighting
echo "Cloning zsh-syntax-highlighting..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting || echo "Already cloned"

# Add plugins to .zshrc if not already added
if ! grep -q "zsh-syntax-highlighting" ~/.zshrc; then
    sed -i 's/plugins=(/plugins=(zsh-syntax-highlighting /' ~/.zshrc
fi
echo "✅ zsh-syntax-highlighting added to plugins."

# Move fastfetch config files
FASTFETCH_DIR="$HOME/.config/fastfetch"
mkdir -p "$FASTFETCH_DIR"
mv -f ~/Downloads/config/config.jsonc "$FASTFETCH_DIR/"
mv -f ~/Downloads/config/try2.png "$FASTFETCH_DIR/"
mv -f ~/Downloads/config/backup "$FASTFETCH_DIR/"
echo "✅ fastfetch config moved."

# Move wezterm config files
WEZTERM_DIR="$HOME/.config/wezterm"
mkdir -p "$WEZTERM_DIR"
mv -f ~/Downloads/config/wezterm.lua "$WEZTERM_DIR/"
echo "✅ wezterm config moved."

# Install powerlevel10k theme
echo "Installing powerlevel10k..."
yay -S --noconfirm powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" || echo "Already cloned"


# Overwrite .zshrc with your custom one (optional)
mv -f ~/Downloads/config/.zshrc ~/.zshrc
echo "✅ Custom .zshrc moved."
source ~/.zshrc
echo "🎉 Setup complete. Please restart your terminal or run 'zsh' to begin."

