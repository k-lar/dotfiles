# General aliases
	alias ls='eza -g'
	alias nnn='nnn -e'
	alias cat="bat"
	alias v='nvim'
	alias vimrc="v ~/.dotfiles/nvim/.config/nvim/init.lua"
	alias bashrc="v ~/.bashrc"
    alias zshrc="v ~/.zshrc"
    alias man="better_man"
	alias bonsai='cbonsai -l -i -t 1.5 -m "  Še malo"'
	alias clock='tty-clock -c -f %F'
	alias mutt='neomutt'
	alias lsn='eza --sort newest'
	alias htop='btop'
    alias dots='cd ~/.dotfiles'
	alias newsboat='newsboat -r'
	alias rorlike='cd ~/git/rorlike/'
	alias emacs="emacsclient -c -a 'emacs'"
    alias clear='clear -x' # Don't clear scrollback history (-x)
    alias cd..='cd ..'
    alias ..='cd ..'
    alias ....='cd ../../'
    alias ......='cd ../../../'
    # alias ssh='kitty +kitten ssh'

# Weather report alias:
	alias weather='curl wttr.in/Ljubljana'

# Make grep have color
	alias grep='grep --color=auto'
