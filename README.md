# victorcete's dotfiles

## Prerequisites

### [Seil](https://pqrs.org/osx/karabiner/seil.html.en)

Seil is an utility to map your Capslock key to another key.

### [Karabiner](https://pqrs.org/osx/karabiner/index.html.en)

Karabiner is a keyboard customizer for OS X, I use it to assign ctrl+alt+command+shift to the Caps Lock key and then use that "master" key in Slate.

### [Slate](https://github.com/jigish/slate)

Slate is a Window Manager application for OS X. Before I switched from Linux to Mac, I was using [i3wm](https://i3wm.org/) and I needed more or less the same power and flexibility. I am quite happy with Slate, for the moment :)

## Installation instructions

### Seil

- Under the 'Setting' tab, change the caps lock key to keycode 80 (the equilavent of F19)
- Close the window, don't quit the app

### Karabiner + Slate

- Run the scripts provided on this repo:
```bash
git clone https://github.com/victorcete/dotfiles.git ~/.dotfiles
cd ~/.dotfiles/Karabiner ; ./install.sh
cd ~/.dotfiles/Slate ; ./install.sh
```
