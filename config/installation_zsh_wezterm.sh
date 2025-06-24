#!/bin/bash

# === Step 1: Install zsh and fastfetch ===
sudo pacman -S --noconfirm fastfetch
yay -S --noconfirm zsh
echo "✅ zsh is installed successfully!"

# === Step 2: Create .zshrc if it doesn't exist ===
[ ! -f "$HOME/.zshrc" ] && touch "$HOME/.zshrc" && echo "✅ .zshrc created!"

# === Step 3: Install Oh My Zsh ===
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "📦 Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# === Step 4: Clone zsh-autosuggestions ===
AUTOSUGGEST_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
if [ ! -d "$AUTOSUGGEST_DIR" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "$AUTOSUGGEST_DIR"
    echo "✅ zsh-autosuggestions cloned."
fi

# === Step 5: Clone zsh-syntax-highlighting ===
SYNTAX_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
if [ ! -d "$SYNTAX_DIR" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$SYNTAX_DIR"
    echo "✅ zsh-syntax-highlighting cloned."
fi

# === Step 6: Install Powerlevel10k ===
if command -v yay &> /dev/null; then
    yay -S --noconfirm powerlevel10k
else
    sudo pacman -S --noconfirm yay
    yay -S --noconfirm powerlevel10k
fi

# === Step 7: Fastfetch Config ===
FASTFETCH_DIR="$HOME/.config/fastfetch"
mkdir -p "$FASTFETCH_DIR"
mv -f ~/Downloads/config/config.jsonc "$FASTFETCH_DIR/"
mv -f ~/Downloads/config/try2.png "$FASTFETCH_DIR/"
mv -f ~/Downloads/config/backup "$FASTFETCH_DIR/"
echo "✅ Fastfetch config moved."

# === Step 8: Wezterm Config ===
WEZTERM_DIR="$HOME/.config/wezterm"
mkdir -p "$WEZTERM_DIR"
mv -f ~/Downloads/config/wezterm.lua "$WEZTERM_DIR/"
echo "✅ Wezterm config moved."

# === Step 9: Unzip and move .zshrc ===
if [ -f ~/Downloads/config/percustomized_files.zip ]; then
    unzip -o ~/Downloads/config/percustomized_files.zip -d ~/Downloads/config/
    mv -f ~/Downloads/config/percustomized_files.zshrc "$HOME/.zshrc"
    echo "✅ .zshrc updated from zip."
else
    echo "⚠️ Zip file not found."
fi

# === Step 10: Prompt for custom Powerlevel10k ===
read -p "Do you want to apply the pre-customized Powerlevel10k theme? (y/n): " answer
case "$answer" in
    [yY])
        if [ -f ~/Downloads/config/percustomized_files/.p10k.zsh ]; then
            mv -f ~/Downloads/config/percustomized_files/.p10k.zsh "$HOME/.p10k.zsh"
            echo "✅ .p10k.zsh applied."
        else
            echo "⚠️ .p10k.zsh not found in zip."
        fi
        ;;
    [nN])
        THEME_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
        if [ ! -d "$THEME_DIR" ]; then
            git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$THEME_DIR"
            echo "✅ Powerlevel10k default theme cloned."
        fi
        ;;
    *)
        echo "❌ Invalid input. Skipping theme setup."
        ;;
esac

if command -v fzf >/dev/null; then
    echo "fzf is already installed ✅"
else
    echo "fzf is not installed ❌"
    echo "Installing fzf via yay..."
    yay -S --noconfirm fzf
fi

source ~/.zshrc
echo "🎉 Setup complete. Please restart your terminal or run 'zsh' to begin."

