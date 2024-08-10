#!/usr/bin/env bash

if [ $(tmux list-panes | wc -l) -eq 1 ]; then
    # If there is only one pane, create a horizontal split and focus on the bottom pane
    tmux send-keys Escape \; send-keys C-s \; split-window -v -l 12
else
    # If there are multiple panes, check the zoom state of the top pane
    if [ $(tmux display-message -p "#{window_zoomed_flag}") -eq 1 ]; then
        # If the top pane is zoomed, unzoom it
        tmux send-keys Escape \; send-keys C-s \; resize-pane -Z \; select-pane -t 2
    else
        # If the top pane is not zoomed, focus on the top pane and zoom it
        tmux select-pane -t 1 \; send-keys Escape \; send-keys C-s \; resize-pane -Z
    fi
fi

