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
    export PATH="$HOME/.dotfiles/bin:/home/klar/.local/bin:$PATH"
	export EDITOR="/usr/bin/nvim"
	export PF_INFO="ascii title os host kernel uptime pkgs memory palette"
    export BROWSER=librewolf

# Source zsh files (plugins)
    source $HOME/.zsh/zsh-vi-mode.plugin.zsh

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

    if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
      # exec tmux
      tmux_start
    fi

# Emacs vterm support
    if [[ "$INSIDE_EMACS" = 'vterm' ]]; then
        function clear(){
            vterm_printf "51;Evterm-clear-scrollback";
            tput clear;
        }
    fi

# To run at the start of zsh
    pfetch
    brem --show

