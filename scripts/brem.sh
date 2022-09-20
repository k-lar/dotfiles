#!/bin/sh
#
# TODO: Make a rofi/dmenu wrapper for adding entries

# FOR ROFI INTEGRATION ADD PATH TO brem.sh
BREM_PATH="$HOME/.dotfiles/scripts/brem.sh"

set -e

CreateSource() {
    echo "# Entries from bash reminder"
    echo ""
}


Help() {
    printf "For this program to work correctly, add this line to the bottom of your .bashrc file:\n"
    printf "  brem --show\n"
    printf "Or use the flag --add-to-bashrc to do it for you\n"
    printf "Usage:\n"
    printf "  brem                    Creates \$HOME/.config/brem-reminders file\n"
    printf "  brem -a                 Add an entry inside the reminders file\n"
    printf "  brem -r [-rn]           Remove an entry inside the reminders file [+renumber]\n"
    printf "  brem -rn                Renumber entries inside the reminders file\n"
    printf "  brem -R                 Remove \$HOME/.config/brem-reminders file\n"
    printf "  brem --show             Prints your reminders to the terminal\n"
    printf "  brem --add-to-bashrc    Adds reminder autodetection inside .bashrc\n"
}

AddReminder() {
    if ! [ -f "$HOME/.config/brem-reminders" ]; then
       echo "Reminders file doesn't exist!"
       echo "Do you want to create it? [Y/n]: "
       read -r create_choice
       if ! [ "$create_choice" = "n" ]; then
           CreateSource >> "$HOME/.config/brem-reminders"
           chmod +x "$HOME/.config/brem-reminders"
           printf "echo \"[1] - $reminder\"\n" >> "$HOME/.config/brem-reminders"
       fi

    else
        echo_num=1
        while read line; do
            if echo "${line}" | grep -q "echo"; then
                echo_num=$((echo_num+1))
            fi
        done < "$HOME/.config/brem-reminders"
        printf "echo \"[$echo_num] - $reminder\"\n" >> "$HOME/.config/brem-reminders"
    fi
}

RemoveReminder() {
if [ -f "$HOME/.config/brem-reminders" ]; then
    sed -i "/echo \"\[$remove_num\] -"/d "$HOME/.config/brem-reminders"
else
    echo "Reminders file doesn't exist!"
fi
}

RofiRemove() {
    if [ -f "$HOME/.config/brem-reminders" ]; then
        sed -i "/\\$remove_num/d" "$HOME/.config/brem-reminders"
    else
        echo "Reminders file doesn't exist!"
    fi
}

Renumber() {
    echo_num=1
    line_num=1
    while read line; do
        if echo "${line}" | grep -q "echo"; then
            sed -E -i "${line_num}s/\[([0-9])+\] -/[$echo_num] -/" "$HOME/.config/brem-reminders"
            echo_num=$((echo_num+1))
        fi
    line_num=$((line_num+1))
    done < "$HOME/.config/brem-reminders"
}

RofiMenu() {
    option1="  Show reminders"
    option2="+  Add entry"
    option3="-  Remove entry"
    option4="#  Renumber"
    option5="  Exit"

    options="$option1\n$option2\n$option3\n$option4\n$option5"

    choice=$(echo -e "$options" | rofi -dmenu -i -no-show-icons -lines 5 -width 30 -p "brem: " -location 0 -yoffset 0 -fixed-num-lines true)

    case $choice in
    	$option1)
    		$BREM_PATH --rofi-show ;;
    	$option2)
    		$BREM_PATH --rofi-add ;;
    	$option3)
    		$BREM_PATH --rofi-remove ;;
    	$option4)
    		$BREM_PATH -rn ;;
    	$option5)
    		echo "Exit" ;;
    esac
}

case "$1" in
    "-R"|"--reset")
        if [ -f "$HOME/.config/brem-reminders" ]; then
        rm "$HOME/.config/brem-reminders"
        fi;;

    "-a"|"--add")
        if ! [ "$2" = "" ]; then
            reminder="$2"
            AddReminder
        else
            echo "String empty, cannot create reminder."
        fi;;

    "-r"|"--remove")
            if ! [ "$2" = "" ]; then
                remove_num="$2"
                RemoveReminder
                if [ "$3" = "-rn" ]; then
                    Renumber
                fi
            else
                echo "String empty."
            fi;;

    "-rn"|"--renumber") Renumber;;

    "-h"|"--help") Help;;

    "--add-to-bashrc")
        echo "THIS WILL MODIFY YOUR .bashrc FILE."
        echo "This will add reminders autodetection to the bottom of .bashrc"
        echo "Are you sure this is what you want? [y/N]: "
        read -r bashrc_choice

        if [ "$bashrc_choice" = "y" ]; then
        printf "# Initialize bash reminders\nbrem --show" >> "$HOME/.bashrc"
        echo "Completed successfully"
        fi;;

    "--show")
        if [ -f "$HOME/.config/brem-reminders" ]; then
            echo_num=0
            while read line; do
                if echo "${line}" | grep -q "echo"; then
                    echo_num=$((echo_num+1))
                fi
            done < "$HOME/.config/brem-reminders"

            # If there aren't any echos in file, dont print banner
            if ! [ "$echo_num" = 0 ]; then
                echo "################ Reminders ###############"
                # This sources $HOME/.config/brem-reminders
                . "$HOME/.config/brem-reminders"
                echo "##########################################"
                echo ""
            fi

        fi;;

    "--rofi-show") "$HOME/.config/./brem-reminders" | rofi -dmenu -p "Reminders";;

    "--rofi-add")
        reminder=$(rofi -dmenu -p "Add:" < /dev/null)
        AddReminder;;

    "--rofi-remove")
        remove_num=$("$HOME/.config/./brem-reminders" | rofi -dmenu -p "Remove:")
        RofiRemove;;

    "--rofi-menu")
        RofiMenu;;

       *)
        if ! [ -f "$HOME/.config/brem-reminders" ]; then
            CreateSource >> "$HOME/.config/brem-reminders"
            chmod +x "$HOME/.config/brem-reminders"
            echo "Created reminders file!"
            echo "To add a reminder, use the -a flag"
            echo "To remove the file, use the -R flag"
        else
            echo 'No argument given. For help using the program, use the flag "-h"'
        fi;;
esac
