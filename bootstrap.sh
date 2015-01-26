#!/usr/bin/env bash

##########################################################
# Bootstrap script for Mac OS X Yosemite new installations
# @author Victor Lopez
##########################################################

# Include bash helpers
source misc/lib.sh

# Install XCode command line tools
ok "Installing XCode command line tools"
xcode-select --install

# Install Homebrew
ok "Installing Homebrew"
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install latest git version
ok "Installing git"
brew install git

# Set up Github SSH keys
ok "Generating SSH key for Github"
read -p "Enter your email: " email ; echo
ssh-keygen -t rsa -C "$email" -f $HOME/.ssh/id_rsa_github
cat ~/.ssh/id_rsa_github.pub
cat ~/.ssh/id_rsa_github.pub | pbcopy
ok "Public key copied on the clipboard. Now, add the key to your Github account - https://github.com/account/ssh and press enter to continue."
