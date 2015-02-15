#!/usr/bin/env bash

#################################
# Replaces current Slate's config
# @author Victor Lopez
#################################

# Include bash helpers
source ../misc/lib.sh

# Create a backup of the existing configuration in case it already exists
slate_cfg="/Users/$(whoami)/.slate"
slate_cfg_backup="/Users/$(whoami)/.slate.bak"
slate_cfg_local="/Users/$(whoami)/.dotfiles/Slate/slate_config"

if [ -f "${slate_cfg}" ]; then
    ok "Found previous Slate's config file"
    /bin/mv "${slate_cfg}" "${slate_cfg_backup}"
    ok "I've created a backup for you on ${slate_cfg_backup}"
else
    warn "I couldn't find any previous config so... no backup for you"
fi

# Create symlink
/bin/ln -s "${slate_cfg_local}" "${slate_cfg}"
ok "New config symlink created. {slate_cfg_local} -> ${slate_cfg}"
ok "Reload Slate configuration and that's it"
exit 0
