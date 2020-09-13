mmpkg = mmpkg or {}
mmpkg.config = mmpkg.config or {}

function mmpkg.config.timestampbox_click()
  if mmpkg.conf.timestamps then
    mmpkg.conf.timestamps = false
    mmpkg.config.timestampbox:setBackgroundImage(mmpkg.resources .. [[/checkbox_unticked.png]])
  else
    mmpkg.conf.timestamps = true
    mmpkg.config.timestampbox:setBackgroundImage(mmpkg.resources .. [[/checkbox_ticked.png]])
  end
end

function mmpkg.config.scanhelperbox_click()
  if mmpkg.config.scanhelper == true then
    mmpkg.config.scanhelper = false
    mmpkg.config.scanhelperbox:setBackgroundImage(mmpkg.resources .. [[/checkbox_unticked.png]])
  else
    mmpkg.config.scanhelper = true
    mmpkg.config.scanhelperbox:setBackgroundImage(mmpkg.resources .. [[/checkbox_ticked.png]])
  end
end

function mmpkg.config.loggingbox_click()
  if mmpkg.config.logging == true then
    mmpkg.config.logging = false
    mmpkg.config.loggingbox:setBackgroundImage(mmpkg.resources .. [[/checkbox_unticked.png]])
  else
    mmpkg.config.logging = true
    mmpkg.config.loggingbox:setBackgroundImage(mmpkg.resources .. [[/checkbox_ticked.png]])
  end
end

function mmpkg.config.linkifybox_click()
  if mmpkg.config.linkify == true then
    mmpkg.config.linkify = false
    mmpkg.config.linkifybox:setBackgroundImage(mmpkg.resources .. [[/checkbox_unticked.png]])
  else
    mmpkg.config.linkify = true
    mmpkg.config.linkifybox:setBackgroundImage(mmpkg.resources .. [[/checkbox_ticked.png]])
  end
end

function mmpkg.config.areaonlybox_click()
  if mmpkg.conf.areaonly == true then
    mmpkg.conf.areaonly = false
    mmpkg.config.areaonlybox:setBackgroundImage(mmpkg.resources .. [[/checkbox_unticked.png]])
  else
    mmpkg.conf.areaonly = true
    mmpkg.config.areaonlybox:setBackgroundImage(mmpkg.resources .. [[/checkbox_ticked.png]])
  end
end

function mmpkg.config.savebtn_click()
  table.save(getMudletHomeDir() .. "/mmpkg.conf", mmpkg.conf)
  mmpkg.confwin:hide()
  mmpkg.config.applysettings()
  cecho("\n<green>Saved!")
end

function mmpkg.config.cancelbtn_click()
  table.load(getMudletHomeDir() .. "/mmpkg.conf", mmpkg.conf)
  mmpkg.confwin:hide()
  cecho("\n<red>No changes saved.")
end

function mmpkg.config.Alliancebox_click()
  if mmpkg.config.alliance == true then
    mmpkg.config.alliance = false
    mmpkg.config.Alliancebox:setBackgroundImage(mmpkg.resources .. [[/checkbox_unticked.png]])
  else
    mmpkg.config.alliance = true
    mmpkg.config.Alliancebox:setBackgroundImage(mmpkg.resources .. [[/checkbox_ticked.png]])
  end
  mmpkg.config.doTabs()
end

function mmpkg.config.Clanbox_click()
  if mmpkg.config.clan == true then
    mmpkg.config.clan = false
    mmpkg.config.Clan:setBackgroundImage(mmpkg.resources .. [[/checkbox_unticked.png]])
  else
    mmpkg.config.clan = true
    mmpkg.config.Clan:setBackgroundImage(mmpkg.resources .. [[/checkbox_ticked.png]])
  end
  mmpkg.config.doTabs()
end

function mmpkg.config.Novicebox_click()
  if mmpkg.config.novice == true then
    mmpkg.config.novice = false
    mmpkg.config.Novicebox:setBackgroundImage(mmpkg.resources .. [[/checkbox_unticked.png]])
  else
    mmpkg.config.novice = true
    mmpkg.config.Novicebox:setBackgroundImage(mmpkg.resources .. [[/checkbox_ticked.png]])
  end
  mmpkg.config.doTabs()
end

function mmpkg.config.Tellsbox_click()
  if mmpkg.config.tells == true then
    mmpkg.config.tells = false
    mmpkg.config.Tellsbox:setBackgroundImage(mmpkg.resources .. [[/checkbox_unticked.png]])
  else
    mmpkg.config.tells = true
    mmpkg.config.Tellsbox:setBackgroundImage(mmpkg.resources .. [[/checkbox_ticked.png]])
  end
  mmpkg.config.doTabs()
end

function mmpkg.config.Formbox_click()
  if mmpkg.config.form == true then
    mmpkg.config.form = false
    mmpkg.config.Formbox:setBackgroundImage(mmpkg.resources .. [[/checkbox_unticked.png]])
  else
    mmpkg.config.form = true
    mmpkg.config.Formbox:setBackgroundImage(mmpkg.resources .. [[/checkbox_ticked.png]])
  end
  mmpkg.config.doTabs()
end

function mmpkg.config.Relaysbox_click()
  if mmpkg.config.relays == true then
    mmpkg.config.relays = false
    mmpkg.config.Relaysbox:setBackgroundImage(mmpkg.resources .. [[/checkbox_unticked.png]])
  else
    mmpkg.config.relays = true
    mmpkg.config.Relaysbox:setBackgroundImage(mmpkg.resources .. [[/checkbox_ticked.png]])
  end
  mmpkg.config.doTabs()
end

function mmpkg.config.Talkbox_click()
  if mmpkg.config.talk == true then
    mmpkg.config.talk = false
    mmpkg.config.Talkbox:setBackgroundImage(mmpkg.resources .. [[/checkbox_unticked.png]])
  else
    mmpkg.config.talk = true
    mmpkg.config.Talkbox:setBackgroundImage(mmpkg.resources .. [[/checkbox_ticked.png]])
  end
  mmpkg.config.doTabs()
end

function mmpkg.config.doTabs()
  mmpkg.conf.tabs = {"All"}
  local tabcount = 1
  if mmpkg.config.alliance then
    tabcount = tabcount + 1
    mmpkg.conf.tabs[tabcount] = "Alliance"
  end
  if mmpkg.config.clan then
    tabcount = tabcount + 1
    mmpkg.conf.tabs[tabcount] = "Clan"
  end
  if mmpkg.config.novice then
    tabcount = tabcount + 1
    mmpkg.conf.tabs[tabcount] = "Novice"
  end
  if mmpkg.config.tells then
    tabcount = tabcount + 1
    mmpkg.conf.tabs[tabcount] = "Tells"
  end
  if mmpkg.config.form then
    tabcount = tabcount + 1
    mmpkg.conf.tabs[tabcount] = "Form"
  end
  if mmpkg.config.relays then
    tabcount = tabcount + 1
    mmpkg.conf.tabs[tabcount] = "Relays"
  end
  if mmpkg.config.talk then
    tabcount = tabcount + 1
    mmpkg.conf.tabs[tabcount] = "Talk"
  end
end

function mmpkg.config.applysettings()
  if (mmpkg.conf.timestamps == true) then
    mmpkg.Captures:enableTimestamp()
  else
    mmpkg.Captures:disableTimestamp()
  end
  if (mmpkg.config.scanhelper == true) then
    enableTrigger("Scan Helper")
  else
    disableTrigger("Scan Helper")
  end
  if (mmpkg.config.linkify == true) then
    enableTrigger("Linkify")
  else
    disableTrigger("Linkify")
  end
  if (mmpkg.config.logging == true) then
    mmpkg.conf.logging = true
  else
    mmpkg.conf.logging = false
  end
  for _, chan in pairs(mmpkg.Captures.consoles) do
    if not table.contains(mmpkg.conf.tabs, chan) then
      mmpkg.Captures:removeTab(chan)
      disableTrigger(chan)
    end
  end
  for _, chan in spairs(mmpkg.conf.tabs) do
    if not table.contains(mmpkg.Captures.consoles, chan) then
      mmpkg.Captures:addTab(chan)
      enableTrigger(chan)
    end
  end
end
