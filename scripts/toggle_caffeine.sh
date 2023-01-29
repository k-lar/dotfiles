#!/bin/sh

# Dependency:  caffeine-ng from aur
# https://github.com/caffeine-ng/caffeine-ng

TOGGLE="/dev/shm/.toggle_caffeine"

if [ ! -e "$TOGGLE" ]; then
    touch "$TOGGLE"
    caffeine start &
    dunstify -u low -r 1782123401 --icon=/usr/share/icons/Adwaita/32x32/status/weather-clear-symbolic.symbolic.png "Caffeine enabled"
else
    rm "$TOGGLE"
    caffeine kill &
    dunstify -u low -r 1782123401 --icon=/usr/share/icons/Adwaita/32x32/status/weather-clear-night-symbolic.symbolic.png "Caffeine disabled"
fi

