# Dotfiles

My personal configuration files

## Installation

I wrote my own installation script to make it easier to install on a fresh arch install.  
Currently only supporting arch based distros.  

1. Clone the repository into your home directory, make it hidden and enter it:  
```console
git clone https://gitlab.com/k_lar/dotfiles; mv dotfiles .dotfiles; cd .dotfiles
```

2. Use the script `programs.sh` to download all of my used programs (it also installs yay):  
   It should guide you through the installation of everything. I recommend installing all packages,
   but you do have a choice of which kind of packages to not install.
```console
cd scripts
./programs.sh
```

3. Once everything is installed, you can use the script `stow.sh` to apply all of my dotfiles to
   your system. It will symlink all files in this repo with stow.  
   **WARNING: YOU WILL BE ASKED TO REPLACE YOUR `.bashrc` WITH THE ONE IN THIS REPO. IT WILL NOT DELETE
   THE PREVIOUS ONE, BUT IT WILL RENAME IT TO `.bashrc.old`**  
   
```console
cd ..
./stow.sh
```

## Programs

- WM: [BSPWM](https://github.com/baskerville/bspwm) (Binary Space Partitioning Window Manager)
- Compositor: Picom [(pijulius fork)](https://github.com/pijulius/picom)
- Hotkey daemon: [sxhkd](https://github.com/baskerville/sxhkd)
- Notification daemon: [dunst](https://github.com/dunst-project/dunst)
- Music player: ncmpcpp + mpd
- Program launcher: rofi
- Terminal: My "fork" of [st](https://gitlab.com/k_lar/st) (The original can be found [here](https://st.suckless.org/))
- Browser: LibreWolf and Chromium
- Terminal multiplexer: Tmux
- Panel/Bar: Polybar
- Dotfiles "manager": Stow

## Editor

- NeoVim (for scripting and programming)
- Emacs (For writing documents and tinkering)

## My scripts/programs

- `programs.sh`  
  An install script that can *theoretically* bring you from a minimal arch install with Xorg, to a
  full setup with a window manager, office tools, notification daemon and much more.  

- `volume.sh`  
  A simple script that pops up a notification whenever you change volume with a keyboard shortcut.  

- `brem`  
  My own notes/reminders program written in POSIX sh. I have a different repository for the
  standalone script and I mirror it here. (I don't feel like using submodules for something like
  this) You can find the repo [here](https://gitlab.com/k_lar/brem).  

- `powernap`  
  I wrote this program for a very dumb reason. It's also probably some of the worst code you've ever
  seen. I'm not proud of this but it is mine, so I have to apologize to anyone who wants to take a
  look at it. Basically it's the equivalent of this: `sleep $1 && poweroff` but with the ability to
  tell you when the script was started and when the computer will shut down. If you give it more
  than 5 mins to shut down, when there is only 5 mins remaining, it will trigger a notification
  warning you.  

- `tmux-sessionizer`  
  This is a neat script ~~stolen~~ taken from ThePrimeagen. It creates a tmux workspace/session with
  the name of the opened folder that you chose, to focus that session on its specific task

### Rofi

- Theme: Gruvbox rounded  
  The original design is from [this](https://github.com/lr-tech/rofi-themes-collection) repository.  
  I just adjusted the colors to fit the [gruvbox](https://github.com/morhetz/gruvbox) theme.  

- Power-menu script  
  A mildly modified version of [this](https://github.com/jluttine/rofi-power-menu) script.  

- Rofi-gummy (temperature and brightness manager)  
  A rofi wrapper for some basic temperature and brightness presets I use at night to not completely
  ruin my eyes. It's using [gummy](https://github.com/Fushko/gummy) as its backend. It handles both
  temperature and brightness at the same time and I find it more convenient than using something
  like redshift and xbrightness or brightnessctl.  


## Font

- [IBM Plex](https://www.ibm.com/plex/)
- [Blex Mono Nerd Font](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/IBMPlexMono) - A fork of IBM Plex with powerline glyphs
- [Iosevka Nerd Font](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Iosevka) -
Iosevka with powerline glyphs