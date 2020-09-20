function mmpkg.config.doWindow()
  mmpkg.config = mmpkg.config or {}
  if mmpkg.confwin then
    mmpkg.confwin:show()
  else
    mmpkg.confwin = Geyser.UserWindow:new(
      {
        name = "mmpkg.confwin",
        titleText = "mmpkg Configuration",
        x = "10%",
        y = "20%",
        width = 600,
        height = 400,
        color = "gray",
      }
    )
    mmpkg.confwin:disableAutoDock()
  end
  mmpkg.config.genoptions = 
  Geyser.Label:new(
    {
      name = "mmpkg.config.genoptions",
      x = 29,
      y = 21,
      fgColor = "black",
      color = "gray",
      width = 250,
      height = 20,
      message = [[General Options]],
    },
    mmpkg.confwin
  )
  mmpkg.config.timestampbox = 
  Geyser.Label:new(
    {name = "mmpkg.config.timestampbox", x = 10, y = 50, width = 21, height = 19}, mmpkg.confwin
  )
  mmpkg.config.timestamplabel = 
  Geyser.Label:new(
    {
      name = "mmpkg.config.timestamplabel",
      x = 32,
      y = 52,
      fgColor = "black",
      color = "gray",
      width = 200,
      height = 20,
      message = [[Timestamps on in Captures window?]],
    },
    mmpkg.confwin
  )
  mmpkg.config.timestampbox:setStyleSheet([[
  background-color: rgba(0,0,0,0%);
]])
  if mmpkg.conf.timestamps then
    mmpkg.config.timestamps = true
    mmpkg.config.timestampbox:setBackgroundImage(mmpkg.resources .. [[/checkbox_ticked.png]])
  else
    mmpkg.config.timestamps = false
    mmpkg.config.timestampbox:setBackgroundImage(mmpkg.resources .. [[/checkbox_unticked.png]])
  end
  mmpkg.config.timestampbox:setClickCallback("mmpkg.config.timestampbox_click")

  mmpkg.config.loggingbox = 
  Geyser.Label:new(
    {name = "mmpkg.config.logging", x = 10, y = 70, width = 21, height = 19}, mmpkg.confwin
  )
  mmpkg.config.logginglabel = 
  Geyser.Label:new(
    {
      name = "mmpkg.config.logginglabel",
      x = 32,
      y = 72,
      fgColor = "black",
      color = "gray",
      width = 200,
      height = 20,
      message = [[Log chats to file?]],
    },
    mmpkg.confwin
  )
  mmpkg.config.loggingbox:setStyleSheet([[
  background-color: rgba(0,0,0,0%);
]])
  if mmpkg.conf.logging then
    mmpkg.config.logging = true
    mmpkg.config.loggingbox:setBackgroundImage(mmpkg.resources .. [[/checkbox_ticked.png]])
  else
    mmpkg.config.logging = false
    mmpkg.config.loggingbox:setBackgroundImage(mmpkg.resources .. [[/checkbox_unticked.png]])
  end
  mmpkg.config.loggingbox:setClickCallback("mmpkg.config.loggingbox_click")

  mmpkg.config.areaonlybox = 
  Geyser.Label:new(
    {name = "mmpkg.config.areaonlybox", x = 10, y = 90, width = 21, height = 19}, mmpkg.confwin
  )
  mmpkg.config.areaonlylabel = 
  Geyser.Label:new(
    {
      name = "mmpkg.config.areaonlylabel",
      x = 32,
      y = 92,
      fgColor = "black",
      color = "gray",
      width = 220,
      height = 20,
      message = [[Show only local rooms in 'mapper where'?]],
    },
    mmpkg.confwin
  )
  mmpkg.config.areaonlybox:setStyleSheet([[
  background-color: rgba(0,0,0,0%);
]])
  if mmpkg.conf.areaonly then
    mmpkg.config.areaonly = true
    mmpkg.config.areaonlybox:setBackgroundImage(mmpkg.resources .. [[/checkbox_ticked.png]])
  else
    mmpkg.config.areaonly = false
    mmpkg.config.areaonlybox:setBackgroundImage(mmpkg.resources .. [[/checkbox_unticked.png]])
  end
  mmpkg.config.areaonlybox:setClickCallback("mmpkg.config.areaonlybox_click")

  mmpkg.config.scanhelperbox = 
  Geyser.Label:new(
    {name = "mmpkg.config.scanhelperbox", x = 10, y = 110, width = 21, height = 19}, mmpkg.confwin
  )
  mmpkg.config.scanhelperlabel = 
  Geyser.Label:new(
    {
      name = "mmpkg.config.scanhelperlabel",
      x = 32,
      y = 112,
      fgColor = "black",
      color = "gray",
      width = 220,
      height = 20,
      message = [[Enable Scan Helper?]],
    },
    mmpkg.confwin
  )
  mmpkg.config.scanhelperbox:setStyleSheet([[
  background-color: rgba(0,0,0,0%);
]])
  if isActive("Scan Helper", "trigger") == 1 then
    mmpkg.config.scanhelper = true
    mmpkg.config.scanhelperbox:setBackgroundImage(mmpkg.resources .. [[/checkbox_ticked.png]])
  else
    mmpkg.config.scanhelper = false
    mmpkg.config.scanhelperbox:setBackgroundImage(mmpkg.resources .. [[/checkbox_unticked.png]])
  end
  mmpkg.config.scanhelperbox:setClickCallback("mmpkg.config.scanhelperbox_click")

  mmpkg.config.linkifybox = 
  Geyser.Label:new(
    {name = "mmpkg.config.linkifybox", x = 10, y = 130, width = 21, height = 19}, mmpkg.confwin
  )
  mmpkg.config.linkifylabel = 
  Geyser.Label:new(
    {
      name = "mmpkg.config.linkifylabel",
      x = 32,
      y = 132,
      fgColor = "black",
      color = "gray",
      width = 220,
      height = 20,
      message = [[Web addresses in chat are clickable?]],
    },
    mmpkg.confwin
  )
  mmpkg.config.linkifybox:setStyleSheet([[
  background-color: rgba(0,0,0,0%);
]])
  if isActive("Linkify", "trigger") == 1 then
    mmpkg.config.linkify = true
    mmpkg.config.linkifybox:setBackgroundImage(mmpkg.resources .. [[/checkbox_ticked.png]])
  else
    mmpkg.config.linkify = false
    mmpkg.config.linkifybox:setBackgroundImage(mmpkg.resources .. [[/checkbox_unticked.png]])
  end
  mmpkg.config.linkifybox:setClickCallback("mmpkg.config.linkifybox_click")

  mmpkg.config.smartpromptbox = 
  Geyser.Label:new(
    {name = "mmpkg.config.smartpromptbox", x = 10, y = 150, width = 21, height = 19}, mmpkg.confwin
  )
  mmpkg.config.smartboxlabel = 
  Geyser.Label:new(
    {
      name = "mmpkg.config.smartpromptlabel",
      x = 32,
      y = 152,
      fgColor = "black",
      color = "gray",
      width = 220,
      height = 20,
      message = [[Enable Smart Prompt? (shows invis,]],
      },
      mmpkg.confwin
    )
    mmpkg.config.smartboxlabel2 = 
    Geyser.Label:new(
      {
        name = "mmpkg.config.smartpromptlabel2",
        x = 10,
        y = 172,
        fgColor = "black",
        color = "gray",
        width = 250,
        height = 20,
      message = [[sanc,shops,pk,and more in the prompt)]],
    },
    mmpkg.confwin
  )
  mmpkg.config.smartpromptbox:setStyleSheet([[
  background-color: rgba(0,0,0,0%);
  ]])
  if mmpkg.conf.smartprompt == true then
    mmpkg.config.smartprompt = true
    mmpkg.config.smartpromptbox:setBackgroundImage(mmpkg.resources .. [[/checkbox_ticked.png]])
  else
    mmpkg.config.smartprompt = false
    mmpkg.config.smartpromptbox:setBackgroundImage(mmpkg.resources .. [[/checkbox_unticked.png]])
  end
  mmpkg.config.smartpromptbox:setClickCallback("mmpkg.config.smartpromptbox_click")

  mmpkg.config.buffwatcherbox = 
  Geyser.Label:new(
    {name = "mmpkg.config.buffwatcherbox", x = 10, y = 190, width = 21, height = 19}, mmpkg.confwin
  )
  mmpkg.config.buffwatcherlabel = 
  Geyser.Label:new(
    {
      name = "mmpkg.config.buffwatcherlabel",
      x = 32,
      y = 192,
      fgColor = "black",
      color = "gray",
      width = 220,
      height = 20,
      message = [[Enable Buffwatcher? (command: bw)]],
    },
    mmpkg.confwin
  )
  mmpkg.config.buffwatcherlabel2 = 
  Geyser.Label:new(
    {
      name = "mmpkg.config.buffwatcherlabel2",
      x = 10,
      y = 212,
      fgColor = "black",
      color = "gray",
      width = 250,
      height = 20,
      message = [[(requires enabling SmartPrompt above to work)]],
    },
    mmpkg.confwin
  )
  mmpkg.config.buffwatcherbox:setStyleSheet([[
  background-color: rgba(0,0,0,0%);
  ]])
  if mmpkg.conf.buffwatcher == true then
    mmpkg.config.buffwatcher = true
    mmpkg.config.buffwatcherbox:setBackgroundImage(mmpkg.resources .. [[/checkbox_ticked.png]])
  else
    mmpkg.config.buffwatcher = false
    mmpkg.config.buffwatcherbox:setBackgroundImage(mmpkg.resources .. [[/checkbox_unticked.png]])
  end
  mmpkg.config.buffwatcherbox:setClickCallback("mmpkg.config.buffwatcherbox_click")

  mmpkg.config.maintabs = 
  Geyser.Label:new(
    {
      name = "mmpkg.config.maintabs",
      x = 350,
      y = 21,
      width = 250,
      height = 20,
      fgColor = "black",
      color = "gray",
      message = [[Select which tabs to display in Captures]],
    },
    mmpkg.confwin
  )
  mmpkg.config.Alliancebox = 
  Geyser.Label:new(
    {name = "mmpkg.config.Alliancebox", x = 340, y = 50, width = 21, height = 19}, mmpkg.confwin
  )
  mmpkg.config.Alliancelabel = 
  Geyser.Label:new(
    {
      name = "mmpkg.config.Alliancelabel",
      x = 370,
      y = 52,
      fgColor = "black",
      color = "gray",
      width = 220,
      height = 20,
      message = [[Alliance]],
    },
    mmpkg.confwin
  )
  mmpkg.config.Alliancebox:setStyleSheet([[
  background-color: rgba(0,0,0,0%);
]])
  if table.contains(mmpkg.conf.tabs, "Alliance") then
    mmpkg.config.alliance = true
    mmpkg.config.Alliancebox:setBackgroundImage(mmpkg.resources .. [[/checkbox_ticked.png]])
  else
    mmpkg.config.alliance = false
    mmpkg.config.Alliancebox:setBackgroundImage(mmpkg.resources .. [[/checkbox_unticked.png]])
  end
  mmpkg.config.Alliancebox:setClickCallback("mmpkg.config.Alliancebox_click")
  mmpkg.config.Clanbox = 
  Geyser.Label:new(
    {name = "mmpkg.config.Clanbox", x = 340, y = 70, width = 21, height = 19}, mmpkg.confwin
  )
  mmpkg.config.Clanlabel = 
  Geyser.Label:new(
    {
      name = "mmpkg.config.Clanlabel",
      x = 370,
      y = 72,
      fgColor = "black",
      color = "gray",
      width = 220,
      height = 20,
      message = [[Clan]],
    },
    mmpkg.confwin
  )
  mmpkg.config.Clanbox:setStyleSheet([[
  background-color: rgba(0,0,0,0%);
]])
  if table.contains(mmpkg.conf.tabs, "Clan") then
    mmpkg.config.clan = true
    mmpkg.config.Clanbox:setBackgroundImage(mmpkg.resources .. [[/checkbox_ticked.png]])
  else
    mmpkg.config.clan = false
    mmpkg.config.Clanbox:setBackgroundImage(mmpkg.resources .. [[/checkbox_unticked.png]])
  end
  mmpkg.config.Clanbox:setClickCallback("mmpkg.config.Clanbox_click")
  mmpkg.config.Novicebox = 
  Geyser.Label:new(
    {name = "mmpkg.config.Novicebox", x = 340, y = 90, width = 21, height = 19}, mmpkg.confwin
  )
  mmpkg.config.Novicelabel = 
  Geyser.Label:new(
    {
      name = "mmpkg.config.Novicelabel",
      x = 370,
      y = 92,
      fgColor = "black",
      color = "gray",
      width = 220,
      height = 20,
      message = [[Novice]],
    },
    mmpkg.confwin
  )
  mmpkg.config.Novicebox:setStyleSheet([[
  background-color: rgba(0,0,0,0%);
]])
  if table.contains(mmpkg.conf.tabs, "Novice") then
    mmpkg.config.novice = true
    mmpkg.config.Novicebox:setBackgroundImage(mmpkg.resources .. [[/checkbox_ticked.png]])
  else
    mmpkg.config.novice = false
    mmpkg.config.Novicebox:setBackgroundImage(mmpkg.resources .. [[/checkbox_unticked.png]])
  end
  mmpkg.config.Novicebox:setClickCallback("mmpkg.config.Novicebox_click")

  mmpkg.config.Tellsbox = 
  Geyser.Label:new(
    {name = "mmpkg.config.Tellsbox", x = 340, y = 110, width = 21, height = 19}, mmpkg.confwin
  )
  mmpkg.config.Tellslabel = 
  Geyser.Label:new(
    {
      name = "mmpkg.config.TellsLabel",
      x = 370,
      y = 112,
      fgColor = "black",
      color = "gray",
      width = 220,
      height = 20,
      message = [[Tells]],
    },
    mmpkg.confwin
  )
  mmpkg.config.Tellsbox:setStyleSheet([[
  background-color: rgba(0,0,0,0%);
]])
  if table.contains(mmpkg.conf.tabs, "Tells") then
    mmpkg.config.tells = true
    mmpkg.config.Tellsbox:setBackgroundImage(mmpkg.resources .. [[/checkbox_ticked.png]])
  else
    mmpkg.config.tells = false
    mmpkg.config.Tellsbox:setBackgroundImage(mmpkg.resources .. [[/checkbox_unticked.png]])
  end
  mmpkg.config.Tellsbox:setClickCallback("mmpkg.config.Tellsbox_click")

  mmpkg.config.Formbox = 
  Geyser.Label:new(
    {name = "mmpkg.config.Formbox", x = 340, y = 130, width = 21, height = 19}, mmpkg.confwin
  )
  mmpkg.config.Formlabel = 
  Geyser.Label:new(
    {
      name = "mmpkg.config.Formlabel",
      x = 370,
      y = 132,
      fgColor = "black",
      color = "gray",
      width = 220,
      height = 20,
      message = [[Form]],
    },
    mmpkg.confwin
  )
  mmpkg.config.Formbox:setStyleSheet([[
  background-color: rgba(0,0,0,0%);
]])
  if table.contains(mmpkg.conf.tabs, "Form") then
    mmpkg.config.form = true
    mmpkg.config.Formbox:setBackgroundImage(mmpkg.resources .. [[/checkbox_ticked.png]])
  else
    mmpkg.config.form = false
    mmpkg.config.Formbox:setBackgroundImage(mmpkg.resources .. [[/checkbox_unticked.png]])
  end
  mmpkg.config.Formbox:setClickCallback("mmpkg.config.Formbox_click")

  mmpkg.config.Relaysbox = 
  Geyser.Label:new(
    {name = "mmpkg.config.Relaysbox", x = 340, y = 150, width = 21, height = 19}, mmpkg.confwin
  )
  mmpkg.config.Relayslabel = 
  Geyser.Label:new(
    {
      name = "mmpkg.config.Relayslabel",
      x = 370,
      y = 152,
      fgColor = "black",
      color = "gray",
      width = 220,
      height = 20,
      message = [[Relays]],
    },
    mmpkg.confwin
  )
  mmpkg.config.Relaysbox:setStyleSheet([[
  background-color: rgba(0,0,0,0%);
]])
  if table.contains(mmpkg.conf.tabs, "Relays") then
    mmpkg.config.relays = true
    mmpkg.config.Relaysbox:setBackgroundImage(mmpkg.resources .. [[/checkbox_ticked.png]])
  else
    mmpkg.config.relays = false
    mmpkg.config.Relaysbox:setBackgroundImage(mmpkg.resources .. [[/checkbox_unticked.png]])
  end
  mmpkg.config.Relaysbox:setClickCallback("mmpkg.config.Relaysbox_click")

  mmpkg.config.Talkbox = 
  Geyser.Label:new(
    {name = "mmpkg.config.Talkbox", x = 340, y = 170, width = 21, height = 19}, mmpkg.confwin
  )
  mmpkg.config.Talklabel = 
  Geyser.Label:new(
    {
      name = "mmpkg.config.Talklabel",
      x = 370,
      y = 172,
      fgColor = "black",
      color = "gray",
      width = 220,
      height = 20,
      message = [[Talk]],
    },
    mmpkg.confwin
  )
  mmpkg.config.Talkbox:setStyleSheet([[
  background-color: rgba(0,0,0,0%);
]])
  if table.contains(mmpkg.conf.tabs, "Talk") then
    mmpkg.config.talk = true
    mmpkg.config.Talkbox:setBackgroundImage(mmpkg.resources .. [[/checkbox_ticked.png]])
  else
    mmpkg.config.talk = false
    mmpkg.config.Talkbox:setBackgroundImage(mmpkg.resources .. [[/checkbox_unticked.png]])
  end
  mmpkg.config.Talkbox:setClickCallback("mmpkg.config.Talkbox_click")

  mmpkg.config.savebutton = 
  Geyser.Label:new(
    {
      name = "mmpkg.config.savebutton",
      x = 30,
      y = -50,
      width = 80,
      height = 40,
      fgColor = "black",
      color = "white",
      message = [[<center>Save&nbsp;</center>]],
    },
    mmpkg.confwin
  )
  mmpkg.config.savebutton:setStyleSheet(GUI.BoxCSS:getCSS())
  mmpkg.config.savebutton:setClickCallback("mmpkg.config.savebtn_click")
  mmpkg.config.cancelbutton = 
  Geyser.Label:new(
    {
      name = "mmpkg.config.cancelbutton",
      x = 90,
      y = -50,
      width = 80,
      height = 40,
      fgColor = "black",
      color = "red",
      message = [[<center>Cancel&nbsp;</center>]],
    },
    mmpkg.confwin
  )
  mmpkg.config.cancelbutton:setStyleSheet(GUI.BoxCSS:getCSS())
  mmpkg.config.cancelbutton:setClickCallback("mmpkg.config.cancelbtn_click")
end
