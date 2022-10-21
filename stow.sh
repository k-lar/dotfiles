#!/bin/bash

if [ -f ~/.bashrc ]; then
    echo -e ".bashrc already exists. Do you want to replace it?"
    read -p "[y/N]: " bashrc_choice
    if [ "$bashrc_choice" == "y" ]; then
        mv ~/.bashrc ~/.bashrc.old
        stow bash
    fi
fi

# Symlink rofi as dmenu
if [ -f /usr/bin/dmenu ]; then
    if [ ! -L "/usr/bin/dmenu" ]; then
        echo -e "Symlink rofi as dmenu?"
        read -p "[Y/n]: " rofi_choice
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
        read -p "[Y/n]: " rofi_choice
        if [ ! "$rofi_choice" == "n" ]; then
            sudo ln -s /usr/bin/rofi /usr/bin/dmenu
            echo "Successfully symlinked rofi as dmenu"
        fi
    fi

fi


stow boomer
stow bspwm
stow gtk
stow kitty
stow mpd
stow mpv
stow nvim
stow picom
stow polybar
stow rofi
stow sxhkd
stow when
stow zathura
stow emacs
stow dunst
stow tmux
stow fontconfig
stow Xresources
