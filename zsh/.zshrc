# For Testing -------
# zmodload zsh/zprof
#--------------------

# Source ZSH Configs
files_to_source=(
    ~/.zsh/plugins.zsh
    ~/.zsh/alias.zsh
    ~/.zsh/functions.zsh
    ~/.zsh/starship.zsh
    ~/Secrets/env/secrets.zsh
)
for file in "${files_to_source[@]}"; do
    [[ -f "$file" ]] && source "$file"
done

# Exports
export GOPATH=~/.go
export VISUAL=nvim
export EDITOR="$VISUAL"

# Keybindings
bindkey -v                              # sets the command line editing style to vi mode
bindkey '^k' history-search-backward    # command search backward using C-p
bindkey '^j' history-search-forward     # command search forward using C-n


# MacOS Specific
if [[ "$OSTYPE" == "darwin"* ]]; then
  export XDG_CONFIG_HOME="$HOME/.config"
  export PASSWORD_STORE_DIR=/Users/samgabel/Secrets/pass        # pass-store
fi


# Linux Specific
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  ### mise
  eval "$(mise completion --usage zsh)"
fi


# Prompt Line Spacing
precmd() {
  precmd() {
    echo
  }
}

# Load Integrations
eval "$(fzf --zsh)"             # fzf shell integration (Ctrl-r)
eval "$(mise activate zsh)"     # mise shell integration

# For Testing-------
# zprof
#-------------------
