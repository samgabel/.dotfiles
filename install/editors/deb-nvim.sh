#Install NEOVIM---------------------------------------------------------------------

#download and link appimage-----
cd ~
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage --appimage-extract
sudo rm -rf nvim.appimage
./squashfs-root/AppRun --version
sudo mv squashfs-root /
sudo ln -s /squashfs-root/AppRun /usr/local/bin/nvim

#Install NVCHAD-----------------
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
rm -rf ~/.config/nvim/lua/custom






#Config EVERYTHING------------------------------------------------------------------

# Install NeoVim Providers------
python3 -m pip install pynvim
sudo npm install -g neovim

# Stow--------------------------
cd ~/.dotfiles
stow nvim
stow zsh
