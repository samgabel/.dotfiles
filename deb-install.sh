#!/bin/bash

#Install ZSH--------------------------------------------------------------------
sudo apt install -y zsh
sudo apt install -y exa stow zsh-autosuggestions zsh-syntax-highlighting neofetch

#Install STARSHIP----
cd ~
curl -sS https://starship.rs/install.sh | sh
rm ~/install.sh


#Install NEOVIM-----------------------------------------------------------------

#prereqs
sudo apt install -y ninja-build gettext cmake unzip curl
#make
cd ~
git clone https://github.com/neovim/neovim
cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo
git checkout stable
sudo make install
rm -rf ~/neovim


#Install NODE----
cd ~
curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash - &&\
sudo apt install -y nodejs


#Install NVCHAD----
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
rm -rf ~/.config/nvim/lua/custom


#Config----
sudo apt install -y pip
sudo apt install -y python3.10-venv
python3 -m pip install pynvim
sudo npm install -g neovim

cd ~/.dotfiles
stow zsh
stow nvim

echo "################################################"

echo "DONE"
echo "open vim"
echo ":Mason (to download LSPs)"
echo ":checkhealth (to see if everything is working)"

echo "################################################"

# Set ZSH as the default shell
if [ "$SHELL" != "/bin/zsh" ]; then
  echo "Setting ZSH as default shell..."
  chsh -s "$(which zsh)"
  echo "Please retart terminal session to apply chsh settings"
else
  echo "ZSH is already set as the default shell!."
fi
