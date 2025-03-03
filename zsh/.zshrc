#  _    _            ( )                _
# | |__| | __ _  _ _  \| ___    ___ ___| |_   _ _  __
# | / /| |/ _` || '_|   (_-/   |_ /(_-<| ' \ | '_|/ _|
# |_\_\|_|\__/_||_|     /__/   /__|/__/|_||_||_|  \__|
#
#
#
# ~/.zshrc
#

# History configuration
    HISTFILE=~/.zsh_history
    HISTSIZE=5000
    SAVEHIST=10000000000
    setopt appendhistory
    setopt hist_ignore_space
    setopt hist_ignore_all_dups
    setopt hist_ignore_dups
    setopt hist_save_no_dups
    setopt hist_find_no_dups

# Options
    unsetopt beep
    unsetopt autoremoveslash
    setopt globdots

# Completion
    zstyle :compinstall filename '/home/klar/.zshrc'
    autoload -Uz compinit
    compinit

# Prompt configuration
    PS1="[%1~] %{%F{yellow}%}% %Bλ%b%F{reset_color} "

# Colorful man pages
    export LESS_TERMCAP_mb=$'\e[1;32m'
    export LESS_TERMCAP_md=$'\e[1;32m'
    export LESS_TERMCAP_me=$'\e[0m'
    export LESS_TERMCAP_se=$'\e[0m'
    export LESS_TERMCAP_so=$'\e[01;33m'
    export LESS_TERMCAP_ue=$'\e[0m'
    export LESS_TERMCAP_us=$'\e[1;4;31m'

# Aliases
    source $HOME/.bash_aliases

# System exports
    export PATH="$HOME/.dotfiles/bin:$HOME.local/bin:$PATH"
    export EDITOR="/usr/bin/nvim"
    export BROWSER="/usr/bin/librewolf"

# Source zsh files (plugins)
    source $HOME/.zsh/zsh-vi-mode.plugin.zsh

# Make zsh-vi-mode not delete long paths
    WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# Bind keys to stuff
    bindkey "^[[1;3C" forward-word
    bindkey "^[[1;3D" backward-word
    bindkey "^[[1;5C" forward-word
    bindkey "^[[1;5D" backward-word

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

    if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ] && [ -z "$VIM" ] && [ -z "$INSIDE_EMACS" ] && [ -z "$NO_TMUX" ]; then
      # exec tmux
      tmux_start
    fi

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

# To run at the start of zsh
    command -v fastfetch >/dev/null 2>&1 && fastfetch || true
    command -v brem >/dev/null 2>&1 && brem --show || true

