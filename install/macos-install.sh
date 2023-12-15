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
declare -a packages=("exa" "stow" "starship" "zsh-autosuggestions" "zsh-syntax-highlighting" "neofetch" "neovim" "python3" "nvm" "btop")

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


#NEOVIM-------------------------------------------------------------------

echo "##################################################################################################################"
echo "INSTALLING NEOVIM!!"

cd ~/.dotfiles/install/editors
./deb-lvim.sh


#CONFIG-------------------------------------------------------------------

echo "##################################################################################################################"
echo "CONFIGURING!!"

# Check for a compatible Nerd Font
if ! command -v gf >/dev/null; then
  echo "A Nerd Font is required for this to work"
  echo "List of Nerd Fonts: https://www.nerdfonts.com/font-downloads"
  echo "Brew Install instructions: https://gist.github.com/davidteren/898f2dcccd42d9f8680ec69a3a5d350e"
else
  echo "Nerd Font is installed."
fi

echo "##################################################################################################################"

# Set ZSH as the default shell
if [ "$SHELL" != "$(which zsh)" ]; then
  echo "Setting ZSH as default shell..."
  sudo chsh -s $(which zsh) $USER
  echo "Reload session or run exec zsh"
else
  echo "ZSH is already set as the default shell!."
fi
