local hyper = {"cmd", "alt", "ctrl", "shift"}

batteryWatcher = nil

function batteryWatcherCallback()
    batteryPercentage = hs.battery.percentage()
    batteryCharging = hs.battery.isCharging()
    batteryCharged = hs.battery.isCharged()

    if batteryCharged then
        hs.notify.new({title="Hammerspoon", informativeText="Battery charged. Please disconnect now."}):send()
    end

    if not batteryCharging then
        if batteryPercentage < 40 then
            hs.notify.new({title="Hammerspoon", informativeText="Low battery. Please connect the charger now."}):send()
        end
    end
end

batteryWatcher = hs.battery.watcher.new(batteryWatcherCallback)
batteryWatcher:start()
