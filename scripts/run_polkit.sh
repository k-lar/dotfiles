#!/bin/sh

TOGGLE="/dev/shm/.polkit_running"

if [ ! -e "$TOGGLE" ]; then
    touch "$TOGGLE"
    exec /usr/lib/xfce-polkit/xfce-polkit &
    dunstify -u low -r 171401 --icon ~/.dotfiles/icons/emblem-system-symbolic.svg "Polkit started"
fi
