[[ -f ~/.zsh/alias.zsh ]] && source ~/.zsh/alias.zsh
[[ -f ~/.zsh/functions.zsh ]] && source ~/.zsh/functions.zsh
[[ -f ~/.zsh/starship.zsh ]] && source ~/.zsh/starship.zsh

#Add-On

#brew
[[ -f $(which brew) ]] && source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
[[ -f $(which brew) ]] && source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#apt
[[ -d /usr/share/zsh-autosuggestions ]] && source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
[[ -d /usr/share/zsh-syntax-highlighting ]] && source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#pacman
[[ -d /usr/share/zsh/plugins/zsh-autosuggestions ]] && source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
[[ -d /usr/share/zsh/plugins/zsh-syntax-highlighting ]] && source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


# on login
echo
neofetch

# Load Starship
eval "$(starship init zsh)"
