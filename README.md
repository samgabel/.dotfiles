# Hi, there! 👋

These are my personal dotfiles used for MacOS[intel]


![MacOS Setup](https://github.com/SamG331/.dotfiles-macos/blob/main/MacOS-Config-IMG.png?raw=true) 


### Packages (with brew)
**Terminal**
- stow
- starship
- exa
- zsh-autosuggestions
- zsh-syntax-highlighting

**Editor**
- neovim (NvChad)
- npm
- python
<br>

## Installation Instructions

1) **Clone** this git repository to your home directory and then run
'installation.sh' in the .dotfile-macos directory

2) Make sure you have **iTerm2** already installed

3) Make sure you have and are using a **compatible NerdFont** on iTerm2, I am using a custom font**"Liga SF Mono Nerd Font"**
- ***⌘+,*** | to enter into iTerm Settings
- Under ***Profiles => Text => Font***

### Debian-based NeoVim Install Script

- Will install everything necessary for NeoVim with NvChad
- Do `:checkhealth` to see if everything is operating correctly (may need a newer nodejs version for lsp)
<br>

## Troubeshooting

- Make sure that you see if that the configuration in ***$HOME*** have been correctly symlinked by "stow"

