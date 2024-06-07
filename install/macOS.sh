#!/bin/bash
set -e

                     # --------Install homebrew, packages, and stow (create symlinks)---------
                                            # ONLY RUN IF ON MACOS



echo "  ______                        __               _______             __      ______  __ __                    "
echo " /      \                      |  \             |       \           |  \    /      \|  \  \                   "
echo "|  ▓▓▓▓▓▓\ ______  ______ ____ | ▓▓ _______     | ▓▓▓▓▓▓▓\ ______  _| ▓▓_  |  ▓▓▓▓▓▓\\▓▓ ▓▓ ______   _______  "
echo "| ▓▓___\▓▓|      \|      \    \ \▓ /       \    | ▓▓  | ▓▓/      \|   ▓▓ \ | ▓▓_  \▓▓  \ ▓▓/      \ /       \ "
echo " \▓▓    \  \▓▓▓▓▓▓\ ▓▓▓▓▓▓\▓▓▓▓\  |  ▓▓▓▓▓▓▓    | ▓▓  | ▓▓  ▓▓▓▓▓▓\\▓▓▓▓▓▓ | ▓▓ \   | ▓▓ ▓▓  ▓▓▓▓▓▓\  ▓▓▓▓▓▓▓ "
echo " _\▓▓▓▓▓▓\/      ▓▓ ▓▓ | ▓▓ | ▓▓   \▓▓    \     | ▓▓  | ▓▓ ▓▓  | ▓▓ | ▓▓ __| ▓▓▓▓   | ▓▓ ▓▓ ▓▓    ▓▓\▓▓    \  "
echo "|  \__| ▓▓  ▓▓▓▓▓▓▓ ▓▓ | ▓▓ | ▓▓   _\▓▓▓▓▓▓\    | ▓▓__/ ▓▓ ▓▓__/ ▓▓ | ▓▓|  \ ▓▓     | ▓▓ ▓▓ ▓▓▓▓▓▓▓▓_\▓▓▓▓▓▓\ "
echo " \▓▓    ▓▓\▓▓    ▓▓ ▓▓ | ▓▓ | ▓▓  |       ▓▓    | ▓▓    ▓▓\▓▓    ▓▓  \▓▓  ▓▓ ▓▓     | ▓▓ ▓▓\▓▓     \       ▓▓ "
echo "  \▓▓▓▓▓▓  \▓▓▓▓▓▓▓\▓▓  \▓▓  \▓▓   \▓▓▓▓▓▓▓      \▓▓▓▓▓▓▓  \▓▓▓▓▓▓    \▓▓▓▓ \▓▓      \▓▓\▓▓ \▓▓▓▓▓▓▓\▓▓▓▓▓▓▓  "
echo



#HOMEBREW-----------------------------------------------------------------

echo "##################################################################################################################"
echo "INSTALLING HOMEBREW!!"

#Install Homebrew-----------------
if ! command -v brew >/dev/null; then
  echo "Homebrew is not installed. Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
else
  echo "Homebrew already installed!"
fi


#PACKAGES-----------------------------------------------------------------

echo "##################################################################################################################"
echo "INSTALLING PACKAGES!!"

#Install Packages---------------
brew bundle install --file=~/.dotfiles/install/extras/Brewfile

#Install Git Repos--------------
~/.dotfiles/install/extras/add-plugins-git.sh


#CONFIG-------------------------------------------------------------------

echo "##################################################################################################################"
echo "CONFIGURING!!"

# Stow----------------------------
cd ~/.dotfiles
stow nvim
stow zsh
stow tmux && ~/.config/tmux/plugins/tpm/bin/install_plugins

# Mise----------------------------
mise use --global usage
mise use --global node@lts
mise use --global go
mise exec -- npm install -g neovim

# Finishing Touches---------------
echo "1) Make sure iTerm2 is installed & ..."
echo "2) Configure General » Preferences » Path=~/.dotfiles/iterm2/"


echo "##################################################################################################################"

# Set ZSH as default shell--------
if [ "$SHELL" != "$(which zsh)" ]; then
  echo "Setting ZSH as default shell..."
  sudo chsh -s $(which zsh) $USER
  echo "Reload session or run exec zsh"
else
  echo "ZSH is already set as the default shell!."
fi
