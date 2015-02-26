# victorcete's dotfiles

The aim is to have as much automated configuration as possible when you have to use a new Mac workstation. I tend to use the same apps, editors, window managers in both personal and professional environments so if I get a new Mac I won't need to go through the tedious process of configuring my settings.

## TODO list

- Set some OS X defaults
- Applications configuration
  - Adium
  - git
  - iTerm2
  - oh-my-zsh
  - Sublime Text
  - tmux
  - vim

## Current apps

- Installed with brew
  - ack
  - boot2docker
  - coreutils
  - docker
  - fig
  - findutils
  - fortune
  - git
  - moreutils
  - vim
  - watch
  - wget
  - wireshark

- Installed with brew cask
  - Adium
  - Chrome
  - Firefox
  - iTerm2
  - Karabiner
  - Seil
  - Slate
  - Soundcleod
  - Spotify
  - Sublime Text 2
  - The Unarchiver
  - Vagrant
  - Virtualbox
  - VLC Media Player

## Installation steps

All the scripts will assume that the repo is cloned under ~/.dotfiles to create the corresponding symlinks.
```bash
git clone https://github.com/victorcete/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./bootstrap.sh
```

After that you should configure the Window Manager apps:

### Seil

- Under the 'Setting' tab, change the caps lock key to keycode 80 (the equilavent of F19)
- Close the window, don't quit the app

### Karabiner + Slate

- Enable Karabiner and Slate on OS X Privacy settings under: System Preferences > Security & Privacy > Privacy > Accesibility
- Go to System Preferences > Keyboard > Modifier keys > Set Caps Lock to 'No action'
- Run the scripts provided on this repo:
```bash
cd ~/.dotfiles/Karabiner ; ./install.sh
cd ~/.dotfiles/Slate ; ./install.sh
```
