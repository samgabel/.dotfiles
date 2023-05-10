#!/bin/bash
set -e


#Install PACKAGES-------------------------------------------------------------------
curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash - &&\
sudo apt install -y zsh exa stow zsh-autosuggestions zsh-syntax-highlighting neofetch nodejs pip python3.10-venv

#Install STARSHIP----
cd ~
curl -sS https://starship.rs/install.sh | sudo sh -s -- -y


#Install NEOVIM---------------------------------------------------------------------

#download and link appimage
cd ~
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage --appimage-extract
sudo rm -rf nvim.appimage
./squashfs-root/AppRun --version
sudo mv squashfs-root /
sudo ln -s /squashfs-root/AppRun /usr/local/bin/nvim

#Install NVCHAD----
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
rm -rf ~/.config/nvim/lua/custom


#Config EVERYTHING------------------------------------------------------------------
# sudo apt install -y pip
# sudo apt install -y python3.10-venv
python3 -m pip install pynvim
sudo npm install -g neovim

#stow----
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
  echo "Reload session or run exec zsh"
else
  echo "ZSH is already set as the default shell!."
fi
