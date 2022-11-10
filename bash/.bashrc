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
    export PATH="$HOME/.dotfiles/bin:$PATH"

# History configuration (unlimited history)
    export HISTFILESIZE=
    export HISTSIZE=
    export HISTTIMEFORMAT="%F %T | "
    export HISTFILE=~/.bash_history
    export PROMPT_COMMAND='history -a'

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

    if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
      # exec tmux
      tmux_start
    fi

# Prompt shell style
    PS1="[\W] \[\e[1;33m\]λ \[\e[0m\]"
    # PS1='[\u@\h \W]\$ '

# Set bash into vim mode
	set -o vi

# Aliases
	alias ls='exa -g'
	alias nnn='nnn -e'
	alias cat="bat"
	alias vim='nvim'
	alias vimrc="vim ~/.vimrc"
	alias bashrc="vim ~/.bashrc"
	alias bonsai='cbonsai -l -i -t 1.5 -m "  Še malo"'
	alias clock='tty-clock -c -f %F'
	alias mutt='neomutt'
	alias lsn='exa --sort newest'
	alias htop='btop'
	# alias ssh='kitty +kitten ssh'
	alias newsboat='newsboat -r'
	alias rorlike='cd ~/git/rorlike/'
	alias emacs="emacsclient -c -a 'emacs'"
    alias clear='clear -x' # Don't clear scrollback history (-x)
    alias cd..='cd ..'
    alias ..='cd ..'
    alias ....='cd ../../'
    alias ......='cd ../../../'

# Weather report alias:
	alias weather='curl wttr.in/Ljubljana'

# Make grep have color
	alias grep='grep --color=auto'

# System exports
	export EDITOR="/usr/bin/nvim"

# pfetch configuration
	export PF_INFO="ascii title os host kernel uptime pkgs memory palette"

# Emacs vterm support
    if [[ "$INSIDE_EMACS" = 'vterm' ]]; then
        function clear(){
            vterm_printf "51;Evterm-clear-scrollback";
            tput clear;
        }
    fi

# Programs to run at start
	pfetch

# Include bash reminders if they exists
    brem --show
