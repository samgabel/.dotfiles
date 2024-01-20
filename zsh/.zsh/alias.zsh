#MAC OS--------------------------------------------------------------------------------------------

# Flush system dns
alias flushhostdns="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"

# Recursively delete `.DS_Store` files
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

# Tmux default session name
alias t="tmux new -s 'SHELL'"
alias ta="tmux a"

#SERVER--------------------------------------------------------------------------------------------

# Docker alias
alias dps="docker ps --format 'table {{.Names}}\t {{.ID}}\t {{.Image}}\t {{.Status}}\t'"
alias dcup="docker compose up -d"
alias dcupr="docker compose up -d --force-recreate"
alias dcl="docker compose logs -f"


#GLOBAL--------------------------------------------------------------------------------------------

# Replaces `ls` command with `eza`
alias ls="eza --icons --group-directories-first"
alias ll="eza --icons --group-directories-first -l"

# List only directories
alias lsd="eza --icons -D"
alias lld="eza --icons -lD"

# Adds relative line numbers to `grep` command
alias grep='grep'
alias vim='lvim'
alias md='glow'

# df and du
alias df="df -hP"
alias du="du -hs"
