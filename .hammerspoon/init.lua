alert = hs.alert.show
notify = hs.notify.new
bindKeys = hs.hotkey.bind

--
-- Test binding
--
bindKeys({"cmd", "alt", "ctrl"}, "W", function()
  notify({title="Hammerspoon", informativeText="Activated"}):send()
end)

--
--  Reload Config
--
function configReload(files)
  for _,file in pairs(files) do
    if file:sub(-4) == '.lua' then
      hs.reload()
    end
  end
end
configWatcher = hs.pathwatcher.new(os.getenv('HOME') .. '/.hammerspoon/', configReload):start()

--
-- Turn off Slack and Rambox when battery reaches 35%
--
function watchBatteryUnplug()
  local powerSource = hs.battery.powerSource()
  local percentage = hs.battery.percentage()
  if powerSource == 'Battery Power' and percentage <= 35.0 then
    hs.application.get('Rambox'):kill()
    hs.application.get('Slack'):kill()
  end
end
batteryWatcher = hs.battery.watcher.new(watchBatteryUnplug):start()


--
--  Start app on School WiFi
--
function SSIDChange()
  local schoolSSID = 'UWMWiFi'
  local newSSID = hs.wifi.currentNework()
  if newSSID == schoolSSID then
    hs.spotify.play()
    hs.audiodevice.defaultOutputDevice():setVolume(10)
  end
end
wifiWatcher = hs.wifi.watcher.new(SSIDChange):start()
