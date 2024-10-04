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
sudo apt install -y zsh eza mise stow zsh-autosuggestions zsh-syntax-highlighting btop tldr pip cargo python3.10-venv bat zip ripgrep libssl-dev

## Fix Bat Path
sudo ln -s /usr/bin/batcat /usr/local/bin/bat

## Install Lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm lazygit*

# INSTALL Neovim ---------------------------------------------------------

mise use --global neovim@0.9.5

# Install NeoVim Providers
python3 -m pip install pynvim
mise use --global usage
mise use --global node@lts
mise use --global go
mise exec -- npm install -g neovim
