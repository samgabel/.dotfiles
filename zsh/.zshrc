# INITIALIZE
[[ -f ~/.zsh/alias.zsh && \
   -f ~/.zsh/functions.zsh && \
   -f ~/.zsh/starship.zsh && \
   -f ~/Secrets/env/secrets.zsh ]] && \
   source ~/.zsh/alias.zsh && source ~/.zsh/functions.zsh && source ~/.zsh/starship.zsh && source ~/Secrets/env/secrets.zsh
#list highlighting
zstyle ':completion:*' menu select
setopt menu_complete
#node version manager (nvm)
export NVM_DIR="$HOME/.nvm"

#------------------------------------------------------------

# MAC OS 

if [[ "$OSTYPE" == "darwin"* ]]; then
  #gpg-agent
  export GPG_TTY="$(tty)"
  export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  gpgconf --launch gpg-agent
  #brew
  if [[ -f $(which brew) ]]; then
    source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    fpath+=/usr/local/share/zsh/site-functions
    export PASSWORD_STORE_DIR=/Users/samgabel/Secrets/pass
  fi
  #nvm
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
fi
#------------------------------------------------------------

# DEBIAN

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  #apt
  [[ -d /usr/share/zsh-autosuggestions ]] && source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  [[ -d /usr/share/zsh-syntax-highlighting ]] && source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  #pacman
  [[ -d /usr/share/zsh/plugins/zsh-autosuggestions ]] && source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
  [[ -d /usr/share/zsh/plugins/zsh-syntax-highlighting ]] && source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  #nvm
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi
#------------------------------------------------------------

# Set Default Editor
export VISUAL=lvim
export EDITOR="$VISUAL"

# Load Starship
eval "$(starship init zsh)"
