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

# Aliases
	alias ls='exa -g'
	alias nnn='nnn -e'
	alias cat="bat"
	alias v='nvim'
	alias vimrc="v ~/.vimrc"
	alias bashrc="v ~/.bashrc"
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
    export PATH="$HOME/.dotfiles/bin:$PATH"
	export EDITOR="/usr/bin/nvim"
	export PF_INFO="ascii title os host kernel uptime pkgs memory palette"

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

