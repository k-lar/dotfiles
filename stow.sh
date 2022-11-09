#!/bin/bash
set -e

if [ ! -f /usr/bin/stow ]; then
    stow="perl $HOME/.dotfiles/bin/stow"
else
    stow="/usr/bin/stow"
fi

if [ -f ~/.bashrc ]; then
    echo -e ".bashrc already exists. Do you want to replace it?"
    read -r -p "[y/N]: " bashrc_choice
    if [ "$bashrc_choice" == "y" ]; then
        mv ~/.bashrc ~/.bashrc.old
        "$stow" bash
    fi
fi

# Symlink rofi as dmenu
if [ -f /usr/bin/dmenu ]; then
    if [ ! -L "/usr/bin/dmenu" ]; then
        echo -e "Symlink rofi as dmenu?"
        read -r -p "[Y/n]: " rofi_choice
        if [ ! "$rofi_choice" == "n" ]; then
            sudo ln -s /usr/bin/rofi /usr/bin/dmenu
            echo "Successfully symlinked rofi as dmenu"
        fi
    else
        echo "Rofi is symlinked as dmenu"
    fi
else
    if [ -f /usr/bin/rofi ]; then
        echo -e "Symlink rofi as dmenu?"
        read -r -p "[Y/n]: " rofi_choice
        if [ ! "$rofi_choice" == "n" ]; then
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
        misc|bin|scripts) printf 'Skipping %s\n' "$dir";;
        *) "$stow" "$dir";;
    esac
done

