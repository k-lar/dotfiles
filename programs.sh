#!/bin/sh

# ===============================================================================
# This shell script downloads all necessary programs that are in use in this repo.
# FOR PERSONAL USE ONLY.
# Distributions currently supported: Arch
# ===============================================================================

# List of programs to be downloaded

PACMAN_PACKAGES=("bspwm" "sxhkd" "neovim" "mpv" "feh" "zathura" "zathura-pdf-poppler"
"xcolor" "nitrogen" "thunar" "thunar-volman" "gvfs" "gvfs-mtp" "kitty" "when" "git"
"mtpfs" "rofi" "mpv" "nomacs" "fuse" "xclip" "unrar" "zip" "unzip" "ncdu"
"lxappearance" "keepass" "file-roller" "exa" "ripgrep" "fzf" "btop"
"pavucontrol" "flameshot" "bat")

AUR_PACKAGES=("cava-git" "picom-pijulius-git" "yt-dlp" "onlyoffice-bin" "pfetch"
"polybar-git" "deadd-notification-center-bin" "boomer-git" "cbonsai" "i3lock-color")

OPTIONAL_PACKAGES=("texlive-core" "pandoc" "texlive-latexextra" "ntfs-3g")

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
  echo -e "\e[1mPACMAN_PACKAGES:\e[0m\n${PACMAN_PACKAGES[@]}"
  echo -e "\e[1mAUR_PACKAGES:\e[0m\n${AUR_PACKAGES[@]}"
  echo -e "\e[1mOPTIONAL_PACKAGES:\e[0m\n${OPTIONAL_PACKAGES[@]}"
  echo -e "=========================================\n"
fi
echo ""


# Ask the user if they want to install AUR and optional packages
echo -e "Include AUR packages?"
read -p "[y/N]: " aur_choice
echo ""
echo -e "Include optional packages?"
read -p "[y/N]: " opt_choice


# Which package manager to execute the script with
PACKAGE_MGR=("sudo pacman" "yay" "paru")

echo -e "\nWhich package manager/command would you like to use?"

for ((i = 0; i < ${#PACKAGE_MGR[@]}; ++i)); do
    position=$(( $i ))
    echo "$position - ${PACKAGE_MGR[$i]}"
done

read -p ": " pkg_choice


# A bunch of if statements because I have no idea how to make multidimensional
# arrays work in bash
if [[ "$aur_choice" != "y" ]] && [[ "$opt_choice" != "y" ]]; then
  echo -e "${PACKAGE_MGR[$pkg_choice]} -S ${PACMAN_PACKAGES[@]} --noconfirm\n"
  echo "Execute this command?"
  read -p "[y/N]: " confirm_command
  if [ "$confirm_command" == "y" ]; then
    ${PACKAGE_MGR[$pkg_choice]} -S ${PACMAN_PACKAGES[@]} --noconfirm
  else
    echo "Exited the script"
    exit 0
  fi
fi


if [[ "$aur_choice" != "y" ]] && [[ "$opt_choice" == "y" ]]; then
  echo -e "${PACKAGE_MGR[$pkg_choice]} -S ${PACMAN_PACKAGES[@]} ${OPTIONAL_PACKAGES[@]} --noconfirm\n"
  echo "Execute this command?"
  read -p "[y/N]: " confirm_command
  if [ "$confirm_command" == "y" ]; then
    ${PACKAGE_MGR[$pkg_choice]} -S ${PACMAN_PACKAGES[@]} ${OPTIONAL_PACKAGES[@]} --noconfirm
  else
    echo "Exited the script"
    exit 0
  fi
fi


if [[ "$aur_choice" == "y" ]] && [[ "$opt_choice" != "y" ]]; then
  echo -e "${PACKAGE_MGR[$pkg_choice]} -S ${PACMAN_PACKAGES[@]} ${AUR_PACKAGES[@]} --noconfirm\n"
  echo "Execute this command?"
  read -p "[y/N]: " confirm_command
  if [ "$confirm_command" == "y" ]; then
    ${PACKAGE_MGR[$pkg_choice]} -S ${PACMAN_PACKAGES[@]} ${AUR_PACKAGES[@]} --noconfirm
  else
    echo "Exited the script"
    exit 0
  fi
fi


if [[ "$aur_choice" == "y" ]] && [[ "$opt_choice" == "y" ]]; then
  echo -e "${PACKAGE_MGR[$pkg_choice]} -S ${PACMAN_PACKAGES[@]} ${AUR_PACKAGES[@]} ${OPTIONAL_PACKAGES[@]} --noconfirm\n"
  echo "Execute this command?"
  read -p "[y/N]: " confirm_command
  if [ "$confirm_command" == "y" ]; then
    ${PACKAGE_MGR[$pkg_choice]} -S ${PACMAN_PACKAGES[@]} ${AUR_PACKAGES[@]} ${OPTIONAL_PACKAGES[@]} --noconfirm
  else
    echo "Exited the script"
    exit 0
  fi
fi

