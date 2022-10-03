#!/bin/sh
date=$(date +"%T")

printf "powernap started at: $date\n"
sleep "$1"
notify-send --app-name=powernap --expire-time=300000 --urgency=critical "PC will shut down in 5m"
echo "PC will shut down in 5m"
sleep 5m
poweroff
