#!/bin/sh

IFS=
while read -r program || [ -n "$program" ]; do

    if ! command -v "$program" > /dev/null 2>&1 ; then
        continue
    fi
    sh -c "$program" &

done < "$HOME/.config/autostart"

touch /dev/shm/.autostarted_bspwm
