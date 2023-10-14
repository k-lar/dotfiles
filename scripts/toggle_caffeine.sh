#!/bin/sh

# Dependency:  caffeine-ng from aur
# https://github.com/caffeine-ng/caffeine-ng

TOGGLE="/dev/shm/.toggle_caffeine"

if [ ! -e "$TOGGLE" ]; then
    touch "$TOGGLE"
    caffeine start &
    dunstify -u low -r 1782123401 --icon ~/.dotfiles/icons/weather-clear-symbolic.svg "Caffeine enabled"
else
    rm "$TOGGLE"
    caffeine kill &
    dunstify -u low -r 1782123401 --icon ~/.dotfiles/icons/weather-clear-night-symbolic.svg "Caffeine disabled"
fi

