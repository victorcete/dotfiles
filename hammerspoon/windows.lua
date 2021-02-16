local windows = {}

function windows:start(modifier)
    -- top
    hs.hotkey.bind(modifier, "4", function()
        local win = hs.window.focusedWindow()
        local f = win:frame()
        local max = win:screen():frame()

        f.x = max.x
        f.y = max.y + (max.y / 2)
        f.w = max.w
        f.h = max.h / 2
        win:setFrame(f)
    end)

    -- bottom
    hs.hotkey.bind(modifier, "5", function()
        local win = hs.window.focusedWindow()
        local f = win:frame()
        local max = win:screen():frame()

        f.x = max.x
        f.y = max.y / 2
        f.w = max.w
        f.h = max.h / 2
        win:setFrame(f)
    end)

    -- left
    hs.hotkey.bind(modifier, "6", function()
        local win = hs.window.focusedWindow()
        local f = win:frame()
        local max = win:screen():frame()

        f.x = max.x
        f.y = max.y
        f.w = max.w / 2
        f.h = max.h
        win:setFrame(f)
    end)

    -- right
    hs.hotkey.bind(modifier, "7", function()
        local win = hs.window.focusedWindow()
        local f = win:frame()
        local max = win:screen():frame()

        f.x = max.x + (max.w / 2)
        f.y = max.y
        f.w = max.w / 2
        f.h = max.h
        win:setFrame(f)
    end)

    -- fullscreen
    hs.hotkey.bind(modifier, "8", function()
        local win = hs.window.focusedWindow()
        local f = win:frame()
        local max = win:screen():frame()

        f.x = max.x
        f.y = max.y
        f.w = max.w
        f.h = max.h
        win:setFrame(f)
    end)
end

return windows
