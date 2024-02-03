# GLOBAL--------------------------------------------------------------------------------------------

## Replaces `ls` command with `eza`
alias ls="eza --icons --group-directories-first"
alias ll="eza --icons --group-directories-first -l"

## cat
if [[ "$OSTYPE" == "darwin"* ]]; then
  alias cat='bat --decorations=never'
fi
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  alias cat='batcat --decorations=never'
  alias bat='batcat'
fi

## df and du
alias df="df -hP"
alias du="du -hs"

## List only directories
alias lsd="eza --icons -D"
alias lld="eza --icons -lD"

## Programs Remapped
alias md='glow'

## Tmux default session name
alias t="tmux new -s 'ZSHELL'"
alias ta="tmux a"


# MAC OS--------------------------------------------------------------------------------------------

## Flush system dns
alias flushhostdns="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"

## Recursively delete `.DS_Store` files
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"


# SERVER--------------------------------------------------------------------------------------------

## Docker alias
alias dps="docker ps --format 'table {{.Names}}\t {{.ID}}\t {{.Image}}\t {{.Status}}\t'"
alias dcup="docker compose up -d"
alias dcupr="docker compose up -d --force-recreate"
alias dcl="docker compose logs -f"
