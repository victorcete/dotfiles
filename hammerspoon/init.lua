------------------------------------------------------------------------------
-- Hyper key (previously configured in karabiner-elements)
hyper = {"cmd", "alt", "ctrl", "shift"}
------------------------------------------------------------------------------

------------------------------------------------------------------------------
--- Launcher
local launcher = require('launcher')
hotkeys = {
    r = "Safari",
    e = "Visual Studio Code",
    i = "iTerm",
    n = "Notes",
    t = "Telegram",
}
launcher:start(hyper, hotkeys)
------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- Window resizing
local windows = require('windows')
windows:start(hyper)
------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- Battery watcher
require('battery')
------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- Reload HammerSpoong config
hs.hotkey.bind(hyper, "0", function()
    hs.reload()
  end)
------------------------------------------------------------------------------
