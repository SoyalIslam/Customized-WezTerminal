# ⚡ Customized WezTerminal Setup

This repository contains a fully customized and automated configuration setup for [WezTerm](https://wezfurlong.org/wezterm/), [Zsh](https://www.zsh.org/), Oh My Zsh, Powerlevel10k, and useful plugins like autosuggestions and syntax highlighting — designed for Arch Linux users.

---

## 🧰 Features

- ✨ Pre-configured **WezTerm** with a custom `wezterm.lua`
- 🖥️ **Zsh shell** with Oh My Zsh framework
- 🚀 Powerlevel10k theme support (custom and default)
- 🔌 Includes:
  - `zsh-autosuggestions`
  - `zsh-syntax-highlighting`
- 🧪 Fastfetch with custom assets (logo + config)
- 🗂️ Fully automated install script

---

## 📦 Prerequisites

Ensure the following are installed:

- ✅ Arch Linux or an Arch-based distro
- ✅ [`yay`](https://github.com/Jguer/yay) AUR helper
- ✅ `git`, `curl`, and `unzip`

---

## 🚀 Installation
## ⚠️ Must Clone in  Downloads folder in Your System

1. **Clone the repository**
   ```bash
   cd Downloads
   git clone https://github.com/SoyalIslam/Customized-WezTerminal.git
   cd Customized-WezTerminal/config
   chmod +x installation_zsh_wezterm.sh
   ./installation_zsh_wezterm.sh
   
## 🧭 Set Zsh as Default Shell

After running the installation script, you can make Zsh your default shell so that every new terminal session automatically uses it.

## 🧩 Steps:

Check your current shell

```echo $SHELL```


If it shows something like /bin/bash, that means Bash is still the default.

Find the Zsh binary path

```which zsh```


Usually, it’s /usr/bin/zsh.

Change the default shell to Zsh

```chsh -s $(which zsh)```


## 💡 You’ll be asked to enter your password.

Restart your terminal

Close and reopen your terminal, or log out and back in.

You should now see the Powerlevel10k configuration wizard appear automatically on first launch.

Verify it worked

```echo $SHELL```


Output should now be /usr/bin/zsh.
