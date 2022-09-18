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
	# PS1='[\u@\h \W]\$ '
    PS1="[\W] \[\e[1;33m\]λ \[\e[0m\]"

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
	alias powernap='~/.dotfiles/scripts/./powernap.sh'
	alias brem='~/.dotfiles/scripts/./brem.sh'
	alias emacs="emacsclient -c -a 'emacs'"
    alias clear='clear -x' # Don't clear scrollback history (-x)

# Weather report alias:
	alias weather='curl wttr.in/Ljubljana'

# School aliases
	alias school="cd ~/School"
	alias urnik="sc-im ~/School/urnik.sc"
	alias slova="cd ~/School/SLO"
	alias angla="cd ~/School/ANJ"
	alias uipo="cd ~/School/UIPO"
	alias uiks="cd ~/School/UIKS"
	alias soc="cd ~/School/SOC"
	alias nsik="cd ~/School/NSIK"
	alias poi="cd ~/School/POI"
	alias rob="cd ~/School/ROB"
	alias kem="cd ~/School/KEM"

# Make grep have color
	alias grep='grep --color=auto'

# System exports
	export EDITOR="/usr/bin/nvim"

# pfetch configuration
	export PF_INFO="ascii title os host kernel uptime pkgs memory palette"
	#export PF_SEP=":"

# Environment variables for rustlang
#. "$HOME/.cargo/env"

## Aliases for flutter developement (uncomment to enable)
#	export JAVA_HOME='/usr/lib/jvm/java-8-openjdk'
#	export ANDROID_SDK_ROOT='/opt/android-sdk'
#	export ANDROID_HOME='/opt/android-sdk'
#	export PATH=$JAVA_HOME/bin:$PATH
#	export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools/
#	export PATH=$PATH:$ANDROID_SDK_ROOT/tools/bin/
#	export PATH=$PATH:$ANDROID_ROOT/emulator
#  	export PATH=$PATH:$ANDROID_SDK_ROOT/tools/
#	export CHROME_EXECUTABLE='/usr/bin/chromium'

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
