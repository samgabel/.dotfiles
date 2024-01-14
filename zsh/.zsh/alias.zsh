# mac OS shortcuts
alias flushhostdns="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"

# server shortcuts
alias dps="docker ps --format 'table {{.Names}}\t {{.ID}}\t {{.Image}}\t {{.Status}}\t'"
alias dcup="docker compose up -d"
alias dcupr="docker compose up -d --force-recreate"
alias dcl="docker compose logs -f"

# ALIAS COMMANDS
alias ls="eza --icons --group-directories-first"
alias ll="eza --icons --group-directories-first -l"
alias grep='grep -n'
alias vim='lvim'
alias md='glow'
