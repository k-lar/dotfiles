#!/bin/sh

# Get input from rofi
input="$(rofi -dmenu -p "Spongebobify:" < /dev/null)" || exit

lower=1 # 0 = false, 1 = true

for i in $(seq 1 ${#input}); do
    char=$(echo "$input" | cut -c $i)

    if [ "$char" = " " ]; then
        formatted_input="$formatted_input$char"
        continue
    fi

    if [ "$lower" -eq 0 ]; then
        formatted_input="$formatted_input$(echo "$char" | tr '[:upper:]' '[:lower:]')"
        lower=1
    else
        formatted_input="$formatted_input$(echo "$char" | tr '[:lower:]' '[:upper:]')"
        lower=0
    fi
done

# Put results into clipboard
if [ "$XDG_SESSION_TYPE" = "wayland" ] ; then
    wl-copy "$formatted_input"
else
    echo "$formatted_input" | xclip -selection clipboard
fi
