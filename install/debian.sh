#!/bin/bash
set -e



echo "  ______                        __               _______             __      ______  __ __                    "
echo " /      \                      |  \             |       \           |  \    /      \|  \  \                   "
echo "|  ▓▓▓▓▓▓\ ______  ______ ____ | ▓▓ _______     | ▓▓▓▓▓▓▓\ ______  _| ▓▓_  |  ▓▓▓▓▓▓\\▓▓ ▓▓ ______   _______  "
echo "| ▓▓___\▓▓|      \|      \    \ \▓ /       \    | ▓▓  | ▓▓/      \|   ▓▓ \ | ▓▓_  \▓▓  \ ▓▓/      \ /       \ "
echo " \▓▓    \  \▓▓▓▓▓▓\ ▓▓▓▓▓▓\▓▓▓▓\  |  ▓▓▓▓▓▓▓    | ▓▓  | ▓▓  ▓▓▓▓▓▓\\▓▓▓▓▓▓ | ▓▓ \   | ▓▓ ▓▓  ▓▓▓▓▓▓\  ▓▓▓▓▓▓▓ "
echo " _\▓▓▓▓▓▓\/      ▓▓ ▓▓ | ▓▓ | ▓▓   \▓▓    \     | ▓▓  | ▓▓ ▓▓  | ▓▓ | ▓▓ __| ▓▓▓▓   | ▓▓ ▓▓ ▓▓    ▓▓\▓▓    \  "
echo "|  \__| ▓▓  ▓▓▓▓▓▓▓ ▓▓ | ▓▓ | ▓▓   _\▓▓▓▓▓▓\    | ▓▓__/ ▓▓ ▓▓__/ ▓▓ | ▓▓|  \ ▓▓     | ▓▓ ▓▓ ▓▓▓▓▓▓▓▓_\▓▓▓▓▓▓\ "
echo " \▓▓    ▓▓\▓▓    ▓▓ ▓▓ | ▓▓ | ▓▓  |       ▓▓    | ▓▓    ▓▓\▓▓    ▓▓  \▓▓  ▓▓ ▓▓     | ▓▓ ▓▓\▓▓     \       ▓▓ "
echo "  \▓▓▓▓▓▓  \▓▓▓▓▓▓▓\▓▓  \▓▓  \▓▓   \▓▓▓▓▓▓▓      \▓▓▓▓▓▓▓  \▓▓▓▓▓▓    \▓▓▓▓ \▓▓      \▓▓\▓▓ \▓▓▓▓▓▓▓\▓▓▓▓▓▓▓  "



#Install PACKAGES-------------------------------------------------------------------

echo "##################################################################################################################"
echo "INSTALLING PACKAGES!!"

~/.dotfiles/install/extras/add-repos-debian.sh
sudo apt install -y zsh eza stow zsh-autosuggestions zsh-syntax-highlighting neofetch btop fzf tldr pip python3.10-venv cargo
~/.dotfiles/install/extras/add-plugins-git.sh

#Install STARSHIP----
cd ~
curl -sS https://starship.rs/install.sh | sudo sh -s -- -y
rm -f install.sh

#Install NVM---------
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash


#Install NEOVIM---------------------------------------------------------------------

echo "##################################################################################################################"
echo "INSTALLING NEOVIM!!"

~/.dotfiles/install/editors/deb-nvim.sh


#CONFIG-------------------------------------------------------------------

echo "##################################################################################################################"
echo "CONFIGURING!!"

#Stow----------------
cd ~/.dotfiles
stow nvim
stow zsh
stow tmux && ~/.config/tmux/plugins/tpm/bin/install_plugins

#Health--------------
echo "DONE"
echo "open vim"
echo ":checkhealth (to see if everything is working)"

echo "##################################################################################################################"

# Set ZSH as the default shell
if [ "$SHELL" != "$(which zsh)" ]; then
  echo "Setting ZSH as default shell..."
  sudo chsh -s "$(which zsh)" "$USER"
  cd /home/"$USER"/
  rm -f .bash* .profile
  echo "Reload session or run exec zsh"
else
  echo "ZSH is already set as the default shell!."
fi
