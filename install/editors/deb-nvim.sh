#Install NEOVIM---------------------------------------------------------------------

#download and link appimage-----
cd ~
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage --appimage-extract
sudo rm -rf nvim.appimage
./squashfs-root/AppRun --version
sudo mv squashfs-root /squashfs-root
sudo ln -s /squashfs-root/AppRun /usr/local/bin/nvim


#Install Dependencies---------------------------------------------------------------

# Install NeoVim Providers------
python3 -m pip install pynvim
sudo npm install -g neovim
