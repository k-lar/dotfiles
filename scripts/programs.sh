#!/bin/bash

# ===============================================================================
# This shell script downloads all necessary programs that are in use in this repo.
# FOR PERSONAL USE ONLY.
# Distributions currently supported: Arch
# ===============================================================================
# List of programs to be downloaded
# ===============================================================================

CORE_PACKAGES=("neovim" "mpv" "feh" "zathura" "zathura-pdf-mupdf" "xcolor" "thunar" "cloc"
"thunar-volman" "gvfs" "gvfs-mtp" "alacritty" "when" "git" "rofi" "loupe" "xclip" "pamixer"
"unrar" "zip" "unzip" "ncdu" "keepassxc" "file-roller" "eza" "ripgrep" "fzf" "btop" "tmux" "xcape"
"pavucontrol" "flameshot" "bat" "stow" "ttf-ibm-plex" "emacs-nativecomp" "gnome-disk-utility"
"network-manager-applet" "bash-completion" "alsa-utils" "polkit" "xfce-polkit" "python-pipx")

DE_PACKAGES=("bspwm" "sxhkd" "picom-ftlabs-git" "mtpfs" "lightdm" "polybar"
"boomer-git" "cava-git" "i3lock-color" "pfetch" "ttf-blex-nerd-font-git"
"lightdm-gtk-greeter" "lxappearance" "ttf-iosevka-nerd" "ttf-font-awesome"
"otf-font-awesome" "noto-fonts-main" "gummy-git" "dunst" "gruvbox-dark-icons-gtk"
"gruvbox-dark-gtk" "ttc-iosevka-ss07")

WAYLAND_PKGS=("hyprland" "hyprpicker" "hyprpaper" "wl-clipboard" "rofi-lbonn-wayland-git"
"foot" "waybar" "swaylock-effects" "swaybg" "grim" "slurp" "hyprlock" "nwg-look" "udiskie")

TERM_OFFICE=("texlive-core" "pandoc-bin" "texlive-latexextra" "sc-im" "cbonsai" "mdp"
"texlive-fontsrecommended")

MISC_PKGS=("yt-dlp" "ntfs-3g" "ncmpcpp" "dash" "zsh" "inetutils" "caffeine-ng" "ctags"
"cscope" "global")

# ===============================================================================

check_yay() {
    # Check if yay is installed
    if [ -d "/opt/yay" ]; then
        echo "Yay is installed on your system."
        read -r -p  "Would you like to reinstall it? [y/N]: " yay_reinstall_choice
        if [ "$yay_reinstall_choice" == "y" ]; then
            sudo rm -rf /opt/yay
            sudo pacman --noconfirm --needed -S base-devel git &&
                cd /opt &&
                sudo git clone https://aur.archlinux.org/yay.git &&
                sudo chown -R "$(whoami)":users ./yay &&
                cd yay &&
                makepkg -si
        fi
    fi

    if [ ! -d "/opt/yay" ]; then
        echo "It seems that yay is not installed on your system."
        read -r -p  "Would you like to install it? [y/N]: " yay_choice
        if [ "$yay_choice" == "y" ]; then
            sudo pacman --noconfirm --needed -S base-devel git &&
                cd /opt &&
                sudo git clone https://aur.archlinux.org/yay.git &&
                sudo chown -R "$(whoami)":users ./yay &&
                cd yay &&
                makepkg -si
        fi
    fi
}

xdg_dirs_check() {
    # Check if XDG user dirs are present
    if [[ ! -e "$HOME/.config/user-dirs.dirs" ]]; then
        echo "XDG user directories not present on system."
        read -r -p  "Would you like to create them? [Y/n]: " xdg_choice
        if ! [ "$xdg_choice" == "n" ]; then
            sudo pacman --noconfirm --needed -S xdg-user-dirs &&
                xdg-user-dirs-update &&
                echo "XDG directories created successfully! Locations:" &&
                xdg-user-dir DESKTOP &&
                xdg-user-dir DOWNLOAD &&
                xdg-user-dir TEMPLATES &&
                xdg-user-dir PUBLICSHARE &&
                xdg-user-dir DOCUMENTS &&
                xdg-user-dir MUSIC &&
                xdg-user-dir PICTURES &&
                xdg-user-dir VIDEOS &&
                echo ""
        fi
    fi
}

wallpaper_check() {
    # Check if gruvbox wallpapers are present
    if [[ ! -d "$HOME/Pictures/gruvbox_walls/" ]]; then
        echo "Gruvbox wallpapers not present."
        read -r -p  "Would you like to download them? [Y/n]: " walls_choice
        if ! [ "$walls_choice" == "n" ]; then
            if ! type git > /dev/null; then
                sudo pacman --noconfirm --needed -S git
            fi
            git clone https://gitlab.com/k_lar/gruvbox_walls "$HOME"/Pictures/gruvbox_walls
            echo ""
        fi
    fi
}

install_pkgs() {
    # Installation script
    echo "List all the packages that can be installed?"
    read -r -p "[y/N]: " confirm_selection
    if [ "$confirm_selection" == "y" ]; then
        printf "\n=========================================\n"
        printf "\e[1mCORE_PACKAGES: (${#CORE_PACKAGES[@]})\n\e[0m"
        print_array "${CORE_PACKAGES[@]}"
        printf "\n"

        printf "\e[1mDE_PACKAGES: (${#DE_PACKAGES[@]})\n\e[0m"
        print_array "${DE_PACKAGES[@]}"
        printf "\n"

        printf "\e[1mMISC_PKGS: (${#MISC_PKGS[@]})\n\e[0m"
        print_array "${MISC_PKGS[@]}"
        printf "\n"

        printf "\e[1mWAYLAND_PKGS: (${#WAYLAND_PKGS[@]})\n\e[0m"
        print_array "${WAYLAND_PKGS[@]}"
        printf "\n"

        printf "\e[1mTERM_OFFICE: (${#TERM_OFFICE[@]})\n\e[0m"
        print_array "${TERM_OFFICE[@]}"
        printf "=========================================\n"
    fi
    echo ""

    # Ask user what optional packages they want to install
    USR_PACKAGES=()
    for i in "${CORE_PACKAGES[@]}"; do
        USR_PACKAGES+=("$i")
    done

    echo -e "Include DE packages?"
    read -r -p "[y/N]: " de_choice
    if [ "$de_choice" == "y" ]; then
        for i in "${DE_PACKAGES[@]}"; do
            USR_PACKAGES+=("$i")
        done
    fi
    echo ""

    echo -e "Include wayland packages?"
    read -r -p "[y/N]: " wl_choice
    if [ "$wl_choice" == "y" ]; then
        for i in "${WAYLAND_PKGS[@]}"; do
            USR_PACKAGES+=("$i")
        done
    fi
    echo ""

    echo -e "Include misc packages?"
    read -r -p "[y/N]: " misc_choice
    if [ "$misc_choice" == "y" ]; then
        for i in "${MISC_PKGS[@]}"; do
            USR_PACKAGES+=("$i")
        done
    fi
    echo ""

    echo -e "Include terminal office packages? "
    read -r -p "[y/N]: " office_choice
    if [ "$office_choice" == "y" ]; then
      for i in "${TERM_OFFICE[@]}"; do
          USR_PACKAGES+=("$i")
      done
    fi

    # Which package manager to execute the script with
    PACKAGE_MGR=("sudo pacman" "yay" "paru")

    echo -e "\nWhich package manager/command would you like to use?"

    for ((i = 0; i < ${#PACKAGE_MGR[@]}; ++i)); do
        position="$i"
        echo "$position - ${PACKAGE_MGR[$i]}"
    done

    read -r -p ": " pkg_choice

    echo -e "${PACKAGE_MGR[$pkg_choice]} --needed -S" "${USR_PACKAGES[@]}" "--noconfirm\n"
    runcmd=$(echo -e "${PACKAGE_MGR[$pkg_choice]} --needed -S" "${USR_PACKAGES[@]} --noconfirm")
    echo "Execute this command?"
    read -r -p "[y/N]: " confirm_command
    if [ "$confirm_command" == "y" ]; then
        sh -c "$runcmd"
    else
        echo "Exited the script"
        exit 0
    fi
}

print_array() {
    total=0
    count=0
    for item in "$@"; do
        printf '%s' "$item "
        ((total++))
        ((count++))
        if [ $count -ge 5 ] && [ $total -ne $# ]; then
            echo ""
            count=0
        fi
    done
    echo ""
}

main() {
    case "$1" in
        -h|--help)
            echo "Usage: programs.sh [OPTION]"
            echo "Download all necessary programs that are in use in this repo,"
            echo "and some utility scripts and checks."
            echo "Options:"
            echo "  -h, --help       Display this help message."
            echo "  --yay            Check if yay is installed."
            echo "  --xdg            Check if XDG user directories are present."
            echo "  -w, --wallpaper  Check if gruvbox wallpapers are present."
            exit 0
            ;;
        --yay)
            check_yay
            exit 0
            ;;
        --xdg)
            xdg_dirs_check
            exit 0
            ;;
        -w|--wallpaper)
            wallpaper_check
            exit 0
            ;;
        *)
            check_yay
            xdg_dirs_check
            wallpaper_check
            install_pkgs
            exit 0
            ;;
    esac
}

main "$@"
