-- Initialize variables/tables
mmpkg = mmpkg or {}
mmpkg.packagename = "@PKGNAME@"
mmpkg.resources = getMudletHomeDir() .. "/@PKGNAME@"
CSSMan = {}
CSSMan.__index = CSSMan
demonnic = demonnic or {}
demonnic.iGauge = demonnic.iGauge or Geyser.Container:new(
  {
    name = "demonnic.iGaugeClass",
    value = 100,
    fillcolor = "firebrick",
    emptycolor = "black",
    bartype = "bar",
    orientation = "horizontal"
})
demonnic.iGauge.parent = Geyser.Container
mmpkg.previousRoom = mmpkg.previousRoom or {}
mmpkg.currentRoom = mmpkg.currentRoom or {}
mmpkg.previousRoom.ID = mmpkg.previousRoom.ID or "1"
mmpkg.previousRoom.Area = mmpkg.previousRoom.Area or {}
mmpkg.previousRoom.exits = mmpkg.previousRoom.exits or {}
mmpkg.currentRoom.ID = mmpkg.currentRoom.ID or "1"
mmpkg.currentRoom.Area = mmpkg.currentRoom.Area or {}
mmpkg.currentRoom.exits = mmpkg.currentRoom.exits or {}
mmpkg.mapimg = mmpkg.resources .. "/alyria.png"
mmpkg.ugimp = mmpkg.resources .. "/ug.png"
mmpkg.fpimg = mmpkg.resources .. "/fp.png"
mmpkg.sugimg = mmpkg.resources .. "/sugx.png"
mmpkg.laslerimg = mmpkg.resources .. "/lasler.png"
mmpkg.verityimg = mmpkg.resources .. "/verity.png"
mmpkg.socialimg = mmpkg.resources .. "/social.png"
mmpkg.arrowimg = mmpkg.resources .. "/arrow.png"
mmpkg.outsideZones = {
  "Alyria", "Faerie Plane Wilderness", "Lasler Valley",
  "Great Alyrian Underground", "Chat Rooms Wilderness", "Sigil Underground"
}
mmpkg.roadSymbols = {"#", "=", ":"}
mmpkg.imapx = mmpkg.imapx or 1400
mmpkg.startx = mmpkg.startx or 0
mmpkg.imapy = mmpkg.impay or 1400
mmpkg.starty = mmpkg.starty or 0
local stylesheet = 
[[background-color: rgb(0,0,0,0); border-width: 1px; border-style: solid; border-color: gold; border-radius: 1px;]]
local istylesheet = 
[[background-color: rgb(0,0,0,0); border-width: 1px; border-style: solid; border-color: silver; border-radius: 1px;]]

function mmpkg.setup()
  -- Initialize Events system
  mmpkg.events = mmpkg.events or {}
  for _, handlerID in pairs(mmpkg.events) do
    killAnonymousEventHandler(handlerID)
  end
  mmpkg.events.onlogin = registerAnonymousEventHandler("mmpkg.OnLogin", "mmpkg.onLogin")
  mmpkg.events.newroom = registerAnonymousEventHandler("mmpkg.onNewRoom", "mmpkg.isNewRoom")
  mmpkg.events.newzone = registerAnonymousEventHandler("mmpkg.onNewZone", "mmpkg.isNewZone")
  mmpkg.events.qtimerevent = registerAnonymousEventHandler("mmpkg.OnQuestTimer", "mmpkg.isQuestTimer")
  mmpkg.events.imdead = registerAnonymousEventHandler("mmpkg.OnDeath", "mmpkg.isDead")
  mmpkg.events.imalive = registerAnonymousEventHandler("mmpkg.OnAlive", "mmpkg.isAlive")
  mmpkg.events.onclose = registerAnonymousEventHandler("sysExitEvent", "mmpkg.onClose")
  mmpkg.events.ondisc = registerAnonymousEventHandler("sysDisconnectionEvent", "mmpkg.onClose")
  mmpkg.events.onresize = registerAnonymousEventHandler("sysWindowResizeEvent", "mmpkg.onResize")
  mmpkg.events.mapping = registerAnonymousEventHandler("gmcp.room.info", "mapping")
  mmpkg.events.updvitals = registerAnonymousEventHandler("gmcp.char.vitals", "mmpkg.updateVitals")
  mmpkg.events.updmax = registerAnonymousEventHandler("gmcp.char.maxstats", "mmpkg.updateMaxStats")
  mmpkg.events.updxp = registerAnonymousEventHandler("gmcp.char.status", "mmpkg.updateXP")
  mmpkg.events.charname = registerAnonymousEventHandler("gmcp.char.base.name", "mmpkg.updateCharName")
  mmpkg.events.uninstall = registerAnonymousEventHandler("sysUninstallPackage", "mmpkg_Uninstalled")
  mmpkg.events.affects = registerAnonymousEventHandler("gmcp.char.affect_application_msg", "mmpkg.getAffect")
  mmpkg.events.affectsoff = registerAnonymousEventHandler("gmcp.char.affect_removal_msg", "mmpkg.getAffectOff")
  -- Begin setting up the GUI, beginning with default stylesheets
  -- CSSMan by Vadi. Public domain.
  -- Add in EMCO.lua from demonnic - https://github.com/demonnic
  if not EMCO then
    -- path kludge to bypass slight lua/mudlet bug
    local path = package.path
    local home_dir = mmpkg.resources
    local lua_dir = string.format("%s/%s", home_dir, [[?.lua]])
    local init_dir = string.format("%s/%s", home_dir, [[?/init.lua]])
    package.path = string.format("%s;%s;%s", path, lua_dir, init_dir)
    local okay, content = pcall(require, "EMCO")
    package.path = path
    if okay then
      EMCO = content
    else
      error(string.format("EMCO: Error loading module: %s\n", content))
    end
  end
  -- Load settings if they exist.
  mmpkg.conf = mmpkg.conf or {}
  if io.exists(getMudletHomeDir() .. "/mmpkg.conf") then
    table.load(getMudletHomeDir() .. "/mmpkg.conf", mmpkg.conf)
  end
  -- Apply defaults if no settings
  mmpkg.conf.fontsize = getFontSize()
  mmpkg.conf.font = getFont()
  if not mmpkg.conf.areaonly then mmpkg.conf.areaonly = false end
  if not mmpkg.conf.logging then mmpkg.conf.logging = false end
  if not mmpkg.conf.timestamps then mmpkg.conf.timestamps = false end
  if not mmpkg.conf.tabs then
    mmpkg.conf.tabs = {
      "All", "Alliance", "Clan", "Novice", "Tells", "Form", "Relays",
      "Talk"
    }
  end

  -- Now for the meat and potatoes of the GUI.
  -- iGauges by demonnic : https://forums.mudlet.org/viewtopic.php?f=6&t=22779
  -- GUI Template by Akaya : https://forums.mudlet.org/viewtopic.php?f=6&t=4098

  GUI = GUI or {}
  local w, h = getMainWindowSize()
  setBorderLeft("10")
  setBorderTop("10")
  setBorderBottom("60")
  setBorderRight(w * .405)
  GUI.BackgroundCSS = CSSMan.new([[
                                     background-color: black;
                                    ]])
  GUI.Right = Geyser.Label:new({
    name = "GUI.Right",
    x = "-40%",
    y = 0,
    width = "40%",
    height = "100%"
  })
  GUI.Right:setStyleSheet(GUI.BackgroundCSS:getCSS())
  GUI.XPbar = Geyser.Container:new({
    name = "GUI.XPbar",
    x = 0,
    y = -25,
    width = "60%",
    height = 20,
    color = "white"
  })
  GUI.XPgauge = demonnic.iGauge:new({
    name = "GUI.XPgauge",
    x = 80,
    y = 0,
    width = -80,
    height = "100%",
    fillcolor = "<190,90,190>",
    backcolor = "<30,30,30>"
  }, GUI.XPbar)
  GUI.XPLabel = Geyser.Label:new({
    name = "GUI.XPLabel",
    x = 0,
    y = 1,
    width = 76,
    height = 17,
    color = "black",
    fgcolor = "white"
  }, GUI.XPbar)
  GUI.XPLabel:echo("<center>XPBAR</center>")
  -- Create Main HP/SP/ST Container
  GUI.VitalBars = Geyser.Container:new(
    {
      name = "GUI.VitalBars",
      x = 0,
      y = -50,
      width = "60%",
      height = 20
  })
  GUI.HPmain = Geyser.Container:new({
    name = "GUI.HPMain",
    x = 0,
    y = 0,
    width = "33%",
    height = "100%"
  }, GUI.VitalBars)
  GUI.SPmain = Geyser.Container:new({
    name = "GUI.SPMain",
    x = "33%",
    y = 0,
    width = "33%",
    height = "100%"
  }, GUI.VitalBars)
  GUI.STmain = Geyser.Container:new({
    name = "GUI.STMain",
    x = "66%",
    y = 0,
    width = "33%",
    height = "100%"
  }, GUI.VitalBars)
  GUI.Health = demonnic.iGauge:new({
    name = "GUI.Health",
    x = 80,
    y = 0,
    width = -20,
    height = "100%",
    fillcolor = "<190,20,20>",
    backcolor = "<30,30,30>",
    bartype = "bar"
  }, GUI.HPmain)
  GUI.HPLabel = Geyser.Label:new({
    name = "GUI.HPLabel",
    x = 3,
    y = 1,
    width = 76,
    height = 17,
    color = "black",
    fgcolor = "white"
  }, GUI.HPmain)
  GUI.HPLabel:echo("<center>2000/2000hp</center>")
  GUI.Spellpower = demonnic.iGauge:new(
    {
      name = "GUI.Spellpower",
      x = 80,
      y = 0,
      width = -20,
      height = "100%",
      fillcolor = "<70,70,150>",
      backcolor = "<30,30,30>",
      bartype = "slant"
  }, GUI.SPmain)
  GUI.SPLabel = Geyser.Label:new({
    name = "GUI.SPLabel",
    x = 0,
    y = 1,
    width = 76,
    height = 17,
    color = "black",
    fgcolor = "white"
  }, GUI.SPmain)
  GUI.SPLabel:echo("<center>2350/2350sp</center>")
  GUI.Stamina = demonnic.iGauge:new({
    name = "GUI.Stamina",
    x = 80,
    y = 0,
    width = -20,
    height = "100%",
    fillcolor = "<215,245,145>",
    backcolor = "<30,30,30>",
    bartype = "chevron"
  }, GUI.STmain)
  GUI.STLabel = Geyser.Label:new({
    name = "GUI.STLabel",
    x = 0,
    y = 1,
    width = 76,
    height = 17,
    color = "black",
    fgcolor = "white"
  }, GUI.STmain)
  GUI.STLabel:echo("<center>2350/2350st</center>")
  GUI.BoxCSS = CSSMan.new([[
                              background-color: rgba(0,0,0,100);
                             border-style: solid;
                             border-width: 1px;
                             border-radius: 10px;
                             border-color: white;
                             margin: 10px;
                             ]])
  GUI.Box1 = Geyser.Label:new({
    name = "GUI.Box1",
    x = 0,
    y = 0,
    width = "100%",
    height = "50%"
  }, GUI.Right)
  GUI.Box1:setStyleSheet(GUI.BoxCSS:getCSS())
  GUI.vmap_container = Geyser.Container:new(
    {
      name = "GUI.vmap_container",
      x = 0,
      y = 0,
      width = "100%",
      height = "100%"
  }, GUI.Box1)
  GUI.vmapper = Geyser.Label:new({
    name = "GUI.vmapper",
    x = 20,
    y = 20,
    width = -20,
    height = -20
  }, GUI.vmap_container)
  GUI.vmapper:setStyleSheet([[border-image: url(]] .. mmpkg.mapimg .. [[);]])
  GUI.Map_Container = Geyser.Container:new(
    {
      name = "GUI.Map_Container",
      x = 0,
      y = 0,
      width = "100%",
      height = "100%"
  }, GUI.Box1)
  GUI.Mapper = Geyser.Mapper:new({
    name = "GUI.Mapper",
    x = 20,
    y = 55,
    width = -20,
    height = -20
  }, GUI.Map_Container)
  GUI.MapInfo = Geyser.Label:new({
    name = "GUI.MapInfo",
    x = 20,
    y = 20,
    width = -20,
    height = "35",
    fgColor = "black"
  }, GUI.Map_Container)
  GUI.MapInfo:setStyleSheet([[
                                background-color: rgba(66,198,198,100%);
                               ]])
  -- the map's default background color is black, so lets blend it in...
  GUI.Box1CSS = CSSMan.new(GUI.BoxCSS:getCSS())
  GUI.Box1CSS:set("background-color", "black")
  GUI.Box1:setStyleSheet(GUI.Box1CSS:getCSS())
  GUI.Box2 = Geyser.Label:new({
    name = "GUI.Box2",
    x = 0,
    y = "50%",
    width = "100%",
    height = "50%"
  }, GUI.Right)
  GUI.Box2:setStyleSheet(GUI.BoxCSS:getCSS())
  GUI.myarrow = Geyser.Label:new({
    name = "GUI.myarrow",
    x = ((mmpkg.imapx * 1) + mmpkg.startx),
    y = ((mmpkg.imapy * 1) + mmpkg.starty),
    width = 15,
    height = 15
  }, GUI.vmapper)
  GUI.myarrow:setBackgroundImage(mmpkg.arrowimg)
  GUI.myarrow:setStyleSheet([[
                                background-color: rgba(0,0,0,0%);
                               ]])
  mmpkg.Captures = EMCO:new({
    name = "mmpkg.Captures",
    x = "20",
    y = "20",
    width = "-20",
    height = "-20",
    allTab = true,
    allTabName = "All",
    gap = 2,
    timestamp = mmpkg.conf.timestamps,
    blink = true,
    consoleColor = "black",
    fontSize = mmpkg.conf.fontsize,
    font = mmpkg.conf.font,
    consoles = mmpkg.conf.tabs,
    customTimestampColor = true,
    timestampBGColor = "black",
    timestampFGColor = "cyan",
    mapTab = false,
    activeTabCSS = stylesheet,
    inactiveTabCSS = istylesheet
  }, GUI.Box2)
  if mmpkg.updates then
    cecho("\n\n<red:white>Updater package is no longer needed! Please remove it now, as it can interfere.")
  end
  for _, tab in spairs(mmpkg.Captures.consoles) do
    mmpkg.playlog(tab)
  end
end

function demonnic.iGauge:setType(bartype)
  self.bartype = bartype
  self.front:setStyleSheet([[
                               border-image: url(]] .. mmpkg.resources .. "/" .. self.bartype .. [[.png);
  ]])
end

function demonnic.iGauge:update(value, foreGround, backGround)
  value = (value < 2 and value) or value / 100
  if foreGround then self.fillcolor = foreGround end
  if backGround then self.emptycolor = backGround end
  local fgr, fgg, fgb = Geyser.Color.parse(self.fillcolor)
  local bgr, bgg, bgb = Geyser.Color.parse(self.emptycolor)
  local fgc = table.concat({fgr, fgg, fgb}, ", ")
  local bgc = table.concat({bgr, bgg, bgb}, ", ")
  value = tonumber(value)
  local valm = value - 0.02
  local valp = value + 0.02
  self.back:setStyleSheet(string.format(
    "background-color: qlineargradient(spread:pad, x1:0, y1:0, x2:1, y2:0, stop:0 rgba(%s,255), stop:%.2f rgba(%s, 255), stop:%.2f rgba(%s,255), stop:1 rgba(%s,255))",
  fgc, valm, fgc, valp, bgc, bgc))
end

function demonnic.iGauge:new(cons, container)
  cons = cons or {}
  cons.type = cons.type or "iGauge"
  local me = self.parent:new(cons, container)
  setmetatable(me, self)
  self.__index = self
  me.back = Geyser.Label:new({
    name = me.name .. "_back",
    x = 0,
    y = 0,
    width = "100%",
    height = "100%"
  }, me)
  me.front = Geyser.Label:new({
    name = me.name .. "_front",
    x = 0,
    y = 0,
    width = "100%",
    height = "100%"
  }, me.back)
  me:setType(me.bartype)
  me:update(me.value, me.fillcolor, me.emptycolor)
  return me
end

-- Function to save mmpkg settings

function mmpkg.onClose() table.save(getMudletHomeDir() .. "/mmpkg.conf", mmpkg.conf) end

function doSpeedWalk()
  mmpkg.doHighLightPath()
  mmpkg.isWalking = true
  send(speedWalkDir[1])
  if mmpkg.speedstep then killTimer(mmpkg.speedstep) end
  mmpkg.speedstep = tempTimer(1.7, function()
    mmpkg.isWalking = false
    cecho("<red>ERROR! Expected room #:<white> " .. speedWalkPath[1] ..
      "<red> But we're stuck in room #:<white> " ..
    mmpkg.currentRoom.ID)
  end)
end

function CSSMan.new(stylesheet)
  local obj = {stylesheet = {}}
  setmetatable(obj, CSSMan)
  local trim = string.trim
  assert(type(stylesheet) == "string",
  "CSSMan.new: no stylesheet provided. A possible error is that you might have used CSSMan.new, not CSSMan:new")
  for line in stylesheet:gmatch("[^\r\n]+") do
    local attribute, value = line:match("^(.-):(.-);$")
    if attribute and value then
      attribute, value = trim(attribute), trim(value)
      obj.stylesheet[attribute] = value
    end
  end
  return obj
end

function CSSMan:set(key, value)
  self.stylesheet[key] = value
end

function CSSMan:get(key)
  return self.stylesheet[key]
end

function CSSMan:getCSS(key)
  local lines, concat = {}, table.concat
  for k, v in pairs(self.stylesheet) do
    lines[#lines + 1] = concat({k, ": ", v, ";"})
  end
  return concat(lines, "\n")
end

function CSSMan:gettable()
  return self.stylesheet
end

function CSSMan:settable(tbl)
  assert(type(tbl) == "table",
  "CSSMan:settable: table expected, got " .. type(tbl))
  self.stylesheet = tbl
end
