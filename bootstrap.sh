#!/usr/bin/env bash

###################################
# Bootstrap script for macOS Sierra
###################################

# Ask for the sudo password
sudo -v

# update existing `sudo` time stamp until the script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

####################
# 1. XCode CLI Tools
####################

# xcode-cli: check installation
if [ ! -d "/Library/Developer/CommandLineTools" ]; then
  xcode-select --install
  read -p "xcode-cli: press [ENTER] after finishing the installation..."
fi

#############
# 2. Homebrew
#############

# homebrew: check installation
/usr/bin/which brew 2>&1 >/dev/null
if [[ $? != 0 ]]; then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  if [[ $? != 0 ]]; then
    echo "homebrew: unexpected problem, aborting"
    exit 1
  fi
fi

######################################
## 3. Miscellaneous downloads        #
######################################

# iTerm2 colorschemes
if [ ! -f ~/Downloads/iTerm2-colorschemes.tar.gz ]
then
  $(which wget) "https://github.com/mbadolato/iTerm2-Color-Schemes/tarball/master" -O ~/Downloads/iTerm2-colorschemes.tar.gz
fi

# Google Noto font
if [ ! -f ~/Downloads/NotoMono-hinted.zip ]
then
  $(which wget) "https://noto-website.storage.googleapis.com/pkgs/NotoMono-hinted.zip" -O ~/Downloads/NotoMono-hinted.zip
fi
exit 0
