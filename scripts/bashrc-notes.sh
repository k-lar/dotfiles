#!/bin/sh
#
# TODO: Add an entry numbering system like "[1] - Note text"
# TODO: Make a rofi/dmenu wrapper for adding entries
# TODO: Move .bashrc autodetecting code into the script.
# TODO: Come up with a better name

set -e

function CreateSource {
    echo "# Notes from bashrc-notes"
    echo "##########################"
}

function Autodetection {
    echo ""
    echo '# Include bashrc-notes if they exists'
    echo 'if [ -f "$HOME/.config/bashrc-notes" ]; then'
    echo '    echo "################ Notes ###############"'
    echo '    source "$HOME/.config/bashrc-notes"'
    echo '    echo "######################################"'
    echo '    echo ""'
    echo 'fi'
}

function Help {
    echo -e "For this program to work correctly, add this line to the bottom of your .bashrc file:"
    echo -e "  source \$HOME/.config/bashrc-notes"
    echo -e "Or use the flag --add-to-bashrc to do it for you"
    echo -e "Usage:"
    echo -e "  bashrc-notes.sh                    Creates \$HOME/.config/bashrc-notes file"
    echo -e "  bashrc-notes.sh -a                 Add a note entry inside the notes file"
    echo -e "  bashrc-notes.sh -R                 Remove \$HOME/.config/bashrc-notes file"
    echo -e "  bashrc-notes.sh --add-to-bashrc    Adds notes autodetection inside .bashrc"
}

function AddNote {
     if ! [ -f "$HOME/.config/bashrc-notes" ]; then
        echo "Notes file doesn't exist!"
        read -p "Do you want to create it? [Y/n]: " create_choice
        if ! [ "$create_choice" = "n" ]; then
            CreateSource >> "$HOME/.config/bashrc-notes"
            chmod +x "$HOME/.config/bashrc-notes"
            echo -e "echo \"$note\"" >> "$HOME/.config/bashrc-notes"
        fi

    else
        echo -e "echo \"$note\"" >> "$HOME/.config/bashrc-notes"
    fi
}

case "$1" in
    "-R"|"--remove")
        if [ -f "$HOME/.config/bashrc-notes" ]; then
        rm "$HOME/.config/bashrc-notes"
        fi;;

    "-a"|"--add")
        if ! [ "$2" = "" ]; then
            note="$2"
            AddNote
        else
            echo "String empty, cannot create note."
        fi;;

    "-h"|"--help") Help;;

    "--add-to-bashrc")
        echo "THIS WILL MODIFY YOUR .bashrc FILE."
        echo "This will add notes autodetection to the bottom of .bashrc"
        read -p "Are you sure this is what you want? [y/N]: " bashrc_choice

        if [ "$bashrc_choice" = "y" ]; then
        Autodetection >> "$HOME/.bashrc"
        echo "Completed successfully"
        fi;;

       *)
        # Check if notes file exists, if it doesn't, create it
        if ! [ -f "$HOME/.config/bashrc-notes" ]; then
            CreateSource >> "$HOME/.config/bashrc-notes"
            chmod +x "$HOME/.config/bashrc-notes"
            echo "Created notes file!"
            echo "To add a note, use the -a flag"
            echo "To remove the file, use the -R flag"
        else
            echo 'No argument given. For help using the program, use the flag "-h"'
        fi;;
esac
