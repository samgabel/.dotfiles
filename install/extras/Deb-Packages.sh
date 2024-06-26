#!/bin/bash

# ADD Repos --------------------------------------------------------------

## Make sure gpg is installed
sudo apt update
sudo apt install -y gpg wget curl

## EZA Repo
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list

## MISE Repo
sudo install -dm 755 /etc/apt/keyrings
wget -qO - https://mise.jdx.dev/gpg-key.pub | gpg --dearmor | sudo tee /etc/apt/keyrings/mise-archive-keyring.gpg 1> /dev/null
echo "deb [signed-by=/etc/apt/keyrings/mise-archive-keyring.gpg arch=amd64] https://mise.jdx.dev/deb stable main" | sudo tee /etc/apt/sources.list.d/mise.list

# INSTALL Packages -------------------------------------------------------

sudo apt update
sudo apt install -y zsh eza mise stow zsh-autosuggestions zsh-syntax-highlighting neofetch btop fzf tldr pip python3.10-venv bat zip ripgrep libssl-dev

## Install RUSTUP
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

## Install STARSHIP
curl -sS https://starship.rs/install.sh | sudo sh -s -- -y
rm -f install.sh

## Fix Bat Path
sudo ln -s /usr/bin/batcat /usr/local/bin/bat

## Install Lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm lazygit*

# INSTALL Neovim ---------------------------------------------------------

# Download and link appimage
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage --appimage-extract
sudo rm -rf nvim.appimage
./squashfs-root/AppRun --version
sudo mv squashfs-root /squashfs-root
sudo ln -s /squashfs-root/AppRun /usr/local/bin/nvim

# Install NeoVim Providers
python3 -m pip install pynvim
mise use --global usage
mise use --global node@lts
mise exec -- npm install -g neovim
