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

# Prompt shell style
	PS1='[\u@\h \W]\$ '

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
	alias ssh='kitty +kitten ssh'
	alias newsboat='newsboat -r'

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

# Programs to run at start
	pfetch


# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION
