#!/bin/bash
# === Step 1: Install zsh and fastfetch ===
sudo pacman -S --noconfirm fastfetch
unzip -o ~/Downloads/Customized-WezTerminal/config/percustomized_files.zip -d ~/Downloads/Customized-WezTerminal/config/
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
mv -f ~/Downloads/Customized-WezTerminal/config/config.jsonc "$FASTFETCH_DIR/"
mv -f ~/Downloads/Customized-WezTerminal/config/try2.png "$FASTFETCH_DIR/"
mv -f ~/Downloads/Customized-WezTerminal/config/backup "$FASTFETCH_DIR/"
echo "✅ Fastfetch config moved."

# === Step 8: Wezterm Config ===
WEZTERM_DIR="$HOME/.config/wezterm"
mkdir -p "$WEZTERM_DIR"
mv -f ~/Downloads/Customized-WezTerminal/config/wezterm.lua "$WEZTERM_DIR/"
echo "✅ Wezterm config moved."

# === Step 9: Unzip and move .zshrc ===
if [ -f ~/Downloads/Customized-WezTerminal/config/percustomized_files.zip ]; then
    rm -f "$HOME/.zshrc"
    mv -f ~/Downloads/Customized-WezTerminal/config/percustomized_files/.zshrc "$HOME/.zshrc"
    echo "✅ .zshrc updated from zip."
else
    echo "⚠️ Zip file not found."
fi

# === Step 10: Prompt for custom Powerlevel10k ===

read -rp "Do you want to apply the pre-customized Powerlevel10k theme? (y/n): " answer

THEME_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
CUSTOM_P10K="$HOME/Downloads/Customized-WezTerminal/config/percustomized_files/.p10k.zsh"

case "$answer" in
    [yY])
        echo "🎨 Applying pre-customized Powerlevel10k theme..."
        if [ -f "$CUSTOM_P10K" ]; then
            if [ ! -d "$THEME_DIR" ]; then
                git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$THEME_DIR"
            fi
            mv -f "$CUSTOM_P10K" "$HOME/.p10k.zsh"
            echo "✅ Custom .p10k.zsh applied successfully."
        else
            echo "⚠️  Custom .p10k.zsh not found in: $CUSTOM_P10K"
        fi
        ;;
    [nN])
        echo "💠 Installing default Powerlevel10k theme..."
        if [ ! -d "$THEME_DIR" ]; then
            git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$THEME_DIR"
            echo "✅ Powerlevel10k default theme cloned."
        else
            echo "ℹ️  Powerlevel10k already installed."
        fi
        ;;
    *)
        echo "❌ Invalid input. Skipping theme setup."
        ;;
esac

# === Step 11: Check and install fzf ===
if command -v fzf >/dev/null 2>&1; then
    echo "✅ fzf is already installed."
else
    echo "⚙️  fzf is not installed. Installing via yay..."
    if command -v yay >/dev/null 2>&1; then
        yay -S --noconfirm fzf
    else
        echo "❌ 'yay' not found. Please install fzf manually or install yay first."
    fi
fi

echo ""
echo "🎉 Setup complete!"
echo "➡️  Restarting your terminal to apply changes..."

# === Step 12: Restart terminal ===
sleep 2
exec zsh
