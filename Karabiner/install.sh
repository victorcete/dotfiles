#!/usr/bin/env bash

############################################
# Quick script to replace Karabiner's config
# @author Victor Lopez
############################################

# Include bash helpers
source ../misc/lib.sh

# Check if Karabiner is present on the system
karabiner_dir="/Users/$(whoami)/Library/Application Support/Karabiner/"

if [ -d "${karabiner_dir}" ]; then
    ok "Found Karabiner in ${karabiner_dir}"
else
    error "Cannot found Karabiner in ${karabiner_dir}. Please install it before proceeding"
    exit 1
fi

# Create a backup of the private.xml config, just in case
config=private.xml
config_backup=private.xml.bak
config_local="/Users/$(whoami)/.dotfiles/Karabiner/private.xml"

if [ -f "${karabiner_dir}${config}" ]; then
    ok "Found previous Karabiner's config file"
    /bin/mv "${karabiner_dir}${config}" "${karabiner_dir}${config_backup}"
    ok "I've created a backup for you on ${karabiner_dir}${config_backup}"
else
    warn "I couldn't find any previous config so... no backup for you"
fi

# Create symlink
/bin/ln -s "${config_local}" "${karabiner_dir}${config}"
ok "New config symlink created. ${karabiner_dir}${config} -> ${config_local}"
ok "Now open Karabiner, Reload XML and select the new key map"
exit 0
