# Dotfiles

My personal configuration files, but I guess you can use them too if you'd like 

![Hi there](https://gitlab.com/k_lar/dotfiles/uploads/a4347394bfd9c939455dbdb94bdccffb/dotfiles.gif)

## Installation

I wrote my own installation script to make it easier to install on a fresh Arch install.  
Currently only supporting Arch based distros.  

1. Clone the repository into your home directory, make it hidden and enter it:  
```console
git clone https://gitlab.com/k_lar/dotfiles .dotfiles; cd .dotfiles
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

### Wayland

Finally made the switch to wayland, but support for x11 is still in the dotfiles.
I'm not getting rid of it, but I won't maintain it unless something breaks horribly.
`programs.sh` will still default to x11, unless you specifically choose to download
wayland packages.

## Programs

- WM: [Hyprland](https://hyprland.org/)
- Notification daemon: [dunst](https://github.com/dunst-project/dunst)
- Music player: ncmpcpp + mpd
- Program launcher: rofi [(wayland fork)](https://github.com/lbonn/rofi)
- Terminal: [foot](https://codeberg.org/dnkl/foot) + [my fork of st](https://gitlab.com/k_lar/st)
- Browser: LibreWolf and Chromium
- Terminal multiplexer: Tmux
- Panel/Bar: [Waybar](https://github.com/Alexays/Waybar)
- Dotfiles "manager": Stow
    * I bundle [stash](https://github.com/shawnohare/stash) with my dotfiles so even
    if I'm without internet, I can still manage my dotfiles effectively.
    Is this stupid? Maybe.  

![Doing Nothing](https://gitlab.com/k_lar/dotfiles/uploads/a25cc94e8043412fc5ecb329942d1a02/doing_nothing.png)

## Editor

- NeoVim (for scripting and programming)  
![Neovim](https://gitlab.com/k_lar/dotfiles/uploads/1ca7d323a85cff8ea8ecdea9e2fab67f/nvim.png)  

- Emacs (For writing documents and tinkering)  
![Emacs](https://gitlab.com/k_lar/dotfiles/uploads/51195516cea1e2d38e84e17293e6cc6e/emacs.png)  

## My scripts/programs

- `programs.sh`  
  An install script that can *theoretically* bring you from a minimal arch install **with
  X11 or Wayland**, to a full setup with a window manager, office tools, notification daemon
  and much more.  

- `volume.sh`  
  A simple script that pops up a notification whenever you change volume with a keyboard shortcut.  
  ![volume.sh](https://gitlab.com/k_lar/dotfiles/uploads/628a0dbaacb5c6b26e56a399b63561bb/volume.gif)  

- `brem`  
  My own notes/reminders program written in POSIX sh. I have a different repository for the
  standalone script and I mirror it here. (I don't feel like using submodules for something like
  this) You can find the repo [here](https://gitlab.com/k_lar/brem).  
  ![brem](https://gitlab.com/k_lar/dotfiles/uploads/5906f9d2e7f1e5e0779f9eab46df1409/brem.png)  

- `powernap`  
  I wrote this program for a very dumb reason. I've rewritten it now and it's finally presentable!
  Basically it's the equivalent of this: `sleep $1 && poweroff` but with the ability to tell you
  when the script was started and when the computer will shut down. If you give it more than 5 mins
  to shut down, when there is only 5 mins remaining, it will trigger a notification warning you.  

- `tmux-sessionizer`  
  This is a neat script ~~stolen~~ taken from ThePrimeagen. It creates a tmux workspace/session with
  the name of the opened folder that you chose, to focus that session on its specific task

- `autostart.sh` (for bspwm x11 setup)  
  A simple autostart script that launches all programs listed in `$HOME/.config/autostart` in a line
  by line fashion. Upon launching every program, it creates a file `/dev/shm/.autostarted_bspwm` so
  that it can be checked if the script was executed before. That's the reason for this script's
  existence, because I wanted to start some programs (e.g. discord) but when I restarted/refreshed
  bspwm it would run it again because it was listed in bspwm's launch script. This was also a way to
  debloat my bspwm config file, as it takes out the lines you would usually have in there for
  launching every program and replaces it with this:  
  ```bash
  if [ ! -e /dev/shm/.autostarted_bspwm ]; then
      sh -c "$HOME/.dotfiles/scripts/autostart.sh" &
  fi
  ```

- `run_polkit.sh` (for bspwm x11 setup)  
  Script that runs the xfce polkit agent on startup, this one creates a `/dev/shm/.polkit_running`
  file and it also doesn't run itself again if the file exists. This is done inside bspwmrc with
  this code snippet:  
  ```bash
  if [ ! -e /dev/shm/.polkit_running ]; then
      sh -c "$HOME/.dotfiles/scripts/run_polkit.sh" &
  fi
  ```

- `toggle_esc2caps.sh / toggle_caffeine.sh` (for bspwm x11 setup)  
  Helper scripts that are bound to keybindings in sxhkdrc that toggle my weird keyboard hack with
  capslock being ESC when pressed and CTRL when held (this toggle is for when I'm playing games that
  are incompatible with this hack or when someone else is on my computer). The other toggle is for
  caffeine, which just makes it so that my PC can't go to sleep.

- `random_wall.sh`  
  It's surprisingly hard to seamlessly replace a wallpaper on Hyprland without
  showing one of the default Hyprland wallpapers. This script manages to do
  that by running `swaybg`, storing it's PID and killing all other `swaybg`
  processes after a tiny delay to not show the default wallpaper.

- `change_shell.sh`  
  I didn't feel like going through the process of changing shells manually when I downloaded zsh,
  so I made a script that does it for me with a simple TUI interface. Needs root privilages to be
  executed.

- `open`  
  My own `xdg-open` clone, it's pretty simple but it works without having to deal with .desktop
  files which are a PAIN.

### Rofi

- Theme: Gruvbox rounded  
  The original design is from [this](https://github.com/lr-tech/rofi-themes-collection) repository.  
  I just adjusted the colors to fit the [gruvbox](https://github.com/morhetz/gruvbox) theme.  

- Power-menu script  
  A mildly modified version of [this](https://github.com/jluttine/rofi-power-menu) script.  
  ![power-menu](https://gitlab.com/k_lar/dotfiles/uploads/8fb22e60c0b1af90db97625afce592aa/power-menu.png)  

- Rofi-gummy (temperature and brightness manager)  
  A rofi wrapper for some basic temperature and brightness presets I use at night to not completely
  ruin my eyes. It's using [gummy](https://github.com/Fushko/gummy) as its backend. It handles both
  temperature and brightness at the same time and I find it more convenient than using something
  like redshift and xbrightness or brightnessctl.  
  ![rofi-gummy](https://gitlab.com/k_lar/dotfiles/uploads/4e9c70aec2deba35e5a3a0150ff61312/rofi-gummy.png)  


## Font

- [Iosevka StyleSet 07 (Monaco Style)](https://typeof.net/Iosevka/)
- [IBM Plex](https://www.ibm.com/plex/) _(Not using this anymore)_
- [Blex Mono Nerd Font](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/IBMPlexMono) - A fork of IBM Plex with powerline glyphs _(Not using this anymore)_
- [Iosevka Nerd Font](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Iosevka) -
Iosevka with powerline glyphs
