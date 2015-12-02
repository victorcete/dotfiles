#!/usr/bin/env bash

############################################################
# Bootstrap script for Mac OS X El Capitan new installations
# @author Victor Lopez
############################################################


# Include bash helpers
# https://github.com/atomantic/dotfiles/blob/master/lib.sh
# source misc/lib.sh
source helpers.sh

# Say hello
bot "New OS X installation! Please enter your sudo password before proceeding"

# Ask for the sudo password
sudo -v

# update existing `sudo` time stamp until the script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

######################
# 1. XCode CLI Tools #
######################

# xcode-cli: check installation
if [ -d "/Library/Developer/CommandLineTools" ]; then
	ok "xcode-cli: already installed"
else
	running "xcode-cli: installing"
	xcode-select --install
	read -p "xcode-cli: press [ENTER] after finishing the installation..."
fi

###########
# 2. Brew #
###########

# brew: check installation
/usr/bin/which brew 2>&1 >/dev/null
if [[ $? != 0 ]]; then
	running "brew: installing"
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	if [[ $? != 0 ]]; then
		error "brew: unexpected problem, aborting"
		exit 1
	fi
else
	ok "brew: already installed"
fi

# brew: doctor + update + upgrade
running "brew: doctor"
/usr/local/bin/brew doctor
running "brew: update"
/usr/local/bin/brew update
running "brew: upgrade"
/usr/local/bin/brew upgrade --all

########################
# 3. Brew applications #
########################

bot "brew applications"

# http://beyondgrep.com/
require_brew ack

# https://github.com/wting/autojump/
require_brew autojump

# https://www.gnu.org/software/bash/
require_brew bash

# https://bash-completion.alioth.debian.org/
require_brew bash-completion 

# http://www.colordiff.org/
require_brew colordiff

# https://www.gnu.org/software/coreutils/
require_brew coreutils

# http://curl.haxx.se/
require_brew curl

# http://www.gnu.org/software/findutils/
require_brew findutils

# http://ftp.ibiblio.org/pub/linux/games/amusements/fortune/!INDEX.html/
require_brew fortune

# https://git-scm.com/
require_brew git

# Create git configuration
/usr/local/bin/git config user.name 2>&1 >/dev/null
if [[ $? -ne 0 ]] || [[ ! -f $HOME/.gitconfig ]]; then
	# Generate ~/.gitconfig
	echo -n "[git] enter your user.name and press [ENTER]: "
	read name
	echo -n "[git] enter your user.email and press [ENTER]: "
	read email
	cat > ~/.gitconfig <<EOF 
[user]
	name = ${name}
	email = ${email}
[merge]
	tool = vimdiff
[push]
	default = simple
EOF
	ok "git: user settings configured"
else
	error "git: git config already present"
fi

# https://golang.org/
require_brew go --with-cc-common

# https://www.mercurial-scm.org/
require_brew hg

# https://github.com/xyb/homebrew-cask-completion
require_brew homebrew/completions/brew-cask-completion

# https://github.com/ekalinin/pip-bash-completion
require_brew homebrew/completions/pip-completion

# https://hub.github.com/
# require_brew hub

# http://joeyh.name/code/moreutils/
require_brew moreutils

# https://www.python.org/
require_brew python
$(which pip) install --upgrade pip setuptools 2>&1 >/dev/null

# http://www.openssh.com/
require_brew ssh-copy-id

# https://tmux.github.io/
require_brew tmux

# http://mama.indstate.edu/users/ice/tree/
require_brew tree

# http://www.vim.org/
require_brew vim --override-system-vi

# https://gitlab.com/procps-ng/procps/
require_brew watch

# https://www.gnu.org/software/wget/
require_brew wget

running "brew: cleanup"
/usr/local/bin/brew cleanup

################
# 4. Brew Cask #
################

# brew-cask: check installation
running "brew: cask"
/usr/local/bin/brew tap | grep cask
if [[ $? != 0 ]]; then
	action "brew-cask: installing"
	require_brew caskroom/cask/brew-cask
else
	ok "brew-cask: already installed"
fi

# brew-cask: tap dev/beta versions
brew tap caskroom/versions 2>&1 >/dev/null

#############################
# 5. Brew Cask applications #
#############################

bot "brew-cask applications"

# https://www.adium.im/
# require_cask adium

# https://www.iterm2.com/
require_cask iterm2-beta

# https://www.spotify.com/
require_cask spotify

# http://www.sublimetext.com/3/
require_cask sublime-text3

# https://osxfuse.github.io/
require_cask sshfs

# http://unarchiver.c3.cx/unarchiver/
require_cask the-unarchiver

# https://www.videolan.org/vlc/
require_cask vlc

exit 0
