#!/bin/zsh
pacman -S fastfetch

yay -S zsh

echo "zsh is installed sucessfully!"

touch ~/.zshrc

echo "Your zsh fie has been created !"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

repo_url="git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions"

git clone "repo_url"

echo "Repo is cloned"

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

echo "file is updated!"

syntax_highliting="https://github.com/zsh-users/zsh-syntax-highlighting.git"

git clone "syntax_highliting"

${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo "Syntax highliting is downloaded!"

plugins=( [plugins...] zsh-syntax-highlighting)

#!/bin/bash

if command -v yay &> /dev/null; then
    yay powerlevel10k
else
    sudo pacman -S yay
    yay powerlevel10k
fi

folder_path="~/.config/fastfetch"

if [ -d "$folder_path" ]; then
    echo "Folder exists at $folder_path"
    mv ~/Downloads/config/config.jsonc ~/.config/fastfetch
    mv ~/Downloads/config/try2.png ~/.config/fastfetch
    mv ~/Downloads/config/backup ~/.config/fastfetch
else
    echo "Folder does not exist at $folder_path"
    echo "Creating the folder"
    mkdir ~/.config/fastfetch
    mv ~/Downloads/config/config.jsonc ~/.config/fastfetch
    mv ~/Downloads/config/try2.png ~/.config/fastfetch
    mv ~/Downloads/config/backup ~/.config/fastfetch
fi

folder_path1="~/.config/wezterm"

if [ -d "$folder_path1" ]; then
    echo "Folder exists at $folder_path1"
    mv ~/Downloads/config/wezterm.lua ~/.config/wezterm
else
    echo "Folder does not exist at $folder_path1"
    mkdir ~/.config/wezterm
    mv ~/Downloads/config/wezterm.lua ~/.config/wezterm
fi

mv ~/Downloads/config/.zshrc ~/.zshrc

oh_my_zsh=git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
oh_my_zsh

