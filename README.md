# Hi, there! 👋

These are my personal dotfiles used for MacOS[intel]


![MacOS Setup](https://github.com/SamG331/.dotfiles-macos/blob/main/MacOS-Config-IMG.png?raw=true) 


## Installation Instructions

1) **Clone** this git repository to your home directory and then run
either 'macos-install.sh' in the ~/.dotfiles/install directory

2) Make sure you have **iTerm2** already installed

3) Make sure you have and are using a **compatible NerdFont** on iTerm2, I am using a custom font**"Liga SF Mono Nerd Font"**
- ***⌘+,*** | to enter into iTerm Settings
- under ***Profiles => "Other Actions" (bottom left) => "Import JSON Profiles"***
- use `iterm-profile.json` in the `install/extras/` directory
- also see `manual-install.txt` for software not installed by brew

4) To load the Tmux config and plugins, first start a new Tmux session then navigate to ~/.config/tmux/tmux.conf and enter in with vim. 
- press the Tmux leader key (ctrl + b) followed by (shift + i). 
- exit out of vim and then run `tmux source-file ~/.config/tmux/tmux.conf`
- press leader key and type `:kill-server` and then start a new tmux session 

## Troubeshooting

- Make sure that you see if that the configuration in ***$HOME*** have been correctly symlinked by "stow"

