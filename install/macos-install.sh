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

#Define Packages------------------
declare -a packages=("eza" "stow" "starship" "zsh-autosuggestions" "zsh-syntax-highlighting" "neovim" "python3" "nvm" "tmux")

#Check ZSH------------------------
if ! command -v zsh >/dev/null; then
  echo "ZSH is not installed. Installing ZSH..."
  brew install zsh
else
  echo "ZSH already installed!."
fi

#Install Packages-----------------
for package in "${packages[@]}"; do
  # check if the package is already installed
  if ! brew ls --versions "$package" >/dev/null; then
    echo "Installing $package..."
    brew install "$package"
  else
    echo "$package is already installed."
  fi
done

#Install Additional---------------
brew bundle install --file=~/.dotfiles/install/extras/Brewfile

#NEOVIM-------------------------------------------------------------------

echo "##################################################################################################################"
echo "INSTALLING NEOVIM!!"

~/.dotfiles/install/editors/deb-lvim.sh


#TMUX---------------------------------------------------------------------

echo "##################################################################################################################"
echo "CONFIGURING TMUX!!"

git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm


#CONFIG-------------------------------------------------------------------

echo "##################################################################################################################"
echo "CONFIGURING!!"

# Stow----------------------------
cd ~/.dotfiles
stow lvim
stow zsh
stow tmux && ~/.config/tmux/plugins/tpm/bin/install_plugins

# Finishing Touches---------------
echo "1) Make sure iTerm2 is installed & ..."
echo "2) Configure General > Preferences > Path=~/.dotfiles/iterm2/"
echo "3) Install apps in extras/manual-install.md"


echo "##################################################################################################################"

# Set ZSH as default shell--------
if [ "$SHELL" != "$(which zsh)" ]; then
  echo "Setting ZSH as default shell..."
  sudo chsh -s $(which zsh) $USER
  echo "Reload session or run exec zsh"
else
  echo "ZSH is already set as the default shell!."
fi
