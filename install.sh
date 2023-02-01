# install homebrew package manager
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# install packages
brew install \
  zsh \
  stow \
  exa \
  starship \
  zsh-autocorrections \
  zsh-syntac-highliting

# stow
stow zsh
stow vim

# make zsh default shell
chsh $(which zsh)
