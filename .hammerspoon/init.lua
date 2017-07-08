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
-- Turn off Slack and Rambox on battery
--
function watchBatteryUnplug()
  local powerSource = hs.battery.powerSource()
  -- Show when power source has changed
  if powerSource == 'Battery Power' then
    alert('Charger Unplugged')
  end
  local percentage = hs.battery.percentage()
  -- Close apps when battery goes lower than 35%
  if percentage < 35.0 then
    -- local ramboxWatcher = hs.application.watcher.new(function(name, eventType, app)
    --   if eventType ~= hs.application.watcher.activated then return end
    --   if name == 'Rambox' then
    --     app:kill()
    --   end
    -- end)
    -- ramboxWatcher:start()
  end
end
batteryWatcher = hs.battery.watcher.new(watchBatteryUnplug):start();


--
--  Start app on School WiFi
--
function onSchoolWifi()
  schoolSSID = 'UWMWiFi'
  newSSID = hs.wifi.currentNework()
  if newSSID == schoolSSID then
    hs.spotify.play()
    hs.audiodevice.defaultOutputDevice():setVolume(10)
  end
end
