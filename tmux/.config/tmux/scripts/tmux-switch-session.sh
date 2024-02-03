#!/bin/bash
tmuxsessions=$(tmux list-sessions -F "#{session_name}")

tmux_switch_to_session() {
    session="$1"
    if [[ $tmuxsessions = *"$session"* ]]; then
        tmux switch-client -t "$session"
    fi
}


choice=$(sort -rfu <<< "$tmuxsessions" \
    | fzf-tmux -p -w 45 -h 10 -x 150 -y 40 \
    | tr -d '\n')


if [ -n "$choice" ]; then
    tmux_switch_to_session "$choice"
fi
