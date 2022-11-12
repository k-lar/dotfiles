#!/bin/sh

set -e

printf 'Your current shell is: %s\n' "$SHELL"
printf "Would you like to change it?\n[y/N]: "; read -r change_choice

if [ ! "$change_choice" = "y" ]; then
    echo "Exiting script..."; exit 0
else
    printf "What shell do you want to switch to?\n"
    printf "[1] - /bin/bash\n"
    printf "[2] - /bin/zsh\n: "
    read -r shell_choice

    case "$shell_choice" in
        1)
        sh -c "chsh -s /bin/bash"
        if [ ! -e $HOME/.config/tmux/shell_choice.conf ]; then
            mkdir -p $HOME/.config/tmux/
            touch $HOME/.config/tmux/shell_choice.conf
            echo "set-option -g default-shell /bin/bash" > $HOME/.config/tmux/shell_choice.conf
            echo "Sucessfully set shell to: /bin/bash"
        else
            echo "set-option -g default-shell /bin/bash" > $HOME/.config/tmux/shell_choice.conf
            echo "Sucessfully set shell to: /bin/bash"
        fi
        ;;

        2)
        sh -c "chsh -s /bin/zsh"
        if [ ! -e $HOME/.config/tmux/shell_choice.conf ]; then
            mkdir -p $HOME/.config/tmux/
            touch $HOME/.config/tmux/shell_choice.conf
            echo "set-option -g default-shell /bin/zsh" > $HOME/.config/tmux/shell_choice.conf
            echo "Sucessfully set shell to: /bin/zsh"
        else
            echo "set-option -g default-shell /bin/zsh" > $HOME/.config/tmux/shell_choice.conf
            echo "Sucessfully set shell to: /bin/zsh"
        fi
        ;;

    esac


    if [ "$TERM_PROGRAM" = "tmux" ]; then
        echo "WARNING: you will have to restart tmux for your shell to change!"
        printf "Do you want to restart it now?\n[Y/n]: "; read -r kill_tmux
        case "$kill_tmux" in
            n|N) echo "Exiting script..." && exit 0;;
            *) sh -c "tmux kill-server" && exit 0;;
        esac
    fi
fi

