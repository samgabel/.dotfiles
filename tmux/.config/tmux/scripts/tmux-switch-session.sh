#!/usr/bin/env bash


# Source fzf-tmux script
fzf_tmux_script=${HOME}/.config/tmux/scripts/fzf-tmux


# If tmux is not running exit
if [[ -z $TMUX ]]; then
    echo "Not attached to TMUX"
    exit 1
fi


# Grab list of tmux sessions
tmuxsessions=$(tmux list-sessions -F "#{session_name}")

tmux_switch_to_session() {
    session="$1"
    if [[ $tmuxsessions = *"$session"* ]]; then
        tmux switch-client -t "$session"
    fi
}

current_session=$(tmux display-message -p \#S)

choice=$(sort -rfu <<< "$tmuxsessions" \
    | $fzf_tmux_script -p -w 45 -h 10 -x 150 -y 41 --border --border-label="$(printf "\033[1;37;4mSwitch Session:\033[0m $current_session")" --color=label:\#99FF9F \
    | tr -d '\n')


if [ -n "$choice" ]; then
    tmux_switch_to_session "$choice"
fi
