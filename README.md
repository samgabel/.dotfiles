# Hi, there! 👋

These are my personal dotfiles used for MacOS[intel]


![MacOS Setup](https://github.com/SamG331/.dotfiles/blob/main/MacOS-Config-IMG.png?raw=true) 


## Installation Instructions

1) **Clone** this git repository to your home directory and then run
either script in ~/.dotfiles/install

2) Make sure **iTerm2** was successfully installed and open it;
open preferences and under General -> Preferences and change the path to ~/.dotfiles/iterm2

## Troubeshooting

- Make sure that you see if that the configurations have been correctly symlinked by "stow"
- Make sure that iTerm2 is installed (the install script should do this with brew)
- See that a compatible NerdFont is being used if icons show up as question marks

## Self Notes

- [Brewfile](https://gist.github.com/ChristopherA/a579274536aab36ea9966f301ff14f3f):
    ```sh
    # Installing Brewfile
    brew bundle --file=~/.dotfiles/install/extras/Brewfile 

    # Creating/Updating Brewfile
    brew bundle dump --file=~/.dotfiles/install/extras/Brewfile

    # Cleaning up system to match Brewfile
    brew bundle cleanup --file=~/.dotfiles/install/extras/Brewfile
    ```
