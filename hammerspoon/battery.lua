batteryWatcher = nil

function batteryWatcherCallback()
    batteryPercentage = hs.battery.percentage()
    batteryCharging = hs.battery.isCharging()
    batteryCharged = hs.battery.isCharged()

    if batteryCharged then
        hs.alert.show("Battery charged", nil, nil, 5)
    end

    if not batteryCharging then
        if batteryPercentage < 35 then
            hs.alert.show("Low battery", nil, nil, 5)
        end
    end
end

batteryWatcher = hs.battery.watcher.new(batteryWatcherCallback):start()
