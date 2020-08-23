-- Initialize variables/tables
mmpkg = mmpkg or {}
mmpkg.previousRoom = mmpkg.previousRoom or {}
mmpkg.currentRoom = mmpkg.currentRoom or {}
mmpkg.previousRoom.ID = mmpkg.previousRoom.ID or {}
mmpkg.previousRoom.Area = mmpkg.previousRoom.Area or {}
mmpkg.previousRoom.exits = mmpkg.previousRoom.exits or {}
mmpkg.currentRoom.ID = mmpkg.currentRoom.ID or {}
mmpkg.currentRoom.Area = mmpkg.currentRoom.Area or {}
mmpkg.currentRoom.exits = mmpkg.currentRoom.exits or {}
mmpkg.mapimg = getMudletHomeDir() .. "/mmpkg/alyria.png"
mmpkg.ugimp = getMudletHomeDir() .. "/mmpkg/ug.png"
mmpkg.fpimg = getMudletHomeDir() .. "/mmpkg/fp.png"
mmpkg.sugimg = getMudletHomeDir() .. "/mmpkg/sug.png"
mmpkg.laslerimg = getMudletHomeDir() .. "/mmpkg/lasler.png"
mmpkg.verityimg = getMudletHomeDir() .. "/mmpkg/verity.png"
mmpkg.social = getMudletHomeDir() .. "/mmpkg/social.png"
mmpkg.arrowimg = getMudletHomeDir() .. "/mmpkg/arrow.png"
mmpkg.outsideZones = {"Alyria","Faerie Plane Wilderness","Lasler Valley","Great Alyrian Underground"}
mmpkg.roadSymbols = {"#","=",":"}
mmpkg.imapx = mmpkg.imapx or 1400
mmpkg.startx = mmpkg.startx or 0
mmpkg.imapy = mmpkg.impay or 1400
mmpkg.starty = mmpkg.starty or 0

-- Initialize Events system
mmpkg.events = mmpkg.events or {}
for _,handlerID in pairs(mmpkg.events) do
  killAnonymousEventHandler(handlerID)
end
mmpkg.events.newroom = registerAnonymousEventHandler("mmpkg.OnNewRoom", "mmpkg.onNewRoom")
mmpkg.events.newzone = registerAnonymousEventHandler("mmpkg.OnNewZone", "mmpkg.onNewZone")
mmpkg.events.qtimerevent = registerAnonymousEventHandler("mmpkg.OnQuestTimer", "mmpkg.onQuestTimer")
mmpkg.events.imdead = registerAnonymousEventHandler("mmpkg.OnDeath","mmpkg.onDeath")
mmpkg.events.imalive = registerAnonymousEventHandler("mmpkg.OnAlive","mmpkg.onAlive")

-- Present welcome message to users.

function mmpkgInstalled(_, name)
  if name ~= "mmpkg" then
    return
  end
  cecho(
    "<cyan>Please Open your preferences, and go to the 'mapper colors' tab. Then set your link color to black.\n"
  )
  cecho(
    "<cyan>Also set your mapper background color to cyan. These cannot be set via script, and this package expects.\n"
  )
  cecho("<cyan>the mapper to be those colors.\n\n")
  cecho("<green>Welcome to Xozes's script package for Materia Magica.\n\n")
  cecho("<yellow>It is still a work-in-progress, and many things are not yet implemented.\n\n")
  cecho(
    "<white>Useful aliases:\n<yellow>mapper goto <roomid><white>:<green>speedwalk to the specified room#.\n<yellow>mapper where <name of room><white>:<green>attempt to search for a room named <name of room> is a wildcard search.\n"
  )
  cecho(
    "<yellow>mapper help<white>:<green>Shows you the full help text of the mapper command.\n"
  )
  cecho(
    "<yellow>repos <direction><white>:<green>Where <dir> is the short version of any direction. Will reposition the room that exists just to the <dir> of the current room, just in case it gets placed in the wrong area.\n\n"
  )
  cecho(
    "<white> Thank you for trying out my package. If you have problems, look me up in-game, on discord as 'breakone9r#5150', or send me an email to break19@gmail.com."
  )
end

-- Begin setting up the GUI, beginning with default stylesheets
-- CSSMan by Vadi. Public domain.

CSSMan = {}
CSSMan.__index = CSSMan

function CSSMan.new(stylesheet)
  local obj  = { stylesheet = {} }
  setmetatable(obj,CSSMan)
  local trim = string.trim

  assert(type(stylesheet) == "string", "CSSMan.new: no stylesheet provided. A possible error is that you might have used CSSMan.new, not CSSMan:new")

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
  for k,v in pairs(self.stylesheet) do lines[#lines+1] = concat({k,": ", v, ";"}) end
  return concat(lines, "\n")
end

function CSSMan:gettable()
  return self.stylesheet
end

function CSSMan:settable(tbl)
  assert(type(tbl) == "table", "CSSMan:settable: table expected, got "..type(tbl))

  self.stylesheet = tbl
end

-- Now for the meat and potatoes of the GUI.
-- GUI Template by Akaya : https://forums.mudlet.org/viewtopic.php?f=6&t=4098
GUI = GUI or {}

local w,h = getMainWindowSize()
setBorderLeft(w/100)
setBorderTop(h/100)
setBorderBottom(h/10)
setBorderRight(w/100)
GUI.BackgroundCSS = CSSMan.new([[
  background-color: black;
]])

GUI.Right = Geyser.Label:new({
  name = "GUI.Right",
  x = "-40%", y = 0,
  width = "40%",
  height = "100%",
})
GUI.Right:setStyleSheet(GUI.BackgroundCSS:getCSS())

GUI.Bottom = Geyser.Label:new({
  name = "GUI.Bottom",
  x = "0%", y = "92%",
  width = "60%",
  height = "8%",
})
GUI.Bottom:setStyleSheet(GUI.BackgroundCSS:getCSS())

GUI.XPcontainer = Geyser.HBox:new({
  name = "GUI.XPcontainer",
  x = 0, y = "50%",
  width = "100%",
  height = "50%",
},GUI.Bottom)

GUI.Footer = Geyser.HBox:new({
  name = "GUI.Footer",
  x = 0, y = 0,
  width = "100%",
  height = "50%",
},GUI.Bottom)

GUI.LeftColumn = Geyser.VBox:new({
  name = "GUI.LeftColumn",
},GUI.Footer)

GUI.CenterColumn = Geyser.VBox:new({
  name = "GUI.CenterColumn",
},GUI.Footer)

GUI.RightColumn = Geyser.VBox:new({
  name = "GUI.RightColumn",
},GUI.Footer)

GUI.GaugeBackCSS = CSSMan.new([[
  background-color: rgba(0,0,0,0);
  border-style: solid;
  border-color: white;
  border-width: 1px;
  border-radius: 5px;
  margin: 5px;
]])

GUI.GaugeFrontCSS = CSSMan.new([[
  background-color: rgba(0,0,0,0);
  border-style: solid;
  border-color: white;
  border-width: 1px;
  border-radius: 5px;
  margin: 5px;
]])

GUI.Health = Geyser.Gauge:new({
  name = "GUI.Health",
},GUI.LeftColumn)
GUI.Health.back:setStyleSheet(GUI.GaugeBackCSS:getCSS())
GUI.GaugeFrontCSS:set("background-color","red")
GUI.Health.front:setStyleSheet(GUI.GaugeFrontCSS:getCSS())
GUI.Health:setValue(90,100)

GUI.Spellpower = Geyser.Gauge:new({
  name = "GUI.Spellpower",
},GUI.CenterColumn)
GUI.Spellpower.back:setStyleSheet(GUI.GaugeBackCSS:getCSS())
GUI.GaugeFrontCSS:set("background-color","blue")
GUI.Spellpower.front:setStyleSheet(GUI.GaugeFrontCSS:getCSS())
GUI.Spellpower:setValue(90,100)

GUI.Stamina = Geyser.Gauge:new({
  name = "GUI.Stamina",
},GUI.RightColumn)
GUI.Stamina.back:setStyleSheet(GUI.GaugeBackCSS:getCSS())
GUI.GaugeFrontCSS:set("background-color","yellow")
GUI.Stamina.front:setStyleSheet(GUI.GaugeFrontCSS:getCSS())
GUI.Stamina:setValue(90,100)

GUI.XPgauge = Geyser.Gauge:new({
  name = "GUI.XPgauge",
},GUI.XPcontainer)
GUI.XPgauge.back:setStyleSheet(GUI.GaugeBackCSS:getCSS())
GUI.GaugeFrontCSS:set("background-color","purple")
GUI.XPgauge.front:setStyleSheet(GUI.GaugeFrontCSS:getCSS())
GUI.XPgauge:setValue(0,100)

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
  x = 0, y = 0,
  width = "100%",
  height = "50%",
},GUI.Right)
GUI.Box1:setStyleSheet(GUI.BoxCSS:getCSS())

GUI.vmap_container = Geyser.Container:new({
name = "GUI.vmap_container",
x = 0, y =0,
width = "100%",
height = "100%",
},GUI.Box1)

GUI.vmapper = Geyser.Label:new({
  name = "GUI.vmapper",
  x = 20, y = 20,
  width = -20,
  height = -20,
  },GUI.vmap_container)
GUI.vmapper:setStyleSheet([[border-image: url(]]..mmpkg.mapimg..[[);]])

GUI.Map_Container = Geyser.Container:new({
  name = "GUI.Map_Container",
  x = 0, y = 0,
  width = "100%",
  height = "100%",
},GUI.Box1)

GUI.Mapper = Geyser.Mapper:new({
  name = "GUI.Mapper",
  x = 20, y = 55,
  width = -20,
  height = -20,
},GUI.Map_Container)

GUI.MapInfo = Geyser.Label:new({
  name = "GUI.MapInfo",
  x = 20, y = 20,
  width = -20,
  height = "35",
  fgColor = "black",
},GUI.Map_Container)

GUI.MapInfo:setStyleSheet([[
  background-color: rgba(66,198,198,100%);
]])

--the map's default background color is black, so lets blend it in...
GUI.Box1CSS = CSSMan.new(GUI.BoxCSS:getCSS())
GUI.Box1CSS:set("background-color", "black")
GUI.Box1:setStyleSheet(GUI.Box1CSS:getCSS())


GUI.Box2 = Geyser.Label:new({
  name = "GUI.Box2",
  x = 0, y = "50%",
  width = "100%",
  height = "50%",
},GUI.Right)
GUI.Box2:setStyleSheet(GUI.BoxCSS:getCSS())

mmpkg.Captures = Geyser.MiniConsole:new({
  name = "mmpkg.Captures",
  x = 20, y = 20,
  width = -20,
  height = -20,
  color = "black",
  fontSize = 10,
  autoWrap = true
}, GUI.Box2 )

GUI.myarrow =
    Geyser.Label:new(
      {
        name = "GUI.myarrow",
        x = ((mmpkg.imapx * 1) + mmpkg.startx),
        y = ((mmpkg.imapy * 1) + mmpkg.starty),
        width = 15,
        height = 15,
      },
      GUI.vmapper
    )
  GUI.myarrow:setBackgroundImage(mmpkg.arrowimg)
  GUI.myarrow:setStyleSheet([[
  background-color: rgba(0,0,0,0%);
]])

function doSpeedWalk()
  mmpkg.doHighLightPath()
  mmpkg.isWalking = true
  send(speedWalkDir[1])
  if mmpkg.speedstep then
    killTimer(mmpkg.speedstep)
  end
  mmpkg.speedstep = tempTimer(1,function () mmpkg.isWalking = false
      cecho(
        "<red>ERROR! Expected room #:<white> " ..
        speedWalkPath[1] ..
        "<red> But we're stuck in room #:<white> " ..
        mmpkg.currentRoom.ID
      ) end)
end
