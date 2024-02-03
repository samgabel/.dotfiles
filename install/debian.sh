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

#Install Packages------------
~/.dotfiles/install/extras/Deb-Packages.sh

#Install Git Repos-----------
~/.dotfiles/install/extras/add-plugins-git.sh


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
