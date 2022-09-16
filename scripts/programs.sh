#!/bin/sh

# ===============================================================================
# This shell script downloads all necessary programs that are in use in this repo.
# FOR PERSONAL USE ONLY.
# Distributions currently supported: Arch
# ===============================================================================

# List of programs to be downloaded
# ===============================================================================

CORE_PACKAGES=("neovim" "mpv" "feh" "zathura" "zathura-pdf-mupdf" "xcolor" "thunar"
"thunar-volman" "gvfs" "gvfs-mtp" "alacritty" "when" "git" "rofi" "nomacs" "xclip" "pamixer"
"unrar" "zip" "unzip" "ncdu" "keepass" "file-roller" "exa" "ripgrep" "fzf" "btop" "tmux"
"pavucontrol" "flameshot" "bat" "stow" "ttf-ibm-plex" "emacs-nativecomp" "network-manager-applet")

DE_PACKAGES=("bspwm" "sxhkd" "picom-pijulius-git" "mtpfs" "lightdm" "polybar-git"
"boomer-git" "cava-git" "i3lock-color" "pfetch" "ttf-blex-nerd-font-git"
"lightdm-gtk-greeter" "lxappearance" "ttf-iosevka-nerd" "ttf-font-awesome"
"otf-font-awesome" "noto-fonts-main" "gummy-git" "dunst")

TERM_OFFICE=("texlive-core" "pandoc" "texlive-latexextra" "sc-im" "cbonsai" "mdp")

MISC_PKGS=("yt-dlp" "ntfs-3g" "ncmpcpp")

# ===============================================================================

# Check if yay is installed
if [[ ! -d "/opt/yay" ]]; then
    echo "It seems that yay is not installed on your system."
    read -p  "Would you like to install it? [y/N]: " yay_choice
    if [ "$yay_choice" == "y" ]; then
      sudo pacman -S base-devel git &&
      cd /opt &&
      sudo git clone https://aur.archlinux.org/yay.git &&
      sudo chown -R $(whoami):users ./yay &&
      cd yay &&
      makepkg -si
    fi
fi

echo "List all the packages that can be installed?"
read -p "[y/N]: " confirm_selection
if [ "$confirm_selection" == "y" ]; then
  echo -e "\n========================================="
  echo -e "\e[1mCORE_PACKAGES:\e[0m\n${CORE_PACKAGES[@]}\n"
  echo -e "\e[1mDE_PACKAGES: (yay or paru needed!)\e[0m\n${DE_PACKAGES[@]}\n"
  echo -e "\e[1mMISC_PACKAGES: (yay or paru needed!)\e[0m\n${MISC_PKGS[@]}\n"
  echo -e "\e[1mTERM_OFFICE: (yay or paru needed!)\e[0m\n${TERM_OFFICE[@]}"
  echo -e "========================================="
fi
echo ""


# Ask user what optional packages they want to install
USR_PACKAGES=()
for i in "${CORE_PACKAGES[@]}"; do
  USR_PACKAGES+="$i "
done

echo -e "Include DE packages?"
read -p "[y/N]: " de_choice
if [ "$de_choice" == "y" ]; then
  for i in "${DE_PACKAGES[@]}"; do
    USR_PACKAGES+="$i "
  done
fi
echo ""

echo -e "Include misc packages?"
read -p "[y/N]: " misc_choice
if [ "$misc_choice" == "y" ]; then
  for i in "${MISC_PKGS[@]}"; do
    USR_PACKAGES+="$i "
  done
fi
echo ""

echo -e "Include terminal office packages? "
read -p "[y/N]: " office_choice
if [ "$office_choice" == "y" ]; then
  for i in "${TERM_OFFICE[@]}"; do
    USR_PACKAGES+="$i "
  done
fi

# Which package manager to execute the script with
PACKAGE_MGR=("sudo pacman" "yay" "paru")

echo -e "\nWhich package manager/command would you like to use?"

for ((i = 0; i < ${#PACKAGE_MGR[@]}; ++i)); do
    position=$(( $i ))
    echo "$position - ${PACKAGE_MGR[$i]}"
done

read -p ": " pkg_choice

echo -e "${PACKAGE_MGR[$pkg_choice]} -S ${USR_PACKAGES[@]} --noconfirm\n"
echo "Execute this command?"
read -p "[y/N]: " confirm_command
if [ "$confirm_command" == "y" ]; then
  ${PACKAGE_MGR[$pkg_choice]} -S ${USR_PACKAGES[@]} #--noconfirm
else
  echo "Exited the script"
  exit 0
fi
