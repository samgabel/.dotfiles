#!/bin/bash

#Install NEOVIM----

#prereqs
sudo apt install ninja-build gettext cmake unzip curl
#make
cd ~
git clone https://github.com/neovim/neovim
cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo
git checkout stable
sudo make install
cd ~
rm -rf neovim


#Install NODE----
curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash - &&\
sudo apt install -y nodejs


#Install NVCHAD----
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
rm -rf ~/.config/nvim/lua/custom


#Config----
sudo apt install pip
sudo apt install python3.10-venv
python3 -m pip install pynvim
sudo npm install -g neovim

cd ~/.dotfiles-macos
stow nvim

echo "DONE"
echo "open vim" 
echo ":Mason (to download LSPs)"
echo ":checkhealth (to see if everything is working)"
