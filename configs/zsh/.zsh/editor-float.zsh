#!/bin/zsh

if [ -n "$TMUX" ]; then
    # Open a floating tmux pane and block until nvim exits
    tmux popup \
        -S fg="magenta" \
        -s fg="blue" \
        -T "EDITOR" \
        -w "80%" \
        -h "80%" \
        -b "rounded" \
        -e "TMUX_TMP_POPUP=true" \
        -E \
        "nvim $1"
else
    # Fallback: Open nvim directly if not in tmux
    nvim "$1"
fi
