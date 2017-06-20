hs.hotkey.bind({"cmd", "alt", "ctrl"}, "W", function()
  --hs.alert.show("Hello World!")
  hs.notify.new({title="Hammerspoon", informativeText="Hello World"}):send()
end)
