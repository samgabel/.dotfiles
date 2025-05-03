# GLOBAL--------------------------------------------------------------------------------------------

## vim
alias vim="nvim"

## Replaces `ls` command with `eza`
alias ls="eza --icons --group-directories-first"
alias ll="eza --icons --group-directories-first -l"
alias lg="eza --icons --group-directories-first -l --git"

## cat
alias cat="bat --decorations=never"

## df and du
alias df="df -hP"
alias du="du -hs"
alias dua="du -sh */ | sort -h && echo "------------------------------------" && du -sh ."

## loc in a git project
alias loc="git ls-files | xargs wc -l"

## List only directories
alias lsd="eza --icons -D"
alias lld="eza --icons -lD"

## Programs Remapped
alias md="glow"

## Tmux default session name
alias tnew="tmux-new-server"
alias ta="tmux-attach-server"
alias tls="ls -1 /tmp/tmux-$(id -u)/"
alias tkill="tmux-kill-server"
alias tclean="tmux-clean-stale-sockets"

## PATH
alias path='echo $path | tr " " "\n" | fzf | tr -d "\n" | pbcopy'

# MAC OS--------------------------------------------------------------------------------------------
if [[ "$OSTYPE" == "darwin"* ]]; then

    ## Flush system dns
    alias flushhostdns="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"

    ## Recursively delete `.DS_Store` files
    alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

    ## Plist Buddy
    alias plistbuddy="/usr/libexec/PlistBuddy"

    ## Hexyl (hex viewer)
    alias hex="hexyl --terminal-width 150"

fi

## Kubernetes alias
alias k="kubectl"
alias ks="kswitch"
alias kc="k config use-context"

## Docker alias
alias dps="docker ps --format 'table {{.Names}}\t {{.ID}}\t {{.Image}}\t {{.Status}}\t'"
alias dcup="docker compose up -d"
alias dcupr="docker compose up -d --force-recreate"
alias dcl="docker compose logs -f"

## Golang alias
alias golangci-lint="~/.local/share/nvim/mason/bin/golangci-lint"
