#!/bin/sh

TOGGLE="$HOME/.dotfiles/options/.toggle_caps2esc"

if [ ! -e "$TOGGLE" ]; then
    touch "$TOGGLE"
    setxkbmap si -option
    dunstify -u low -r 178201 --icon=/usr/share/icons/Adwaita/32x32/status/changes-allow-symbolic.symbolic.png "Escape is normal"
else
    rm "$TOGGLE"
    setxkbmap si -option 'caps:swapescape' -option 'caps:ctrl_modifier'; xmodmap -e 'keycode 255 = Escape'; xcape -e '#66=Escape' &
    dunstify -u low -r 178201 --icon=/usr/share/icons/Adwaita/32x32/status/changes-prevent-symbolic.symbolic.png "CapsLock is escape"
fi
