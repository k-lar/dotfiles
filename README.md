# Dotfiles

My personal configuration files, but I guess you can use them too if you'd like 

![Hi there](https://gitlab.com/k_lar/dotfiles/uploads/e6b4124de77bbc0cf3f682f89e156e04/hi_there.gif)

## Installation

I wrote my own installation script to make it easier to install on a fresh arch install.  
Currently only supporting arch based distros.  

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

## Programs

- WM: [BSPWM](https://github.com/baskerville/bspwm) (Binary Space Partitioning Window Manager)
- Compositor: Picom [(FT-Labs fork)](https://github.com/FT-Labs/picom)
- Hotkey daemon: [sxhkd](https://github.com/baskerville/sxhkd)
- Notification daemon: [dunst](https://github.com/dunst-project/dunst)
- Music player: ncmpcpp + mpd
- Program launcher: rofi
- Terminal: My "fork" of [st](https://gitlab.com/k_lar/st) (The original can be found [here](https://st.suckless.org/))
- Browser: LibreWolf and Chromium
- Terminal multiplexer: Tmux
- Panel/Bar: Polybar
- Dotfiles "manager": Stow
    * I bundle [stash](https://github.com/shawnohare/stash) with my dotfiles so even
    if I'm without internet, I can still manage my dotfiles effectively.
    Is this stupid? Maybe.  

![Vibing](https://gitlab.com/k_lar/dotfiles/uploads/64003ec095d10615a1d4dc1d864060b3/vibing.png)

## Editor

- NeoVim (for scripting and programming)  
![Editing with nvim](https://gitlab.com/k_lar/dotfiles/uploads/d494e0de1e03dddbd445ef0cb5a0b1d1/editing_vim.png)  

- Emacs (For writing documents and tinkering)  
![Emacs with btop](https://gitlab.com/k_lar/dotfiles/uploads/7e28969078a3c5eaa70c43132b9e25a0/emacs_btop_git.png)  

## My scripts/programs

- `programs.sh`  
  An install script that can *theoretically* bring you from a minimal arch install with Xorg, to a
  full setup with a window manager, office tools, notification daemon and much more.  

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

- [IBM Plex](https://www.ibm.com/plex/)
- [Blex Mono Nerd Font](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/IBMPlexMono) - A fork of IBM Plex with powerline glyphs
- [Iosevka Nerd Font](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Iosevka) -
Iosevka with powerline glyphs
