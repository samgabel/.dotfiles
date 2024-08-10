#!/usr/bin/env bash

fzf_tmux_script=$(echo $HOME)/.config/tmux/scripts/fzf-tmux

if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(find -L ~/Projects ~/Projects/Devel ~/Projects/Boot.Dev ~/Documents ~/.config -mindepth 1 -maxdepth 1 -type d ! -name '.git' \
        | sed "s|^$HOME|~|" \
        | $fzf_tmux_script -p -w 70 -h 15 -x 150 -y 41 --border --border-label="$(printf "\033[1;37;4mCreate Session\033[0m")")
    # convert back into absolute path for `tmux new-session -c` command
    selected=$(echo $selected | sed "s|^~|$HOME|")
fi

if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s $selected_name -c $selected
    exit 0
fi

if ! tmux has-session -t=$selected_name 2> /dev/null; then
    tmux new-session -ds $selected_name -c $selected -n editor 'nvim .' \; \
        new-window -c $selected \; \
        select-window -t 1
fi

tmux switch-client -t $selected_name
