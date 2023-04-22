#!/bin/bash

# --------Install homebrew, packages, and stow (create symlinks)---------
# ONLY RUN IF ON MACOS

# Define the packages to be installed
declare -a packages=("exa" "stow" "starship" "zsh-autosuggestions" "zsh-syntax-highlighting" "neofetch" "neovim" "python3" "node")

# check if Homebrew is installed
if ! command -v brew >/dev/null; then
  echo "Homebrew is not installed. Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
else
  echo "Homebrew already installed!"
fi

echo "################################################"

# check if ZSH is installed
if ! command -v zsh >/dev/null; then
  echo "ZSH is not installed. Installing ZSH..."
  brew install zsh
else
  echo "ZSH already installed!."
fi

# loop through the packages array
for package in "${packages[@]}"; do
  # check if the package is already installed
  if ! brew ls --versions "$package" >/dev/null; then
    echo "Installing $package..."
    brew install "$package"
  else
    echo "$package is already installed."
  fi
done

echo "################################################"

#NvChad Installation & remove custom default files
echo "B-R-U-H (NvChad)"

rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim

git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1

rm -rf ~/.config/nvim/lua/custom/

echo "################################################"

# stow
echo "Stowing ZSH Configurations..."
stow zsh
echo "Stowing neoVIM Configurations..."
stow nvim

echo "################################################"

# Check for a compatible Nerd Font
if ! command -v gf >/dev/null; then
  echo "A Nerd Font is required for this to work"
  echo "List of Nerd Fonts: https://www.nerdfonts.com/font-downloads"
  echo "Brew Install instructions: https://gist.github.com/davidteren/898f2dcccd42d9f8680ec69a3a5d350e"
else
  echo "Nerd Font is installed."
fi

echo "################################################"

# Set ZSH as the default shell
if [ "$SHELL" != "/bin/zsh" ]; then
  echo "Setting ZSH as default shell..."
  chsh -s "$(which zsh)"
  exec zsh
else
  echo "ZSH is already set as the default shell!."
fi

