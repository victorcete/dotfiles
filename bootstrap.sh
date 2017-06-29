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

######################
# 3. Brew applications
######################

[[ ! -d ~/.bash_profile.d ]] && /bin/mkdir ~/.bash_profile.d

# https://github.com/wting/autojump/
/usr/local/bin/brew install autojump

cat > ~/.bash_profile.d/autojump <<EOF
# autojump
[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh
EOF

if [ ! $(/usr/bin/grep 'source bash_profile.d/autojump' ~/.bash_profile 2>/dev/null) ]
then
  cat >> ~/.bash_profile <<EOF
# autojump
source ~/.bash_profile.d/autojump

EOF
fi

# https://www.gnu.org/software/bash/
/usr/local/bin/brew install bash

# https://bash-completion.alioth.debian.org/
/usr/local/bin/brew install bash-completion

cat > ~/.bash_profile.d/bash-completion <<EOF
# bash completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi
EOF

if [ ! $(/usr/bin/grep 'source bash_profile.d/bash-completion' ~/.bash_profile 2>/dev/null) ]
then
  cat >> ~/.bash_profile <<EOF
# bash completion
source ~/.bash_profile.d/bash-completion

EOF
fi

# http://curl.haxx.se/
/usr/local/bin/brew install curl

# https://git-scm.com/
/usr/local/bin/brew install git

# https://github.com/xyb/homebrew-cask-completion
/usr/local/bin/brew install homebrew/completions/brew-cask-completion

# https://github.com/mitchellh/vagrant
/usr/local/bin/brew install homebrew/completions/vagrant-completion

# https://github.com/max-horvath/htop-osx
/usr/local/bin/brew install htop-osx

# http://www.openssh.com/
/usr/local/bin/brew install ssh-copy-id

# https://tmux.github.io/
/usr/local/bin/brew install tmux

# http://mama.indstate.edu/users/ice/tree/
/usr/local/bin/brew install tree

# http://www.vim.org/
/usr/local/bin/brew install vim --with-override-system-vi

# https://gitlab.com/procps-ng/procps/
/usr/local/bin/brew install watch

# https://www.gnu.org/software/wget/
/usr/local/bin/brew install wget

/usr/local/bin/brew cleanup

##############
# 4. Brew Cask
##############

/usr/local/bin/brew tap | grep cask
if [[ $? != 0 ]]; then
  /usr/local/bin/brew tap caskroom/cask >/dev/null 2>&1
fi

############################
## 5. Brew Cask applications
############################

# https://1password.com/
/usr/local/bin/brew cask install 1password

# https://www.android.com/filetransfer/
# /usr/local/bin/brew cask install android-file-transfer

# http://lightheadsw.com/caffeine/
/usr/local/bin/brew cask install caffeine

# https://www.google.com/chrome/
/usr/local/bin/brew cask install google-chrome

# https://www.iterm2.com/
/usr/local/bin/brew cask install iterm2

# https://pqrs.org/osx/karabiner/
/usr/local/bin/brew cask install karabiner-elements

# http://www.keepassx.org/
/usr/local/bin/brew cask install keepassx

# https://github.com/mattr-/slate
/usr/local/bin/brew cask install mattr-slate

# https://slack.com/
/usr/local/bin/brew cask install slack

## https://www.spotify.com/
/usr/local/bin/brew cask install spotify

# https://macos.telegram.org
/usr/local/bin/brew cask install telegram

# http://unarchiver.c3.cx/unarchiver/
/usr/local/bin/brew cask install the-unarchiver

# https://www.vagrantup.com/
/usr/local/bin/brew cask install vagrant

# https://www.virtualbox.org/
/usr/local/bin/brew cask install virtualbox
/usr/local/bin/brew cask install virtualbox-extension-pack

######################################
## 6. Miscellaneous downloads        #
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
