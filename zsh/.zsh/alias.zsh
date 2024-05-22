# GLOBAL--------------------------------------------------------------------------------------------

## vim
alias vim="nvim"

## Replaces `ls` command with `eza`
alias ls="eza --icons --group-directories-first"
alias ll="eza --icons --group-directories-first -l"

## cat
alias cat='bat --decorations=never'

## df and du
alias df="df -hP"
alias du="du -hs"

## List only directories
alias lsd="eza --icons -D"
alias lld="eza --icons -lD"

## Programs Remapped
alias md='glow'

## Tmux default session name
alias t="tmux new -s '󱂶 HOME'"
alias ta="tmux a"

## PATH
alias path='echo $path | tr " " "\n" | bat --file-name PATH'

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

# SERVER--------------------------------------------------------------------------------------------
if [[ "$OSTYPE" == "linux-gnu"* ]]; then

    ## Docker alias
    alias dps="docker ps --format 'table {{.Names}}\t {{.ID}}\t {{.Image}}\t {{.Status}}\t'"
    alias dcup="docker compose up -d"
    alias dcupr="docker compose up -d --force-recreate"
    alias dcl="docker compose logs -f"

fi
