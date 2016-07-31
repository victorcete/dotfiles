#!/usr/bin/env bash

############################################################
# Bootstrap script for Mac OS X El Capitan new installations
# @author Victor Lopez
############################################################


# Include bash helpers
# https://github.com/atomantic/dotfiles/blob/master/lib.sh
source misc/lib.sh

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

# brew: check installation
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

# brew add sbin to PATH
cat >> ~/.bash_profile <<EOF
# brew
export PATH="/usr/local/sbin:$PATH"
EOF

# http://beyondgrep.com/
require_brew ack

# https://github.com/wting/autojump/
require_brew autojump
cat >> ~/.bash_profile <<EOF
# autojump
[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh
EOF

# https://www.gnu.org/software/bash/
require_brew bash

# https://bash-completion.alioth.debian.org/
require_brew bash-completion 
cat >> ~/.bash_profile <<EOF
# bash completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi
EOF

# http://www.colordiff.org/
require_brew colordiff

# https://www.gnu.org/software/coreutils/
require_brew coreutils

# http://curl.haxx.se/
require_brew curl

# http://www.gnu.org/software/findutils/
require_brew findutils

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

# https://www.gnupg.org/
require_brew gpg

# https://www.mercurial-scm.org/
require_brew hg

# https://github.com/xyb/homebrew-cask-completion
require_brew homebrew/completions/brew-cask-completion

# https://github.com/ekalinin/pip-bash-completion
require_brew homebrew/completions/pip-completion

# https://github.com/mitchellh/vagrant
require_brew homebrew/completions/vagrant-completion

# https://github.com/max-horvath/htop-osx
require_brew htop-osx

# https://github.com/lra/mackup
# require_brew mackup

# http://joeyh.name/code/moreutils/
require_brew moreutils

# https://www.python.org/
require_brew python
$(which pip) install --upgrade pip setuptools 2>&1 >/dev/null
$(which pip) install pep8 2>&1 >/dev/null
$(which pip) install virtualenv 2>&1 >/dev/null
$(which pip) install virtualenvwrapper 2>&1 >/dev/null
export WORKON_HOME=~/.envs
$(which mkdir) -p $WORKON_HOME 2>&1 >/dev/null
cat >> ~/.bash_profile <<EOF
# python virtualenvwrapper
export WORKON_HOME=~/.envs
source /usr/local/bin/virtualenvwrapper.sh
EOF

# http://www.openssh.com/
require_brew ssh-copy-id

# https://tmux.github.io/
require_brew tmux

# http://mama.indstate.edu/users/ice/tree/
require_brew tree

# http://www.vim.org/
require_brew vim --override-system-vi

# install pathogen
$(which mkdir) -p ~/.vim/{autoload,bundle} 2>&1 >/dev/null
$(which curl) -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim 2>&1 >/dev/null

# get solarized colors for vim
pushd ~/.vim/bundle 2>&1 >/dev/null
if [ ! -d vim-colors-solarized ]; then
    git clone git://github.com/altercation/vim-colors-solarized.git 2>&1 >/dev/null
fi
popd 2>&1 >/dev/null

# put some basic .vimrc config
if [ ! -f ~/.vimrc ]; then
    cat >~/.vimrc <<EOF
" pathogen
execute pathogen#infect()

" color settings
syntax on
set bg=light
colorscheme solarized

" backspace behaviour
set backspace=indent,eol,start

" indentation
filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

" get rid of anoying ~file
set nobackup

" line numbers
set number
EOF
fi

# https://gitlab.com/procps-ng/procps/
require_brew watch

# https://www.gnu.org/software/wget/
require_brew wget

# -------------------------------------------------------------------
# User configuration section
# -------------------------------------------------------------------
export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

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

# http://lightheadsw.com/caffeine/
require_cask caffeine

# https://www.docker.com/products/docker
require_cask docker
read -p "docker: run Docker now for initial set-up and press [ENTER] to continue"

# https://www.iterm2.com/
require_cask iterm2

# http://www.keepassx.org/
require_cask keepassx

# https://slack.com/
require_cask slack

# https://www.spotify.com/
require_cask spotify

# http://www.sublimetext.com/3/
require_cask sublime-text

# https://osxfuse.github.io/
require_cask sshfs

# https://macos.telegram.org
require_cask telegram

# https://tunnelblick.net/
require_cask tunnelblick

# http://unarchiver.c3.cx/unarchiver/
require_cask the-unarchiver

# https://www.vagrantup.com/
require_cask vagrant

# https://www.virtualbox.org/
require_cask virtualbox
require_cask virtualbox-extension-pack

# https://vivaldi.com
require_cask vivaldi

# https://www.videolan.org/vlc/
require_cask vlc

#####################################
# 6. Window management applications #
#####################################

bot "window management apps"
# https://pqrs.org/osx/karabiner/seil.html.en/
require_cask seil

defaults -currentHost read -g | grep modifiermapping 2>&1 >/dev/null
if [ $? -eq 0 ]; then
	ok "seil: caps lock key already disabled"
else
	keyboard_vendorid=`ioreg -n IOHIDKeyboard -r | grep '"VendorID"' | awk -F '=' '{print $2}' | sed 's/ //g'`
	keyboard_productid=`ioreg -n IOHIDKeyboard -r | grep '"ProductID"' | awk -F '=' '{print $2}' | sed 's/ //g'`
	action "seil: disabling caps lock key"
	defaults -currentHost write -g com.apple.keyboard.modifiermapping.${keyboard_vendorid}-${keyboard_productid}-0 \
	-array '<dict><key>HIDKeyboardModifierMappingSrc</key><integer>0</integer><key>HIDKeyboardModifierMappingDst</key><integer>-1</integer></dict>'
	read -p "seil: run Seil - remap capslock key to keycode 80 and press [ENTER] to continue"
fi

# https://pqrs.org/osx/karabiner/
require_cask karabiner

# Check if Karabiner is present on the system
karabiner_dir="/Users/$(whoami)/Library/Application Support/Karabiner/"

if [ -d "${karabiner_dir}" ]; then
	ok "karabiner: found in ${karabiner_dir}"
else
	read -p "karabiner: run the application and allow the accesibility permissions, then press [ENTER]"
	read -p "karabiner: go to System Preferences > Keyboard > Modifier Keys > Set Caps Lock to 'No Action', then press [ENTER]"
fi
# Create a backup of the private.xml config, just in case
config=private.xml
config_backup=private.xml.bak
config_local="/Users/$(whoami)/.dotfiles/Karabiner/private.xml"

if [ -f "${karabiner_dir}${config}" ]; then
    if [ ! -f "${karabiner_dir}${config_backup}" ]; then
        ok "karabiner: found previous config file"
        /bin/mv "${karabiner_dir}${config}" "${karabiner_dir}${config_backup}" 2>&1 >/dev/null
        ok "karabiner: created a backup on ${karabiner_dir}${config_backup}"
    else
        ok "karabiner: backup already in place, skipping"
    fi
else
    warn "karabiner: couldn't find any previous config so... no backup for you"
fi

# Create symlink
if [ ! -h "${karabiner_dir}${config}" ]; then
	/bin/ln -s "${config_local}" "${karabiner_dir}${config}"
	ok "karabiner: new config symlink created. ${karabiner_dir}${config} -> ${config_local}"
	read -p "karabiner: run the application and click on 'Reload XML' and enable the master key, then press [ENTER]"
else
	ok "karabiner: config symlink already in place, skipping"
fi

# https://github.com/mattr-/slate/
require_cask slate

# Create a backup of the existing configuration in case it already exists
slate_cfg="/Users/$(whoami)/.slate"
slate_cfg_backup="/Users/$(whoami)/.slate.bak"
slate_cfg_local="/Users/$(whoami)/.dotfiles/Slate/slate_config"

if [ -f "${slate_cfg}" ]; then
	if [ ! -f "${slate_cfg_backup}" ]; then
		ok "slate: found previous config file"
		/bin/mv "${slate_cfg}" "${slate_cfg_backup}" 2>&1 >/dev/null
		ok "slate: created a backup on ${slate_cfg_backup}"
	else
		ok "slate: backup already in place, skipping"
	fi
else
    warn "slate: couldn't find any previous config so... no backup for you"
fi

# Create symlink
if [ ! -h "${slate_cfg}" ]; then
	/bin/ln -s "${slate_cfg_local}" "${slate_cfg}"
	ok "slate: config symlink created. {slate_cfg_local} -> ${slate_cfg}"
fi

#####################################
# 7. Miscellaneous downloads        #
#####################################

bot "Downloading misc stuff! Check ~/Downloads after this!"
$(which sleep) 2

bot "Downloading iTerm2 color schemes"
$(which wget) "https://github.com/mbadolato/iTerm2-Color-Schemes/tarball/master" -O ~/Downloads/iTerm2-colorschemes.tar.gz

bot "Downloading Meslo font (for powerline)"
$(which wget) "https://github.com/powerline/fonts/raw/master/Meslo/Meslo%20LG%20M%20DZ%20Regular%20for%20Powerline.otf" -O ~/Downloads/Meslo_Regular_Powerline.otf

bot "Downloading Ubuntu fonts"
$(which wget) "http://font.ubuntu.com/download/ubuntu-font-family-0.83.zip" -O ~/Downloads/ubuntu-font-family-0.83.zip

bot "Downloading Hack font"
$(which wget) "https://github.com/chrissimpkins/Hack/releases/download/v2.019/Hack-v2_019-ttf.zip" -O ~/Downloads/Hack-v2_019-ttf.zip

exit 0
