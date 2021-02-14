local hyper = {"cmd", "alt", "ctrl", "shift"}

batteryWatcher = nil

function batteryWatcherCallback()
    batteryPercentage = hs.battery.percentage()
    batteryCharging = hs.battery.isCharging()
    batteryCharged = hs.battery.isCharged()

    if batteryCharged then
        hs.alert.show("battery charged, please disconnect")
    end

    if not batteryCharging then
        if batteryPercentage < 40 then
            hs.alert.show("please connect the charger")
        end
    end
end

batteryWatcher = hs.battery.watcher.new(batteryWatcherCallback)
batteryWatcher:start()
