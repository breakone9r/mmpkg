function mmpkg.doHighLightPath()
  for i, v in pairs(speedWalkPath) do
    local r, g, b = unpack(color_table.red)
    local br, bg, bb = unpack(color_table.blue)
    highlightRoom(v, r, g, b, br, bg, bb, 1, 125, 125)
  end
end

function mmpkg.tchelper(first,rest)
  return first:upper()..rest:lower()
end

function mmpkg.doTitle(strng)
  return strng:gsub("(%a)([%w_']*)", mmpkg.tchelper)
end

function mmpkg.doAffect(aff, ison,quiet)
  if not mmpkg.myAffects then
    mmpkg.myAffects = {}
    mmpkg.myAffects.affects = {}
  end
  if (ison == "on") then
    table.insert(mmpkg.myAffects.affects, aff)
    color = "\n<blue:green>"
  else
    table.remove(mmpkg.myAffects.affects, table.index_of(mmpkg.myAffects.affects, aff))
    color = "\n<white:red>"
  end
  if not quiet then
    cecho(color..mmpkg.doTitle(aff)..": "..string.upper(ison))
  end
end

function mmpkg.mapSwap()
  if mmpkg.isOutside(gmcp.room.info.zone) then
    GUI.vmapper:show()
    GUI.Mapper:hide()
    GUI.MapInfo:hide()
    GUI.myarrow:show()
    GUI.myarrow:move(
      ((mmpkg.imapx * gmcp.room.info.coord.x) + mmpkg.startx),
      ((mmpkg.imapy * gmcp.room.info.coord.y) + mmpkg.starty)
    )
  else
    GUI.vmapper:hide()
    GUI.Mapper:show()
    GUI.MapInfo:show()
  end
end

function mmpkg.isOutside(zone)
  if table.contains(mmpkg.outsideZones, zone) then
    return true
  else
    return false
  end
end

function mmpkg.setFlags()
  local s = gmcp.room.info.flags
  local flags = string.split(s, ", ")
  for i, v in pairs(flags) do
    setRoomUserData(gmcp.room.info.num, v, "true")
  end
  if table.contains(flags, "safe") then
    setRoomEnv(gmcp.room.info.num, 271)
  end
  if table.contains(flags, "player-kill-lawful") then
    setRoomEnv(gmcp.room.info.num, 265)
  end
  if table.contains(flags, "player-kill-neutral") then
    setRoomEnv(gmcp.room.info.num, 257)
  end
  if table.contains(flags, "player-kill-chaotic") then
    setRoomEnv(gmcp.room.info.num, 264)
  end
end

function mmpkg.doExits(zone, curroom, exits, sym, terrain)
  if mmpkg.isMaze(curroom) then
    do
      return
    end
  elseif mmpkg.isOutside(zone) then
    if mmpkg.isRoad(sym, terrain) then
      for dir, room in pairs(exits) do
        setExitStub(curroom, dir, true)
        if roomExists(room) then
          setExit(curroom, room, dir)
        end
      end
      if table.matches(mmpkg.previousRoom.exits, curroom) then
        local keys = table.keys(table.matches(mmpkg.previousRoom.exits, mmpkg.currentRoom.ID))
        if roomExists(mmpkg.previousRoom.ID) and roomExists(mmpkg.currentRoom.ID) and keys[1] then
          setExit(mmpkg.previousRoom.ID, mmpkg.currentRoom.ID, keys[1])
        end
      end
    else
      do
        return
      end
      -- Outside, not on a road. do nothing!
    end
  else
    -- Not outside. Link all known exits, and create stub rooms.
    for dir, room in pairs(exits) do
      if roomExists(room) then
        setExit(curroom, room, dir)
      else
        setExitStub(curroom, dir, true)
      end
    end
    if table.matches(mmpkg.previousRoom.exits, curroom) then
      local keys = table.keys(table.matches(mmpkg.previousRoom.exits, mmpkg.currentRoom.ID))
      if roomExists(mmpkg.previousRoom.ID) and roomExists(mmpkg.currentRoom.ID) and keys[1] then
        setExit(mmpkg.previousRoom.ID, mmpkg.currentRoom.ID, keys[1])
      end
    end
  end
end

function mmpkg.isRoad(symbol, terrain)
  if (symbol == "=") then
    if string.find(terrain, "bridge") or string.find(terrain, "road") then
      return true
    else
      return false
    end
  elseif table.contains(mmpkg.roadSymbols, symbol) then
    return true
  else
    return false
  end
end

function mmpkg.doImap()
  if (gmcp.room.info.zone == "Alyria") then
    mmpkg.vmapimg, mmpkg.imapx, mmpkg.imapy, mmpkg.startx, mmpkg.starty =
      mmpkg.mapimg, (GUI.vmapper:get_width() / 2300), (GUI.vmapper:get_height() / 1500), 0, 0
  elseif (gmcp.room.info.zone == "Alyrian Underworld") then
    mmpkg.vmapimg, mmpkg.imapx, mmpkg.imapy, mmpkg.startx, mmpkg.starty =
      mmpkg.ugimg, (GUI.vmapper:get_width() / 2300), (GUI.vmapper:get_height() / 1500), 0, 0
  elseif (gmcp.room.info.zone == "Faerie Plane Wilderness") then
    mmpkg.vmapimg, mmpkg.imapx, mmpkg.imapy, mmpkg.startx, mmpkg.starty =
      mmpkg.fpimg, (GUI.vmapper:get_width() / (610)), (GUI.vmapper:get_height() / 400), 57 + 18, 0
  elseif (gmcp.room.info.zone == "Sigil Underground") then
    mmpkg.vmapimg, mmpkg.imapx, mmpkg.imapy, mmpkg.startx, mmpkg.starty =
      mmpkg.sugimg,
      (GUI.vmapper:get_width() / 889),
      (GUI.vmapper:get_height() / 580),
      -183,
      (922 + (34 / 2))
  elseif (gmcp.room.info.zone == "Lasler Valley") then
    mmpkg.vmapimg, mmpkg.imapx, mmpkg.imapy, mmpkg.startx, mmpkg.starty =
      mmpkg.laslerimg,
      (GUI.vmapper:get_width() / 155),
      (GUI.vmapper:get_height() / 101),
      (GUI.vmapper:get_width() / 7),
      0
  else
    mmpkg.vmapimg, mmpkg.imapx, mmpkg.imapy, mmpkg.startx, mmpkg.starty =
      mmpkg.mapimg, 100, 100, 0, 0
  end
  GUI.vmapper:setStyleSheet([[border-image: url(]] .. mmpkg.vmapimg .. [[);]])
  GUI.myarrow:move(((mmpkg.imapx * gmcp.room.info.coord.x)+mmpkg.startx), ((mmpkg.imapy  * gmcp.room.info.coord.y)+mmpkg.starty))
end

function mmpkg.doCoords()
  -- If outside, use game coords, on a flat plane (with y reversed, as our 0,0 is NW corner)
  if mmpkg.isOutside(gmcp.room.info.zone) then
    local x = gmcp.room.info.coord.x
    local y = (0 - gmcp.room.info.coord.y)
    if roomExists(gmcp.room.info.num) then
      setRoomCoordinates(gmcp.room.info.num, x, y, 0)
      setRoomChar(gmcp.room.info.num, gmcp.room.info.coord.sym)
    end
  else
    local x, y, z = getRoomCoordinates(mmpkg.previousRoom.ID)
    local dirToCoords =
      {
        u = {x, y, z - 1},
        d = {x, y, z + 1},
        n = {x, y - 1, z},
        s = {x, y + 1, z},
        e = {x - 1, y, z},
        w = {x + 1, y, z},
        ne = {x - 1, y - 1, z},
        se = {x - 1, y + 1, z},
        nw = {x + 1, y - 1, z},
        sw = {x + 1, y + 1, z},
      }
    if table.matches(mmpkg.currentRoom.exits, mmpkg.previousRoom.ID) then
      local keys = table.keys(table.matches(mmpkg.currentRoom.exits, mmpkg.previousRoom.ID))
      local coords = dirToCoords[keys[1]]
      if coords then
        setRoomCoordinates(mmpkg.currentRoom.ID, unpack(coords))
      end
    end
  end
end

function mmpkg.nextSpeedStep()
  if mmpkg.isWalking then
    if mmpkg.speedstep then
      killTimer(mmpkg.speedstep)
    end
    if (mmpkg.currentRoom.ID == speedWalkPath[1]) then
      table.remove(speedWalkDir, 1)
      table.remove(speedWalkPath, 1)
      if speedWalkDir[1] then
        mmpkg.speedstep =
        tempTimer(
          1,
          function()
            mmpkg.isWalking = false
            cecho(
              "<red>ERROR! Expected room #:<white> " ..
              speedWalkPath[1] ..
              "<red> But we've stopped in room #:<white> " ..
              mmpkg.currentRoom.ID
            )
          end
        )
        send(speedWalkDir[1])
      else
        mmpkg.isWalking = false
      end
    else
      mmpkg.isWalking = false
      cecho(
        "<red>ERROR! Expected room #:<white> " ..
        speedWalkPath[1] ..
        "<red> But we're in room #:<white> " ..
        mmpkg.currentRoom.ID
      )
    end
  end
end

function mmpkg.fixExits(exits)
  if not table.is_empty(exits) then
    local pullexits =
      function(key, value)
        if type(value) ~= "table" then
          return true
        end
      end
    local fixedexits = table.collect(exits, pullexits)
    return fixedexits
  end
  return exits
end

function mmpkg.infoMap()
  local roomflags = "_empty"
  if mmpkg.isMaze(gmcp.room.info.num) then
    roomflags = gmcp.room.info.flags
  elseif roomExists(gmcp.room.info.num) then
    roomflags = table.concat(getRoomUserDataKeys(gmcp.room.info.num), ", ")
  else
    roomflags = gmcp.room.info.flags
  end
  if (roomflags == "_empty") then
    roomflags = "none"
  end
  GUI.MapInfo:echo(
    "<&nbsp> <&nbsp>" ..
    gmcp.room.info.zone ..
    " [" ..
    gmcp.room.info.coord.x ..
    "/" ..
    gmcp.room.info.coord.y ..
    "] -- " ..
    gmcp.room.info.name ..
    " (#" ..
    gmcp.room.info.num ..
    ")<br>  Flags: " ..
    roomflags
  )
end

function mmpkg.isMaze(InRoom)
  if (InRoom ~= -99) then
    do
      return false
    end
  else
    do
      return true
    end
  end
end

function mmpkg.gotoID(roomid)
  if getPath(gmcp.room.info.num, roomid) then
    mmpkg.doHighLightPath()
    doSpeedWalk()
  else
    hecho("\n#ff0000Unable to find a path.")
  end
end

function findAreaID(areaname)
  local list = getAreaTable()
  -- iterate over the list of areas, matching them with substring match.
  -- if we get match a single area, then return it's ID, otherwise return
  -- 'false' and a message that there are than one are matches
  local returnid, fullareaname
  for area, id in pairs(list) do
    if area:find(areaname, 1, true) then
      if returnid then
        --return false, "more than one area matches"
      end
      returnid = id;
      fullareaname = area
    end
  end
  return returnid, fullareaname
end