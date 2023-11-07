[[ -f ~/.zsh/alias.zsh ]] && source ~/.zsh/alias.zsh
[[ -f ~/.zsh/functions.zsh ]] && source ~/.zsh/functions.zsh
[[ -f ~/.zsh/starship.zsh ]] && source ~/.zsh/starship.zsh
[[ -f ~/Secrets/env/secrets.zsh ]] && source ~/Secrets/env/secrets.zsh

#Add-On

#brew
[[ -f $(which brew) ]] && source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
[[ -f $(which brew) ]] && source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[[ -f $(which brew) ]] && fpath+=/usr/local/share/zsh/site-functions
[[ -f $(which brew) ]] && export PASSWORD_STORE_DIR=/Users/samgabel/Secrets/pass

#apt
[[ -d /usr/share/zsh-autosuggestions ]] && source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
[[ -d /usr/share/zsh-syntax-highlighting ]] && source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#pacman
[[ -d /usr/share/zsh/plugins/zsh-autosuggestions ]] && source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
[[ -d /usr/share/zsh/plugins/zsh-syntax-highlighting ]] && source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#List Highlighting
zstyle ':completion:*' menu select
setopt menu_complete

#NVM
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

#Set Default Editor
export VISUAL=lvim
export EDITOR="$VISUAL"

# Load Starship
eval "$(starship init zsh)"
