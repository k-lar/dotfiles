#!/bin/bash

date=$(date +"%T")

usrtime=$(tr -d 'hms' <<< "$1")
timeval=$(tr -d -c 'hms' <<< "$1")

if [ "$timeval" = "h" ];then
    usrtime=$(echo "$usrtime*60" | bc | sed "s/\..*//")
    datenext=$(date --date="$usrtime minutes" +"%T")
fi

if [ "$timeval" = "m" ];then
    usrtime=$(echo "$usrtime*60" | bc | sed "s/\..*//")
    datenext=$(date --date="$usrtime seconds" +"%T")
fi

if [ "$timeval" = "s" ];then
    datenext=$(date --date="$usrtime seconds" +"%T")
fi

printf "powernap started at: $date\n"
printf "Your PC will poweroff at $datenext\n"

sleep "$1"
notify-send --app-name=powernap --expire-time=300000 --urgency=critical "PC will shut down in 5m"
echo "PC will shut down in 5m"
sleep 5m
poweroff
