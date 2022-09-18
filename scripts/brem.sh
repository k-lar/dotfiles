#!/bin/sh
#
# TODO: Add an entry numbering system like "[1] - Note text"
# TODO: Make a rofi/dmenu wrapper for adding entries

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

case "$1" in
    "-R"|"--remove")
        if [ -f "$HOME/.config/brem-reminders" ]; then
        rm "$HOME/.config/brem-reminders"
        fi;;

    "-a"|"--add")
        if ! [ "$2" = "" ]; then
            reminder="$2"
            AddReminder
        else
            echo "String empty, cannot create note."
        fi;;

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
            echo "################ Reminders ###############"
            # This sources $HOME/.config/brem-reminders
            . "$HOME/.config/brem-reminders"
            echo "##########################################"
            echo ""
        fi;;

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
