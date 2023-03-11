#!/bin/bash

# ===============================================================================
# This shell script downloads all necessary programs that are in use in this repo.
# FOR PERSONAL USE ONLY.
# Distributions currently supported: Arch
# ===============================================================================
# List of programs to be downloaded
# ===============================================================================

CORE_PACKAGES=("neovim" "mpv" "feh" "zathura" "zathura-pdf-mupdf" "xcolor" "thunar"
"thunar-volman" "gvfs" "gvfs-mtp" "alacritty" "when" "git" "rofi" "nomacs" "xclip" "pamixer"
"unrar" "zip" "unzip" "ncdu" "keepass" "file-roller" "exa" "ripgrep" "fzf" "btop" "tmux" "xcape"
"pavucontrol" "flameshot" "bat" "stow" "ttf-ibm-plex" "emacs-nativecomp"
"network-manager-applet" "bash-completion")

DE_PACKAGES=("bspwm" "sxhkd" "picom-ftlabs-git" "mtpfs" "lightdm" "polybar"
"boomer-git" "cava-git" "i3lock-color" "pfetch" "ttf-blex-nerd-font-git"
"lightdm-gtk-greeter" "lxappearance" "ttf-iosevka-nerd" "ttf-font-awesome"
"otf-font-awesome" "noto-fonts-main" "gummy-git" "dunst" "gruvbox-dark-icons-gtk"
"gruvbox-dark-gtk" "ttc-iosevka-ss07")

WAYLAND_PKGS=("hyprland-bin" "hyprpicker-git" "wl-clipboard" "rofi-lbonn-wayland-git"
"foot" "waybar" "swaylock-effects" "swaybg")

TERM_OFFICE=("texlive-core" "pandoc" "texlive-latexextra" "sc-im" "cbonsai" "mdp")

MISC_PKGS=("yt-dlp" "ntfs-3g" "ncmpcpp" "dash" "zsh" "inetutils" "caffeine-ng" "ctags"
"cscope" "global")

# ===============================================================================

# Check if yay is installed
if [[ ! -d "/opt/yay" ]]; then
    echo "It seems that yay is not installed on your system."
    read -r -p  "Would you like to install it? [y/N]: " yay_choice
    if [ "$yay_choice" == "y" ]; then
        sudo pacman -S base-devel git &&
        cd /opt &&
        sudo git clone https://aur.archlinux.org/yay.git &&
        sudo chown -R "$(whoami)":users ./yay &&
        cd yay &&
        makepkg -si
    fi
fi

echo "List all the packages that can be installed?"
read -r -p "[y/N]: " confirm_selection
if [ "$confirm_selection" == "y" ]; then
    printf "\n=========================================\n"
    printf "\e[1mCORE_PACKAGES:\n\e[0m"
    printf '%s ' "${CORE_PACKAGES[@]}"
    printf "\n"

    printf "\e[1mDE_PACKAGES:\n\e[0m"
    printf '%s ' "${DE_PACKAGES[@]}"
    printf "\n"

    printf "\e[1mMISC_PKGS:\n\e[0m"
    printf '%s ' "${MISC_PKGS[@]}"
    printf "\n"

    printf "\e[1mWAYLAND_PKGS:\n\e[0m"
    printf '%s ' "${WAYLAND_PKGS[@]}"
    printf "\n"

    printf "\e[1mTERM_OFFICE:\n\e[0m"
    printf '%s ' "${TERM_OFFICE[@]}"
    printf "\n"
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

echo -e "${PACKAGE_MGR[$pkg_choice]} -S" "${USR_PACKAGES[@]}" "--noconfirm\n"
runcmd=$(echo -e "${PACKAGE_MGR[$pkg_choice]} -S" "${USR_PACKAGES[@]}")
echo "Execute this command?"
read -r -p "[y/N]: " confirm_command
if [ "$confirm_command" == "y" ]; then
    sh -c "$runcmd"
else
    echo "Exited the script"
    exit 0
fi
