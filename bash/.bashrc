#  _    _            ( )          _               _
# | |__| | __ _  _ _  \| ___     | |__  __ _  ___| |_   _ _  __
# | / /| |/ _` || '_|   (_-/     |  _ \/ _` |(_-/|   \ | '_|/ _|
# |_\_\|_|\__/_||_|     /__/     |____/\__/_|/__/|_||_||_|  \__|
#
#
#
# ~/.bashrc
#

# If not running interactively, don't do anything
    [[ $- != *i* ]] && return

# PATH variable
    export PATH="$HOME/.dotfiles/bin:$HOME/.local/bin:$PATH"

# History configuration (unlimited history)
    export HISTFILESIZE=
    export HISTSIZE=
    export HISTTIMEFORMAT="%F %T | "
    export HISTFILE=~/.bash_history
    export PROMPT_COMMAND='history -a'

# Colorful man pages
    export LESS_TERMCAP_mb=$'\e[1;32m'
    export LESS_TERMCAP_md=$'\e[1;32m'
    export LESS_TERMCAP_me=$'\e[0m'
    export LESS_TERMCAP_se=$'\e[0m'
    export LESS_TERMCAP_so=$'\e[01;33m'
    export LESS_TERMCAP_ue=$'\e[0m'
    export LESS_TERMCAP_us=$'\e[1;4;31m'

# Shell options (shopt)
    shopt -s cdspell
    shopt -s histappend
    shopt -s checkwinsize
    stty -ixon # CTRL-s history search

# Source files to get bash completions
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        source /usr/share/bash-completion/bash_completion
    fi

# Run tmux at start
    function tmux_start(){
        tmux has-session -t dev
        if [ $? != 0 ]
        then
          tmux new-session -s dev
        fi

        tmux ls -F '#{session_attached} #{session_name}' | grep "1 * dev"
        if [ $? = 0 ]; then
            tmux new-session
        fi

        tmux attach -t dev; exec tmux
    }

    if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ] && [ -z "$VIM" ] && [ -z "$INSIDE_EMACS" ]; then
      # exec tmux
      tmux_start
    fi

# Prompt shell style
    PS1="[\W] \[\e[1;33m\]λ \[\e[0m\]"
    # PS1='[\u@\h \W]\$ '

# Set bash into vim mode
    set -o vi

# Aliases
    source $HOME/.bash_aliases

# System exports
    export EDITOR="/usr/bin/nvim"

# A better man function
    function better_man() {
        /bin/man "$1" || "$1" --help 2>&1 | less
    }

# Test true colors in terminal
    function test_truecolor() {
         awk 'BEGIN{
             s="/\\/\\/\\/\\/\\"; s=s s s s s s s s;
             for (colnum = 0; colnum<77; colnum++) {
                 r = 255-(colnum*255/76);
                 g = (colnum*510/76);
                 b = (colnum*255/76);
                 if (g>255) g = 510-g;
                 printf "\033[48;2;%d;%d;%dm", r,g,b;
                 printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
                 printf "%s\033[0m", substr(s,colnum+1,1);
             }
             printf "\n";
         }'
    }

# Make temp dir for testing and misc
    function cdtemp() {
        cd $(mktemp -d)
    }

# Daily todo
    function todo() {
        if [ "$1" = "search" ]; then
            selected_file="$(fzf --walker-root=$HOME/todos/)"
            if [ $? -eq 0 ]; then
                $EDITOR "$selected_file"
            fi
        else
            date=$(date --iso-8601)

            if [ -d "$HOME/todos/$date" ]; then
                if [ ! -s "$HOME/todos/$date/todo.md" ]; then
                    echo -e "# TODO - $date\n\n- [ ] \n" >> "$HOME/todos/$date/todo.md"
                fi

                $EDITOR "$HOME/todos/$date/todo.md"

                if [ "$(cat $HOME/todos/$date/todo.md)" = "$(printf '# TODO - %s\n\n- [ ] \n' "$date")" ]; then
                    rm -rf "$HOME/todos/$date"
                fi
            else
                mkdir -p "$HOME/todos/$date"
                echo -e "# TODO - $date\n\n- [ ] \n" >> "$HOME/todos/$date/todo.md"
                $EDITOR "$HOME/todos/$date/todo.md"

                if [ "$(cat $HOME/todos/$date/todo.md)" = "$(printf '# TODO - %s\n\n- [ ] \n' "$date")" ]; then
                    rm -rf "$HOME/todos/$date"
                fi
            fi
        fi
    }

# Emacs vterm support
    if [ "$INSIDE_EMACS" = 'vterm' ]; then
        function clear(){
            vterm_printf "51;Evterm-clear-scrollback";
            tput clear;
        }
    fi

# Programs to run at start
    command -v pfetch >/dev/null 2>&1 && pfetch || true

# Include bash reminders if they exists
    command -v brem >/dev/null 2>&1 && brem --show || true

# Start zoxide if it's installed
    command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init --cmd cd bash)" || true
