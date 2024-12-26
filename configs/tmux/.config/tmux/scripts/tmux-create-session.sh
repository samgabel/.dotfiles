#!/usr/bin/env bash


# Search_dir differs between darwin and linux
if [[ $OSTYPE == 'darwin'* ]]; then
    search_dirs=(~/Work/ShurikenTrade ~/Work/Devel ~/Projects ~/Projects/Devel ~/Projects/Boot.Dev ~/Projects/Kubernetes ~/Projects/GCP ~/Documents ~/.config)
else
    search_dirs=(~/)
fi

# Source fzf-tmux script
fzf_tmux_script=${HOME}/.config/tmux/scripts/fzf-tmux


# If tmux is not running exit
if [[ -z $TMUX ]]; then
    echo "Not attached to TMUX"
    exit 1
fi


# Send search results to fzf-tmux so that we can pick a directory path
selected=$(find -L "${search_dirs[@]}" -mindepth 1 -maxdepth 1 -type d ! -name '.git' ! -name '.*' ! -name 'TEST' \
    | sed "s|^$HOME|~|" \
    | $fzf_tmux_script -p -w 70 -h 15 -x 140 -y 54 --border --border-label="$(printf "\033[1;37;4mCreate Session\033[0m")")
# convert back into absolute path for `tmux new-session -c` command
selected=${selected//"~"/$HOME}


# If nothing was selected then exit the script (pressing esc)
if [[ -z $selected ]]; then
    exit 0
fi


# Grab basename of $selected as the tmux session name
session_name=$(basename "$selected" | tr . _)


# Create a new session (with nvim and shell window) if the session_name doesn't exits in the tmux sessions
if ! tmux has-session -t="$session_name" 2> /dev/null; then
    tmux new-session -ds "$session_name" -c "$selected" -n editor 'nvim .' \; \
        new-window -c "$selected" \; \
        select-window -t 1
fi


# Switch to the desired session
tmux switch-client -t "$session_name"
