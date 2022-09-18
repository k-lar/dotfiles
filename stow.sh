#!/bin/sh

if [ -f ~/.bashrc ]; then
    echo -e ".bashrc already exists. Do you want to replace it?"
    read -p "[y/N]: " bashrc_choice
    if [ "$bashrc_choice" == "y" ]; then
        mv ~/.bashrc ~/.bashrc.old
        stow bash
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
