#INSTALL LUNARVIM---------------------------------------------------------------------

# Install NeoVim----------------
cd ~
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage --appimage-extract
sudo rm -rf nvim.appimage
./squashfs-root/AppRun --version
sudo mv squashfs-root /
sudo ln -s /squashfs-root/AppRun /usr/local/bin/nvim

# Install dependencies----------
cd ~
wget https://github.com/jesseduffield/lazygit/releases/download/v0.38.1/lazygit_0.38.1_Linux_x86_64.tar.gz
tar xf lazygit_0.38.1_Linux_x86_64.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm -f lazygit*

# Install LunarVim--------------
yes | LV_BRANCH='release-1.3/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh) --auto-accept
sudo mv /home/$USER/.local/bin/lvim /usr/local/bin
rm -f /home/$USER/.config/lvim/custom.lua

#CONFIG EVERYTHING--------------------------------------------------------------------

# Install NeoVim Providers------
python3 -m pip install pynvim
sudo npm install -g neovim

# Stow--------------------------
cd ~/.dotfiles
stow lvim
stow zsh
