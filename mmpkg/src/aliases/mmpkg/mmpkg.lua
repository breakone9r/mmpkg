if (matches[2] == "config") then
  mmpkg.config = mmpkg.config or {}
  mmpkg.confwin = 
  Geyser.UserWindow:new(
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
    mmpkg.config.timestampbox:setBackgroundImage(mmpkg.resources .. [[/checkbox_ticked.png]])
  else
    mmpkg.config.timestampbox:setBackgroundImage(mmpkg.resources .. [[/checkbox_unticked.png]])
  end
  mmpkg.config.timestampbox:setClickCallback("mmpkg.config.timestampbox_click")
  mmpkg.config.areaonlybox = 
  Geyser.Label:new(
    {name = "mmpkg.config.areaonlybox", x = 10, y = 70, width = 21, height = 19}, mmpkg.confwin
  )
  mmpkg.config.areaonlylabel = 
  Geyser.Label:new(
    {
      name = "mmpkg.config.areaonlylabel",
      x = 32,
      y = 72,
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
    mmpkg.config.areaonlybox:setBackgroundImage(mmpkg.resources .. [[/checkbox_ticked.png]])
  else
    mmpkg.config.areaonlybox:setBackgroundImage(mmpkg.resources .. [[/checkbox_unticked.png]])
  end
  mmpkg.config.areaonlybox:setClickCallback("mmpkg.config.areaonlybox_click")

  mmpkg.config.scanhelperbox = 
  Geyser.Label:new(
    {name = "mmpkg.config.scanhelperbox", x = 10, y = 90, width = 21, height = 19}, mmpkg.confwin
  )
  mmpkg.config.scanhelperlabel = 
  Geyser.Label:new(
    {
      name = "mmpkg.config.scanhelperlabel",
      x = 32,
      y = 92,
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
  if isActive("Scan Helper", "trigger") then
    mmpkg.config.scanhelperbox:setBackgroundImage(mmpkg.resources .. [[/checkbox_ticked.png]])
  else
    mmpkg.config.scanhelperbox:setBackgroundImage(mmpkg.resources .. [[/checkbox_unticked.png]])
  end
  mmpkg.config.scanhelperbox:setClickCallback("mmpkg.config.scanhelperbox_click")

  mmpkg.config.linkifybox = 
  Geyser.Label:new(
    {name = "mmpkg.config.linkifybox", x = 10, y = 110, width = 21, height = 19}, mmpkg.confwin
  )
  mmpkg.config.linkifylabel = 
  Geyser.Label:new(
    {
      name = "mmpkg.config.linkifylabel",
      x = 32,
      y = 112,
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
  if isActive("Linkify") then
    mmpkg.config.linkifybox:setBackgroundImage(mmpkg.resources .. [[/checkbox_ticked.png]])
  else
    mmpkg.config.linkifybox:setBackgroundImage(mmpkg.resources .. [[/checkbox_unticked.png]])
  end
  mmpkg.config.linkifybox:setClickCallback("mmpkg.config.linkifybox_click")

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
elseif (matches[2] == "pages") then
  if not mmpkg.PagesCon then
    mmpkg.PagesCon = 
    Geyser.UserWindow:new(
      {
        name = "mmpkg.PagesCon",
        titleText = "Pages",
        x = "20%",
        y = "20%",
        width = "50%",
        height = "40%"
      }
    )

    mmpkg.Pages = 
    Geyser.MiniConsole:new(
      {
        name = "mmpkg.Pages",
        x = 0,
        y = 0,
        autoWrap = true,
        color = "gray",
        scrollBar = false,
        fontSize = 10,
        width = -5,
        height = -5
      },
      mmpkg.PagesCon
    )
  else
    mmpkg.PagesCon:show()
  end
elseif (matches[2] == "update") then
  mmpkg.checkupdate()
else
  local cmd = matches[2] or ""
  cecho("<red:white>ERROR:<white:black> Unknown command '"..cmd.."'!\n")
  cecho("<yellow>mmpkg pages  :<white>Shows the Pages window.\n")
  cecho("<yellow>mmpkg config :<white>Shows/Sets Various configuration options.\n")
  cecho("<yellow>mmpkg update :<white>Check for, download and install updated mmpkg.\n")
end
