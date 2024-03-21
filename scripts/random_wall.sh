#!/bin/sh

walls="$HOME/Pictures/gruvbox_walls/"
default_wall="$HOME/Pictures/gruvbox_walls/stairs.jpg"

if [ "$1" = "default" ]; then
    swaybg -i "$default_wall" &
    sleep 0.6
    pid=$!
    pids_to_kill=$(pgrep swaybg | grep -v "$pid")
    if [ -n "$pids_to_kill" ]; then
        for other_pid in $pids_to_kill; do
            echo "Killing $other_pid"
            kill "$other_pid"
        done
    fi
    exit 0
else
    wallpaper=$(find "$walls" -type f -name '*.jpg' -o -name '*.png' -o -name '*.jpeg' | shuf -n 1)
    swaybg -i "$wallpaper" &
    pid=$!
    echo "Won't kill $pid"
    # Sleep for a bit to not show the default hyprland wallpaper
    sleep 0.6
    pids_to_kill=$(pgrep swaybg | grep -v "$pid")
    if [ -n "$pids_to_kill" ]; then
        for other_pid in $pids_to_kill; do
            echo "Killing $other_pid"
            kill "$other_pid"
        done
    fi
fi
