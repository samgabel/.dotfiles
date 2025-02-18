# PLUGIN MANAGER -------------------------------------------------------------------------

# Set the diretory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit Plugin-Manger, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"


# PLUGINS --------------------------------------------------------------------------------

# Add starship prompt
zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"
zinit light starship/starship

# Add fzf
zinit ice as"program" from"gh-r"
zinit light junegunn/fzf

# Add in zsh plugins
zinit for \
    light-mode \
    atload"zicompinit; zicdreplay" \
    blockf \
    lucid \
    wait \
zsh-users/zsh-completions # this needs to be last completion-related plugin
zinit ice wait lucid; zinit light Aloxaf/fzf-tab
zinit ice wait lucid; zinit light zsh-users/zsh-autosuggestions
zinit ice wait lucid; zinit light zdharma-continuum/fast-syntax-highlighting
zinit light jeffreytse/zsh-vi-mode


# CONFIGURATION --------------------------------------------------------------------------

# History
HISTSIZE=10000
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory # this is kind of annoying
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'  ### makes tab completions case-insensitive
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:git-checkout:*' sort false        ### disable sort when completing `git checkout`
zstyle ':fzf-tab:complete:nvim:*' fzf-min-height '50'   ### set preview-box size
zstyle ':fzf-tab:complete:*:*' fzf-pad '50'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -a -1 --color=always --icons --group-directories-first $realpath'
zstyle ':fzf-tab:complete:bat:*' fzf-preview 'eza -a -1 --color=always --icons --group-directories-first $realpath'
zstyle ':fzf-tab:complete:nvim:*' fzf-preview 'eza -a -1 --color=always --icons --group-directories-first $realpath'

# Zsh-Vi-Mode configuration
# https://github.com/jeffreytse/zsh-vi-mode/issues/209
ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BEAM
ZVM_VI_HIGHLIGHT_BACKGROUND=#45475a
ZVM_VI_HIGHLIGHT_FOREGROUND=#cdd6f4
local function set_keys() {                 # helper function
    local mode=$1
    for key value (${(kv)keys}); do
        zvm_bindkey $mode $key $value
    done
}
local function unset_key() {                # helper function
    local mode=$1; shift 1
    local keys=("$@")
    for key ($keys); do
        bindkey -r -M $mode $key
    done
}
function load_ins_key () {                  # insert mode keybinds
    unset_key viins \
        '^R' '^N' '^P'
    local -A keys
    keys=(
        '^K' history-search-backward
        '^J' history-search-forward
        '^R' fzf-history-widget
        '^v' describe-key-briefly
        '^[f' forward-word
        '^[b' backward-word
        '^[d' kill-word
        '^[^?' backward-kill-word
    )
    set_keys viins
}
zvm_after_init_commands+=(load_ins_key)
function zvm_after_lazy_keybindings() {     # normal mode keybinds
    unset_key vicmd \
        '^R' '^N' '^P'
    local -A keys
    keys=(
        H vi-beginning-of-line
        L vi-end-of-line
        '^K' history-search-backward
        '^J' history-search-forward
        '^R' fzf-history-widget
    )
    set_keys vicmd
}
