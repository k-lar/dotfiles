#!/bin/sh

TOGGLE="/dev/shm/.polkit_running"

if [ ! -e "$TOGGLE" ]; then
    touch "$TOGGLE"
    exec /usr/lib/xfce-polkit/xfce-polkit &
    dunstify -u low -r 171401 --icon=/usr/share/icons/Adwaita/32x32/status/dialog-password-symbolic.symbolic.png "Polkit started"
fi
