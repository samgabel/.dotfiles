# For Testing -------
# zmodload zsh/zprof
#--------------------

# INITIALIZE --------------------------------------------------------------------------------------

### compinit initialize
### says that this should be loaded after FPATH, but for the sake of fzf-tab this is the best location
### if there are any problems (completions not loading) then run `rm -f ~/.zcompdump; compinit`
autoload -Uz compinit && compinit -C

### source zsh configs
files_to_source=(
    # ZSH
    ~/.zsh/alias.zsh
    ~/.zsh/functions.zsh
    ~/.zsh/starship.zsh
    # SECRETS
    ~/Secrets/env/secrets.zsh
    # FZF-TAB
    ~/.config/fzf/fzf-tab/fzf-tab.plugin.zsh
)
for file in "${files_to_source[@]}"; do
    [[ -f "$file" ]] && source "$file"
done


## ENV exports ----------------------------------
export NVM_DIR="$HOME/.nvm"


# ZSH STYLING -------------------------------------------------------------------------------------

## FZF-tab --------------------------------------
### makes tab completions case-insensitive
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
### disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
### set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
### set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
### set preview-box size
zstyle ':fzf-tab:complete:vim:*' fzf-min-height '50'
zstyle ':fzf-tab:complete:*:*' fzf-pad '50'
### switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'
### preview directory's content with eza when completing with...
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -a -1 --color=always --icons --group-directories-first $realpath'
zstyle ':fzf-tab:complete:bat:*' fzf-preview 'eza -a -1 --color=always --icons --group-directories-first $realpath'
zstyle ':fzf-tab:complete:vim:*' fzf-preview \
    'mime=$(file -bL --mime-type "$realpath")
    category=${mime%%/*}
    kind=${mime##*/}
    if [[ -d $realpath ]]; then
        eza -a -1 --color=always --icons --group-directories-first $realpath
    elif [[ "$category" = image ]]; then
        chafa $realpath
    elif [[ "$category" = binary ]]; then
        hex $realpath
    elif [ "$category" = text ]; then
        bat --decorations=never --color=always $realpath
    else
        bat --decorations=never --color=always $realpath
    fi'


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
  export XDG_CONFIG_HOME="$HOME/.config"
  ### zsh-add-ons
  source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
  ### pass-store
  export PASSWORD_STORE_DIR=/Users/samgabel/Secrets/pass
  ### nvm -> node-version-manager
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh" --no-use  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
  ### frum -> ruby-version-manager
  # TODO: find a way to handle this better
  # eval "$(frum init)"
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
