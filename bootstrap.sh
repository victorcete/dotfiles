#!/usr/bin/env bash

##########################################################
# Bootstrap script for Mac OS X Yosemite new installations
# @author Victor Lopez
##########################################################

# Include bash helpers
# Source: https://github.com/atomantic/dotfiles/blob/master/lib.sh
source misc/lib.sh

# Say hi
bot "Welcome to a new OS X installation!"
sleep 2

#############################
# 1. Homebrew and Brew Cask #
#############################

# Install Homebrew
bot "Homebrew and Brew Cask"
running "Checking => Homebrew installation"
brew_bin=$(which brew) 2>&1 > /dev/null
if [[ $? != 0 ]]; then
	action "Installing => Homebrew"
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        ok
        if [[ $? != 0 ]]; then
                error "unable to install homebrew, script $0 abort!"
                exit -1
                fi
else
        ok
fi

# Run doctor + update
running "Running => Homebrew doctor"
brew doctor >/dev/null
ok

running "Updating => Homebrew"
brew update >/dev/null
ok

# Brew Cask
running "Checking => Homebrew Cask installation"
output=$(brew tap | grep cask)
if [[ $? != 0 ]]; then
        action "Installing => Homebrew Cask"
        require_brew caskroom/cask/brew-cask
        ok
else
        ok
fi

############################
# 2. Homebrew applications #
############################

bot "Homebrew apps"

### Utilities

# http://beyondgrep.com/
require_brew ack

require_brew git

# https://www.gnu.org/software/coreutils
require_brew coreutils

# http://joeyh.name/code/moreutils/
require_brew moreutils

# http://www.gnu.org/software/findutils/
require_brew findutils

require_brew watch
require_brew wget

### Editors
require_brew vim --override-system-vim

### Docker
require_brew fig
require_brew docker
require_brew boot2docker

### Misc
require_brew fortune

#############################
# 3. Brew Cask applications #
#############################

bot "Brew Cask apps"

### Chat
require_cask adium

### Music
require_cask soundcleod
require_cask spotify

### Utilities
require_cask iterm2
require_cask sublime-text
require_cask the-unarchiver
require_cask vlc

### Web browsers
require_cask google-chrome
require_cask firefox

### Window managements
require_cask karabiner
require_cask seil
require_cask slate

### Virtualization
require_cask vagrant
require_cask virtualbox

bot "Done! Cleaning cache"
brew cleanup > /dev/null 2>&1

# Set up Github SSH keys
#ok "Generating SSH key for Github"
#read -p "Enter your email: " email ; echo
#ssh-keygen -t rsa -C "$email" -f $HOME/.ssh/id_rsa_github
#cat ~/.ssh/id_rsa_github.pub
#cat ~/.ssh/id_rsa_github.pub | pbcopy
#ok "Public key copied on the clipboard. Now, add the key to your Github account - https://github.com/account/ssh and press enter to continue."
