#!/bin/bash

set -x

date=$(date +"%T")

usrtime=$(tr -d 'hms' <<< "$1")
timeval=$(tr -d -c 'hms' <<< "$1")

if [ "$timeval" = "h" ];then
    usrtime=$(echo "$usrtime*60" | bc | sed "s/\..*//")
    if [ "$usrtime" -gt 5 ];then
        time2sleep=$(echo "$usrtime-5" | bc | sed "s/\..*//")
        time2sleep="${time2sleep}m"
        dowarn=1
    else
        time2sleep="$usrtime"
        time2sleep="${time2sleep}m"
        dowarn=0
    fi
    datenext=$(date --date="$time2sleep minutes" +"%T")
fi

if [ "$timeval" = "m" ];then
    usrtime=$(echo "$usrtime*60" | bc | sed "s/\..*//")
    if [ "$usrtime" -gt 300 ];then
        time2sleep=$(echo "$usrtime-300" | bc | sed "s/\..*//")
        time2sleep="${time2sleep}s"
        dowarn=1
    else
        time2sleep="$usrtime"
        time2sleep="${time2sleep}s"
        dowarn=0
    fi
    datenext=$(date --date="$time2sleep seconds" +"%T")
fi

if [ "$timeval" = "s" ];then
    if [ "$usrtime" -gt 300 ];then
        time2sleep=$(echo "$usrtime-300" | bc | sed "s/\..*//")
        time2sleep="${time2sleep}s"
        dowarn=1
    else
        time2sleep="$usrtime"
        time2sleep="${time2sleep}s"
        dowarn=0
    fi
    datenext=$(date --date="$time2sleep seconds" +"%T")
fi

printf "powernap started at: $date\n"
printf "Your PC will poweroff at $datenext\n"

sleep "$time2sleep"

if [ "$dowarn" = 1 ];then
    notify-send --app-name=powernap --expire-time=300000 --urgency=critical "PC will shut down in 5m"
    echo "PC will shut down in 5m"
    sleep 5m
fi

poweroff
