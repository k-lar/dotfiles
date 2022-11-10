#!/bin/sh
set -e

if [ ! -f /usr/bin/stow ]; then
    stow="$HOME/.dotfiles/bin/stash"
    echo "Using bundled stash"
else
    stow="/usr/bin/stow"
    echo "Using locally installed stow"
fi

for dir in ~/.dotfiles/misc/*/; do
    [ -d "$dir" ] || continue
    dir=$(basename "$dir")

    case "$dir" in
        touchpad) sh -c "sudo ${stow} -v -t /etc/X11/xorg.conf.d/ $dir";;
        binsh2dash) sh -c "sudo ${stow} -v -t /usr/share/libalpm/hooks/ $dir";;
        *) echo "Directory not recognized. Exiting..." || exit 1;;
    esac

done
