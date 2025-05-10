#!/bin/bash

# ===============================================================================
# This shell script downloads all necessary programs that are in use in this repo.
# FOR PERSONAL USE ONLY.
# Distributions currently supported: Arch
# ===============================================================================
# List of programs to be downloaded
# ===============================================================================

CORE_PACKAGES=("neovim" "mpv" "feh" "zathura" "zathura-pdf-mupdf" "xcolor"
"thunar" "cloc" "thunar-volman" "gvfs" "gvfs-mtp" "alacritty" "when" "git"
"loupe" "pamixer" "unrar" "zip" "unzip" "keepassxc" "file-roller" "eza"
"ripgrep" "fzf" "btop" "tmux" "pavucontrol" "bat" "stow" "tree-sitter-cli"
"emacs-nativecomp" "gnome-disk-utility" "alsa-utils" "network-manager-applet"
"bash-completion" "polkit" "python-pipx" "ttc-iosevka-ss07"
"gdu" "sddm" "fastfetch" "dunst" "mtpfs" "ttf-iosevka-nerd" "ttf-font-awesome"
"otf-font-awesome" "pacman-contrib" "ttf-ibm-plex" "ntfs-3g" "pipewire"
"pipewire-pulse" "pipewire-alsa" "pipewire-jack" "helvum" "ghostty"
"ttf-nerd-fonts-symbols" "ttf-nerd-fonts-symbols-common"
"ttf-ibmplex-mono-nerd" "zoxide" "ouch" "yazi")

XORG_PACKAGES=("bspwm" "sxhkd" "picom" "polybar" "lxappearance"
"xclip" "i3lock-color" "gummy-git" "xcape" "boomer-git" "rofi" "flameshot"
"xfce-polkit")

WAYLAND_PACKAGES=("hyprland" "hyprpicker" "hyprpaper" "wl-clipboard" "udiskie"
"waybar" "swaybg" "grim" "slurp" "hyprlock" "nwg-look" "rofi-wayland"
"hypridle" "satty" "uwsm" "hyprpolkitagent" "cliphist" "hyprsunset")

STYLE_PACKAGES=("noto-fonts-main" "gruvbox-dark-gtk" "gruvbox-dark-icons-gtk"
"cava" "sddm-sugar-dark")

TERM_OFFICE=("texlive-core" "pandoc-bin" "texlive-latexextra" "sc-im" "cbonsai"
"mdp" "texlive-fontsrecommended")

MISC_PACKAGES=("yt-dlp" "ncmpcpp" "dash" "zsh" "inetutils" "caffeine-ng"
"ctags" "cscope" "global" "fish")

# ===============================================================================

print_version() {
    printf "0.1.3\n"
}

user_prompt() {
    prompt_message=$1
    default_option=${2^^}

    if [ "$default_option" == "Y" ]; then
        y_n_prompt="[Y/n]"
    elif [ "$default_option" == "N" ]; then
        y_n_prompt="[y/N]"
    else
        echo "No default option provided for user_prompt."
        exit 1
    fi

    user_input=""

    read -r -p "$prompt_message $y_n_prompt: " user_input
    user_input=${user_input:-$default_option} # Set default option if user input is empty
    case "${user_input,,}" in
        y*) echo "y" ;;
        n*) echo "n" ;;
        *) echo "${default_option,,}" ;; # Return default option in lowercase
    esac
}

check_yay() {
    # Check if yay is installed
    if [ -d "/opt/yay" ]; then
        echo "Yay is installed on your system."
        yay_reinstall_choice=$(user_prompt "Would you like to reinstall it?" "n")
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
        printf '%b' "\e[1mYay is required to install packages that aren't in core!\e[0m\n"
        yay_choice=$(user_prompt "Would you like to install it?" "n")
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

sddm_apply_theme() {
    # Check if yay is installed
    if ! type yay > /dev/null; then
        echo "Can't check for sddm theme without yay installed."
        exit 1
    fi

    # Check if command exited with 0 (success)
    if yay -Qi sddm-sugar-dark > /dev/null; then
        echo "SDDM Dark Sugar theme is installed on your system."
        # Check if the theme is already enabled
        if ! grep -q "Current=sugar-dark" /etc/sddm.conf; then
            sddm_theme_choice=$(user_prompt "Would you like to enable it?" "n")
            if [ "$sddm_theme_choice" == "y" ]; then
                printf "[Theme]\nCurrent=sugar-dark\n" | sudo tee -a /etc/sddm.conf > /dev/null
                echo "SDDM Dark Sugar theme enabled!"
            fi
        else
            echo "SDDM Dark Sugar theme is already enabled!"
        fi
    else
        echo "SDDM Dark Sugar theme is not installed on your system."
        sddm_theme_choice=$(user_prompt "Would you like to install and enable it?" "n")
        if [ "$sddm_theme_choice" == "y" ]; then
            yay -S --noconfirm sddm-sugar-dark
            printf "[Theme]\nCurrent=sugar-dark\n" | sudo tee -a /etc/sddm.conf > /dev/null
            echo "SDDM Dark Sugar theme installed and enabled!"
        fi
    fi
    echo ""
}

setup_questions() {
    laptop_choice=$(user_prompt "Are you on a laptop?" "n")
    if [ "$laptop_choice" == "y" ] && [ ! -e "$HOME/.dotfiles/options/laptop" ]; then
        touch "$HOME/.dotfiles/options/.laptop"
    fi
    echo ""
}

xdg_dirs_check() {
    # Check if XDG user dirs are present
    if [[ ! -e "$HOME/.config/user-dirs.dirs" ]]; then
        echo "XDG user directories not present on system."
        xdg_choice=$(user_prompt "Would you like to create them?" "y")
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
        walls_choice=$(user_prompt "Would you like to download them?" "y")
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
    confirm_selection=$(user_prompt "List all the packages that can be installed?" "n")
    if [ "$confirm_selection" == "y" ]; then
        printf "\n=========================================\n"
        printf '%b' "\e[1mCORE_PACKAGES: (${#CORE_PACKAGES[@]})\n\e[0m"
        print_array "${CORE_PACKAGES[@]}"
        printf "\n"

        printf '%b' "\e[1mXORG_PACKAGES: (${#XORG_PACKAGES[@]})\n\e[0m"
        print_array "${XORG_PACKAGES[@]}"
        printf "\n"

        printf '%b' "\e[1mWAYLAND_PACKAGES: (${#WAYLAND_PACKAGES[@]})\n\e[0m"
        print_array "${WAYLAND_PACKAGES[@]}"
        printf "\n"

        printf '%b' "\e[1mSTYLE_PACKAGES: (${#STYLE_PACKAGES[@]})\n\e[0m"
        print_array "${STYLE_PACKAGES[@]}"
        printf "\n"

        printf '%b' "\e[1mMISC_PACKAGES: (${#MISC_PACKAGES[@]})\n\e[0m"
        print_array "${MISC_PACKAGES[@]}"
        printf "\n"

        printf '%b' "\e[1mTERM_OFFICE: (${#TERM_OFFICE[@]})\n\e[0m"
        print_array "${TERM_OFFICE[@]}"
        printf "=========================================\n"
    fi
    echo ""

    # Ask user what optional packages they want to install
    USR_PACKAGES=()
    for i in "${CORE_PACKAGES[@]}"; do
        USR_PACKAGES+=("$i")
    done

    xorg_choice=$(user_prompt "Include Xorg packages?" "n")
    if [ "$xorg_choice" == "y" ]; then
        for i in "${XORG_PACKAGES[@]}"; do
            USR_PACKAGES+=("$i")
        done
        echo ""
    else
        echo ""
        echo -e "Include wayland packages?"
        read -r -p "[y/N]: " wl_choice
        if [ "$wl_choice" == "y" ]; then
            for i in "${WAYLAND_PACKAGES[@]}"; do
                USR_PACKAGES+=("$i")
            done
        fi
        echo ""
    fi

    style_choice=$(user_prompt "Include style packages?" "n")
    if [ "$style_choice" == "y" ]; then
        for i in "${STYLE_PACKAGES[@]}"; do
            USR_PACKAGES+=("$i")
        done
    fi
    echo ""

    misc_choice=$(user_prompt "Include misc packages?" "n")
    if [ "$misc_choice" == "y" ]; then
        for i in "${MISC_PACKAGES[@]}"; do
            USR_PACKAGES+=("$i")
        done
    fi
    echo ""

    office_choice=$(user_prompt "Include terminal office packages?" "n")
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
        if [[ "$xorg_choice" == "y" || "$wl_choice" == "y" || "$style_choice" == "y" || "$misc_choice" == "y" || "$office_choice" == "y" ]] && [ "$position" -eq 0 ]; then
           continue
        fi
        echo "$position - ${PACKAGE_MGR[$i]}"
    done

    read -r -p ": " pkg_choice

    # If any of the optional packages are selected, set the package manager to yay
    # by default
    if [[ "$xorg_choice" == "y" || "$wl_choice" == "y" || "$style_choice" == "y" || "$misc_choice" == "y" || "$office_choice" == "y" ]]; then
        if [[ $pkg_choice -eq 0 || -z $pkg_choice ]]; then
            pkg_choice=1
        fi
    fi

    runcmd=$(echo "${PACKAGE_MGR[$pkg_choice]}" "--needed -Syu" "${USR_PACKAGES[@]}" "--noconfirm")
    echo "$runcmd"
    confirm_command=$(user_prompt "Execute this command?" "n")
    if [ "$confirm_command" == "y" ]; then
        sh -c "$runcmd"
    else
        echo "Exited the script"
        exit 0
    fi
}

is_version_older() {
    v1="$1"
    v2="$2"

    # Use sort -V (natural version sorting) to compare versions
    if [[ "$(printf '%s\n%s\n' "$v1" "$v2" | sort -V | head -n1)" == "$v1" && "$v1" != "$v2" ]]; then
        return 0  # v1 is older
    else
        return 1  # v1 is not older
    fi
}

check_for_updates() {
    curl -s https://raw.githubusercontent.com/k-lar/dotfiles/refs/heads/master/scripts/programs.sh > /tmp/programs.sh
    new_version=$(bash /tmp/programs.sh --version)
    current_version=$(print_version)

    if is_version_older "$current_version" "$new_version"; then
        echo "A new version of this script is available!"
        echo "Current version: $current_version"
        echo "New version: $new_version"
        echo "Would you like to update this script?"
        read -r -p "[y/N]: " update_choice
        if [ "$update_choice" == "y" ] || [ "$update_choice" == "Y" ]; then
            cp /tmp/programs.sh "$HOME/.dotfiles/scripts/programs.sh"
            rm /tmp/programs.sh
            echo "Script updated successfully!"
            echo "Please run the script again."
            exit 0
        else
            rm /tmp/programs.sh
        fi
    else
        echo "You are running the latest version of this script."
    fi
    exit 0
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
            echo "  --sddm-theme     Apply sddm theme (sddm-sugar-dark)."
            echo "  -u, --update     Check for updates for this script."
            echo "  -w, --wallpaper  Check if gruvbox wallpapers are present."
            echo "  -s, --setup      Set up conditional files for scripts."
            echo "  -v, --version    Display the version of this script."
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
        --sddm-theme)
            sddm_apply_theme
            exit 0
            ;;
        -w|--wallpaper)
            wallpaper_check
            exit 0
            ;;
        -s|--setup)
            setup_questions
            exit 0
            ;;
        -u|--update)
            check_for_updates
            exit 0
            ;;
        -v|--version)
            print_version
            exit 0
            ;;
        *)
            check_yay
            xdg_dirs_check
            setup_questions
            wallpaper_check
            install_pkgs
            sddm_apply_theme
            exit 0
            ;;
    esac
}

main "$@"
