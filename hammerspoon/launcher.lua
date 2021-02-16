local launcher = {}

function launcher:start(modifier, mapping)
  for key, app in pairs(mapping) do
    hs.hotkey.bind(modifier, key, function()
      hs.application.launchOrFocus(app)
    end)
  end
end

return launcher
