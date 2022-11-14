#!/bin/sh

TOGGLE="$HOME/.toggle_caps2esc"

if [ ! -e "$TOGGLE" ]; then
    touch "$TOGGLE"
    setxkbmap si -option
    notify-send -u low -i mouse --icon=/usr/share/icons/Adwaita/32x32/status/changes-allow-symbolic.symbolic.png "Escape is normal"
else
    rm "$TOGGLE"
    setxkbmap si -option 'caps:swapescape' -option 'caps:ctrl_modifier'; xmodmap -e 'keycode 255 = Escape'; xcape -e '#66=Escape' &
    notify-send -u low -i mouse --icon=/usr/share/icons/Adwaita/32x32/status/changes-prevent-symbolic.symbolic.png "CapsLock is escape"
fi
