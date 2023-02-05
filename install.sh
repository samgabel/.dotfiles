# --------Install homebrew, packages, and stow (create symlinks)---------


# define the packages to be installed
declare -a packages=("stow" "exa" "starship" "zsh-autosuggestions" "zsh-syntax-highlighting")


# check if Homebrew is installed
if ! command -v brew >/dev/null; then
  echo "Homebrew is not installed. Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
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


# stow
echo "Stowing ZSH Configurations..."
stow zsh
echo "Stowing VIM Configurations..."
stow vim
