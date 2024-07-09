#!/bin/bash
tmuxsessions=$(tmux list-sessions -F "#{session_name}")

tmux_switch_to_session() {
    session="$1"
    if [[ $tmuxsessions = *"$session"* ]]; then
        tmux switch-client -t "$session"
    fi
}

current_session=$(tmux display-message -p \#S)

choice=$(sort -rfu <<< "$tmuxsessions" \
    | fzf-tmux -p -w 45 -h 10 -x 150 -y 41 --border --border-label="$(printf "\033[1;37;4mSwitch Session:\033[0m $current_session")" --color=label:\#99FF9F \
    | tr -d '\n')


if [ -n "$choice" ]; then
    tmux_switch_to_session "$choice"
fi
