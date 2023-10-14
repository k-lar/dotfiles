#!/bin/sh

TOGGLE="/dev/shm/.toggle_caps2esc"

if [ ! -e "$TOGGLE" ]; then
    touch "$TOGGLE"
    setxkbmap -option
    setxkbmap -layout si,ru -variant ,phonetic -option 'grp:alt_space_toggle'
    dunstify -u low -r 178201 --icon ~/.dotfiles/icons/changes-allow-symbolic.svg "Escape is normal"
else
    rm "$TOGGLE"
    setxkbmap -layout si,ru -variant ,phonetic -option 'caps:swapescape' -option 'caps:ctrl_modifier' -option 'grp:alt_space_toggle'; xmodmap -e 'keycode 255 = Escape'; xcape -e '#66=Escape'
    dunstify -u low -r 178201 --icon ~/.dotfiles/icons/changes-prevent-symbolic.svg "CapsLock is escape"
fi
