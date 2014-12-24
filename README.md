# victorcete's dotfiles

The aim is to have as much automated configuration as possible when you have to use a new Mac workstation. I tend to use the same apps, editors, window managers in both personal and professional environments so if I get a new Mac I won't need to go through the tedious process of configuring my settings.

## TODO list

- Homebrew formulaes
- Set some OS X defaults
- iTerm2
- Sublime Text config
- Git configuration
- tmux
- oh-my-zsh configuration
- Adium

## Prerequisites

### [Seil](https://pqrs.org/osx/karabiner/seil.html.en)

Seil is an utility to map your Capslock key to another key.

### [Karabiner](https://pqrs.org/osx/karabiner/index.html.en)

Karabiner is a keyboard customizer for OS X, I use it to assign ctrl+alt+command+shift to the Caps Lock key and then use that "master" key in Slate.

### [Slate](https://github.com/jigish/slate)

Slate is a Window Manager application for OS X. Before I switched from Linux to Mac, I was using [i3wm](https://i3wm.org/) and I needed more or less the same power and flexibility. I am quite happy with Slate, for the moment :)

## Installation instructions

All the scripts will assume that the repo is cloned under ~/.dotfiles to create the corresponding symlinks.
```bash
git clone https://github.com/victorcete/dotfiles.git ~/.dotfiles
```

### Seil

- Under the 'Setting' tab, change the caps lock key to keycode 80 (the equilavent of F19)
- Close the window, don't quit the app

### Karabiner + Slate

- Run the scripts provided on this repo:
```bash
cd ~/.dotfiles/Karabiner ; ./install.sh
cd ~/.dotfiles/Slate ; ./install.sh
```
