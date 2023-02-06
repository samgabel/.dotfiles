# --------Install homebrew, packages, and stow (create symlinks)---------

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
  echo "ZSH already installed."
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

# stow
echo "\nStowing ZSH Configurations..."
stow zsh
echo "Stowing VIM Configurations..."
stow vim

echo "################################################"

# Check for a compatible Nerd Font
if ! command -v gf >/dev/null; then
  echo "\nNerd Font is not installed."
  echo "\nList of Nerd Fonts: \nhttps://www.nerdfonts.com/font-downloads
  echo "Brew Install instructions: \nhttps://gist.github.com/davidteren/898f2dcccd42d9f8680ec69a3a5d350e"
else
  echo "Nerd Font is installed."
fi

# Set ZSH as the default shell
if [ "$SHELL" != "/bin/zsh" ]; then
  echo "Setting ZSH as default shell..."
  chsh -s $(which zsh)
else
  echo "ZSH is already set as the default shell."
fi

