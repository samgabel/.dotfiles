# For Testing -------
# zmodload zsh/zprof
#--------------------

# INITIALIZE --------------------------------------------------------------------------------------

### source zsh configs
[[ -f ~/.zsh/alias.zsh && \
   -f ~/.zsh/functions.zsh && \
   -f ~/.zsh/starship.zsh ]] && \
   source ~/.zsh/alias.zsh && source ~/.zsh/functions.zsh && source ~/.zsh/starship.zsh
### source secrets configs
[[ -f ~/Secrets/env/secrets.zsh ]] && \
   source ~/Secrets/env/secrets.zsh
### source fzf-tab plugin
[[ -f ~/.config/fzf-tab/fzf-tab.plugin.zsh ]] && \
   source ~/.config/fzf-tab/fzf-tab.plugin.zsh

## ENV exports ----------------------------------
export NVM_DIR="$HOME/.nvm"


# ZSH STYLING -------------------------------------------------------------------------------------

### compinit initialize
autoload -Uz compinit && compinit -C

## Styling --------------------------------------
### makes tab completions case-insensitive
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
### disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
### set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
### set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
### preview directory's content with eza when completing with...
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -a -1 --color=always --icons --group-directories-first $realpath'
zstyle ':fzf-tab:complete:vim:*' fzf-preview 'eza -a -1 --color=always --icons --group-directories-first $realpath'
zstyle ':fzf-tab:complete:bat:*' fzf-preview 'eza -a -1 --color=always --icons --group-directories-first $realpath'
### switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'

# MAC-OS ------------------------------------------------------------------------------------------

if [[ "$OSTYPE" == "darwin"* ]]; then
  ### (a) gpg-agent
  # export GPG_TTY="$(tty)"
  # export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  # gpgconf --launch gpg-agent
  ##### no longer in use^, reinstate if back to using YubiKey for git signing
  ### (b) 1password agent
  # export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
  ##### no need for above^ we specified the agent in the .ssh/config which is used by .gitconfig for signing
  ### zsh-add-ons
  source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  fpath+=/usr/local/share/zsh/site-functions
  ### pass-store
  export PASSWORD_STORE_DIR=/Users/samgabel/Secrets/pass
  ### nvm
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh" --no-use  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
fi


# LINUX -------------------------------------------------------------------------------------------

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  ### apt
  [[ -d /usr/share/zsh-autosuggestions ]] && source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  [[ -d /usr/share/zsh-syntax-highlighting ]] && source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  ### pacman
  [[ -d /usr/share/zsh/plugins/zsh-autosuggestions ]] && source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
  [[ -d /usr/share/zsh/plugins/zsh-syntax-highlighting ]] && source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  ### nvm
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi


## Set Default Editor ----------------------------
export VISUAL=nvim
export EDITOR="$VISUAL"

## Prompt Line Spacing ---------------------------
precmd() {
  precmd() {
    echo
  }
}

## Load Starship
eval "$(starship init zsh)"

# For Testing-------
# zprof
#-------------------
