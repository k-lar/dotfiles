#!/bin/sh

walls="$HOME/Pictures/gruvbox_walls"
default_wall="$HOME/Pictures/gruvbox_walls/stairs.jpg"

make_wallpapers_file() {
    wallpapers_file="$HOME/.dotfiles/options/klar_wallpapers"
    touch "$wallpapers_file"

    # Ignore all files that don't have an image extension (jpg|JPG|jpeg|JPEG|png|PNG|gif|GIF|bmp|BMP)
    for wallpaper in "$walls"/*; do
        if echo "$wallpaper" | grep -qE "\.(jpg|JPG|jpeg|JPEG|png|PNG|gif|GIF|bmp|BMP)$"; then
            printf "%s\n" "$wallpaper" >> "$wallpapers_file"
        fi
    done

    # Remove the last newline
    sed -i '$d' "$wallpapers_file"
}

# Check if awww-daemon is running
if ! pgrep awww-daemon > /dev/null; then
    if ! command -v awww > /dev/null; then
        echo "awww is not installed"
        exit 1
    fi

    awww-daemon &
fi

if [ "$1" = "default" ]; then
    awww img --transition-type wipe --transition-angle 30 --transition-step 90 --transition-fps 90 "$default_wall"
    exit 0
elif [ "$1" = "random" ]; then
    # Check if the file already exists or if it's empty
    if [ ! -f "$HOME"/.dotfiles/options/klar_wallpapers ] || [ ! -s "$HOME"/.dotfiles/options/klar_wallpapers ]; then
        make_wallpapers_file
    fi

    # Pick a random wallpaper from the list and remove it from the file
    wallpaper=$(shuf -n 1 "$HOME"/.dotfiles/options/klar_wallpapers)

    # Escape the slashes
    escaped_wallpaper=$(echo "$wallpaper" | sed 's/\//\\\//g')
    sed -i "/$escaped_wallpaper/d" "$HOME"/.dotfiles/options/klar_wallpapers

    # Set the wallpaper
    awww img --transition-type wipe --transition-angle 30 --transition-step 120 --transition-fps 90 "$wallpaper"
    exit 0
elif [ "$1" = "help" ] || [ "$1" = "--help" ]; then
    echo "Usage: $0 [default|random]"
    exit 0
else
    echo "Usage: $0 [default|random]"
    exit 1
fi
