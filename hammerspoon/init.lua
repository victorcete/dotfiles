---------------------------------------------
-- AppLauncher
-- Binds hyper key to desired apps
hs.loadSpoon("AppLauncher")

local hyper = {"cmd", "alt", "ctrl", "shift"}

spoon.AppLauncher.modifiers = hyper
local hotkeys = {
    c = "Safari",
    e = "Visual Studio Code",
    i = "iTerm",
    n = "Notes",
    t = "Telegram",
}
spoon.AppLauncher:bindHotkeys(hotkeys)
---------------------------------------------

---------------------------------------------
-- Window resizing

-- Full screen
hs.hotkey.bind(hyper, "8", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h
  win:setFrame(f)
end)
---------------------------------------------

---------------------------------------------
-- Helps maximize battery life
batteryWatcher = nil

function batteryWatcherCallback()
    batteryPercentage = hs.battery.percentage()
    batteryCharging = hs.battery.isCharging()
    batteryCharged = hs.battery.isCharged()

    if batteryCharged then
        hs.notify.new({title="Hammerspoon", informativeText="Battery charged.", autoWithdraw=false}):send()
    end

    if not batteryCharging then
        if batteryPercentage < 35 then
            hs.notify.new({title="Hammerspoon", informativeText="Low battery.", autoWithdraw=false}):send()
        end
    end
end

batteryWatcher = hs.battery.watcher.new(batteryWatcherCallback)
batteryWatcher:start()
---------------------------------------------

---------------------------------------------
-- Reload HammerSpoong config
hs.hotkey.bind(hyper, "0", function()
    hs.reload()
  end)
---------------------------------------------
