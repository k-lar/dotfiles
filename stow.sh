#!/bin/sh
set -e

if [ ! -f /usr/bin/stow ]; then
    stow="$HOME/.dotfiles/bin/./stash"
    echo "Using bundled stash"
else
    stow="/usr/bin/stow"
    echo "Using locally installed stow"
fi

if [ -f ~/.bashrc ]; then
    printf ".bashrc already exists. Do you want to replace it?\n[y/N]: "; read -r bashrc_choice
    if [ "$bashrc_choice" = "y" ]; then
        mv ~/.bashrc ~/.bashrc.old
        "$stow" bash
    fi
fi

# Symlink rofi as dmenu
if [ -f /usr/bin/dmenu ]; then
    if [ ! -L "/usr/bin/dmenu" ]; then
        printf "Symlink rofi as dmenu?\n[Y/n]: "; read -r rofi_choice
        if [ ! "$rofi_choice" = "n" ]; then
            sudo ln -s /usr/bin/rofi /usr/bin/dmenu
            echo "Successfully symlinked rofi as dmenu"
        fi
    else
        echo "Rofi is symlinked as dmenu"
    fi
else
    if [ -f /usr/bin/rofi ]; then
        printf "Symlink rofi as dmenu?\n[Y/n]: "; read -r rofi_choice
        if [ ! "$rofi_choice" = "n" ]; then
            sudo ln -s /usr/bin/rofi /usr/bin/dmenu
            echo "Successfully symlinked rofi as dmenu"
        fi
    fi
fi

# Iterate over directories.
for dir in ~/.dotfiles/*/; do
    [ -d "$dir" ] || continue
    dir="$(basename "$dir")"

    case "$dir" in
        misc|bin|scripts|options|icons) printf 'Skipping %s\n' "$dir";;

        keyd)
            sudo "$stow" -t /etc/keyd "$dir"
            printf "Enable and start keyd service?\n[Y/n]: "; read -r keyd_choice
            if [ ! "$keyd_choice" = "n" ]; then
                sudo systemctl enable keyd && sudo systemctl start keyd
                sudo keyd reload
                echo "Successfully enabled and started keyd service"
            fi
            ;;

        *) "$stow" "$dir";;
    esac
done

