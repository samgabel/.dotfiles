#!/bin/bash

# ADD Repos --------------------------------------------------------------

## Make sure gpg is installed
sudo apt update
sudo apt install -y gpg

## Lazygit Repo
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm lazygit*

## EZA Repo
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list

## Update APT Repos List
sudo apt update


# INSTALL Packages -------------------------------------------------------

sudo apt install -y zsh eza stow zsh-autosuggestions zsh-syntax-highlighting neofetch btop fzf tldr pip python3.10-venv cargo bat zip ripgrep

## Install STARSHIP
curl -sS https://starship.rs/install.sh | sudo sh -s -- -y
rm -f install.sh

## Install NVM
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash

## Fix Bat Path
mkdir -p ~/.local/bin
ln -s /usr/bin/batcat ~/.local/bin/bat


# INSTALL Neovim ---------------------------------------------------------

#download and link appimage
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage --appimage-extract
sudo rm -rf nvim.appimage
./squashfs-root/AppRun --version
sudo mv squashfs-root /squashfs-root
sudo ln -s /squashfs-root/AppRun /usr/local/bin/nvim

# Install NeoVim Providers
python3 -m pip install pynvim
source "$HOME"/.nvm/nvm.sh
nvm install 20
npm install -g neovim
