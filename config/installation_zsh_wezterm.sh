#!/bin/bash

# Install required packages
sudo pacman -S --noconfirm fastfetch
yay -S --noconfirm zsh
echo "✅ zsh is installed successfully!"

# Create .zshrc if it doesn't exist
[ ! -f "$HOME/.zshrc" ] && touch "$HOME/.zshrc" && echo "✅ .zshrc created!"

# Install Oh My Zsh if not already installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "📦 Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Clone zsh-autosuggestions
if [ ! -d "$HOME/.zsh/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME/.zsh/zsh-autosuggestions"
    echo "✅ zsh-autosuggestions cloned."
fi

# Add autosuggestions to .zshrc if not already added
grep -q "zsh-autosuggestions.zsh" ~/.zshrc || echo "source \$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc

# Clone zsh-syntax-highlighting
SYNTAX_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
if [ ! -d "$SYNTAX_DIR" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$SYNTAX_DIR"
    echo "✅ zsh-syntax-highlighting cloned."
fi

# Install powerlevel10k via yay
if command -v yay &>/dev/null; then
    yay -S --noconfirm powerlevel10k
else
    sudo pacman -S --noconfirm yay
    yay -S --noconfirm powerlevel10k
fi

# Set up fastfetch config
FASTFETCH_DIR="$HOME/.config/fastfetch"
mkdir -p "$FASTFETCH_DIR"
mv -f ~/Downloads/config/config.jsonc "$FASTFETCH_DIR/"
mv -f ~/Downloads/config/try2.png "$FASTFETCH_DIR/"
mv -f ~/Downloads/config/backup "$FASTFETCH_DIR/"
echo "✅ Fastfetch config moved."

# Set up wezterm config
WEZTERM_DIR="$HOME/.config/wezterm"
mkdir -p "$WEZTERM_DIR"
mv -f ~/Downloads/config/wezterm.lua "$WEZTERM_DIR/"
echo "✅ Wezterm config moved."

# Unzip pre-customized files if zip exists
if [ -f ~/Downloads/config/percustomized_files.zip ]; then
    unzip -o ~/Downloads/config/percustomized_files.zip -d ~/Downloads/config/
    mv -f ~/Downloads/config/percustomized_files.zshrc "$HOME/.zshrc"
    echo "✅ Pre-customized .zshrc applied."
else
    echo "⚠️ pre-customized zip file not found."
fi

# Ask for .p10k.zsh
read -p "Do you want to apply the pre-customized Powerlevel10k theme? (y/n): " answer
case "$answer" in
    [yY])
        if [ -f ~/Downloads/config/percustomized_files/.p10k.zsh ]; then
            mv -f ~/Downloads/config/percustomized_files/.p10k.zsh "$HOME/.p10k.zsh"
            echo "✅ .p10k.zsh applied."
        else
            echo "⚠️ .p10k.zsh not found in the extracted folder."
        fi
        ;;
    [nN])
        THEME_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
        if [ ! -d "$THEME_DIR" ]; then
            git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$THEME_DIR"
            echo "✅ Powerlevel10k default theme cloned."
            oh_my_zsh
        fi
        ;;
    *)
        echo "❌ Invalid input. Skipping theme setup."
        ;;
esac
source ~/.zshrc
echo "🎉 Setup complete. Please restart your terminal or run 'zsh' to begin."

