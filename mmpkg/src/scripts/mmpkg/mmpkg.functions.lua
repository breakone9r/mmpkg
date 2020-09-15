function mmpkg.doHighLightPath()
  for i, v in pairs(speedWalkPath) do
    local r, g, b = unpack(color_table.red)
    local br, bg, bb = unpack(color_table.blue)
    highlightRoom(v, r, g, b, br, bg, bb, 1, 125, 125)
  end
end

function mmpkg.tchelper(first, rest)
  return first:upper() .. rest:lower()
end

function mmpkg.doTitle(strng)
  return strng:gsub("(%a)([%w_']*)", mmpkg.tchelper)
end

function mmpkg.doAffect(aff, ison, quiet)
  mmpkg.myAffects = mmpkg.myAffects or {}
  mmpkg.myAffects.affects = mmpkg.myAffects.affects or {}
  mmpkg.myAffects.missing = mmpkg.myAffects.missing or {}
  if ison then
    if table.contains(mmpkg.myAffects.missing, aff) then
      table.remove(mmpkg.myAffects.missing, table.index_of(mmpkg.myAffects.missing, aff))
    end
    if not table.contains(mmpkg.myAffects.affects, aff) then
      table.insert(mmpkg.myAffects.affects, aff)
    end
    color = "\n<blue:green>"
  else
    if not table.contains(mmpkg.myAffects.missing, aff) then
      table.insert(mmpkg.myAffects.missing, aff)
    end
    if table.contains(mmpkg.myAffects.missing, aff) then
      table.remove(mmpkg.myAffects.affects, table.index_of(mmpkg.myAffects.affects, aff))
    end
    color = "\n<white:red>"
  end
  if not quiet then
    cecho(color .. mmpkg.doTitle(aff) .. ": " .. string.upper(ison))
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
      -- Outside, not on a road. do nothing!
      do
        return
      end
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
    mmpkg.mapimg,
    (GUI.vmapper:get_width() / 2300),
    (GUI.vmapper:get_height() / 1500),
    0,
    0
  elseif (gmcp.room.info.zone == "Alyrian Underworld") then
    mmpkg.vmapimg, mmpkg.imapx, mmpkg.imapy, mmpkg.startx, mmpkg.starty =
    mmpkg.ugimg,
    (GUI.vmapper:get_width() / 2300),
    (GUI.vmapper:get_height() / 1500),
    0,
    0
  elseif (gmcp.room.info.zone == "Faerie Plane Wilderness") then
    mmpkg.vmapimg, mmpkg.imapx, mmpkg.imapy, mmpkg.startx, mmpkg.starty =
    mmpkg.fpimg,
    (GUI.vmapper:get_width() / (610)),
    (GUI.vmapper:get_height() / 400),
    57 + 18,
    0
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
  elseif (gmcp.room.info.zone == "Chat Rooms Wilderness") then
    mmpkg.vmapimg, mmpkg.imapx, mmpkg.imapy, mmpkg.startx, mmpkg.starty =
    mmpkg.socialimg,
    (GUI.vmapper:get_width() / 144),
    (GUI.vmapper:get_height() / 94),
    (GUI.vmapper:get_width() / 175),
    (GUI.vmapper:get_height() / 5.75)
  else
    mmpkg.vmapimg, mmpkg.imapx, mmpkg.imapy, mmpkg.startx, mmpkg.starty = mmpkg.mapimg, 100, 100, 0, 0
  end
  GUI.vmapper:setStyleSheet([[border-image: url(]] .. mmpkg.vmapimg .. [[);]])
  GUI.myarrow:move(
    ((mmpkg.imapx * gmcp.room.info.coord.x) + mmpkg.startx),
    ((mmpkg.imapy * gmcp.room.info.coord.y) + mmpkg.starty)
  )
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
    local dirToCoords = {
      u = {x, y, z - 1},
      d = {x, y, z + 1},
      n = {x, y - 1, z},
      s = {x, y + 1, z},
      e = {x - 1, y, z},
      w = {x + 1, y, z},
      ne = {x - 1, y - 1, z},
      se = {x - 1, y + 1, z},
      nw = {x + 1, y - 1, z},
      sw = {x + 1, y + 1, z}
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

function mmpkg.log(chan, cap)
  local line = ""
  line = line .. getTime(true, "MM/dd/yy hh:mm:ss - ")
  filename = getMudletHomeDir() .. "/log/" .. chan .. ".log"
  fname = io.open(filename, "a+")
  line = line .. cap .. "\n"
  fname:write(line)
  fname:close()
end

function mmpkg.playlog(chan)
  local lines = 0
  local startline = 0
  filename = getMudletHomeDir() .. "/log/" .. chan .. ".log"
  if not io.exists(filename) then
    do return end
  end
  mmpkg.Captures:disableTimestamp()
  for line in io.lines(filename) do
    lines = lines + 1
  end
  if lines > 10 then
    startline = lines - 10
  end
  lines = 0
  mmpkg.Captures:cecho(chan, "<brown>Begin playback of old logs (last <10 lines)\n", true)
  for line in io.lines(filename) do
    lines = lines + 1
    if lines > startline then
      mmpkg.Captures:decho(chan, line .. "\n", true)
    end
  end
  mmpkg.Captures:cecho(chan, "<brown>End playback of old logs (last <10 lines)\n", true)
  if mmpkg.conf.timestamps == true then
    mmpkg.Captures:enableTimestamp()
  end
end

function mmpkg.Cap(chan, line)
  selectCurrentLine()
  mmpkg.Captures:append(chan)
  deselect()
  resetFormat()
  if mmpkg.conf.logging == true then
    mmpkg.log(chan, line)
    mmpkg.log("All", line)
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
          1.7,
          function()
            mmpkg.isWalking = false
            cecho(
              "<red>ERROR! Expected room #:<white> " ..
              speedWalkPath[1] .. "<red> But we've stopped in room #:<white> " .. mmpkg.currentRoom.ID
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
        speedWalkPath[1] .. "<red> But we're in room #:<white> " .. mmpkg.currentRoom.ID
      )
    end
  end
end

function mmpkg.fixExits(exits)
  if not table.is_empty(exits) then
    local pullexits = function(key, value)
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
  GUI.MapInfo:echo("&nbsp;"..gmcp.room.info.zone.." ["..gmcp.room.info.coord.x..
    "/"..gmcp.room.info.coord.y.."] -- "..gmcp.room.info.name.." (#"..gmcp.room.info.num..
  ")<br>&nbsp;Flags: "..roomflags)
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

function mmpkg.pathtoID(roomid)
  if getPath(gmcp.room.info.num, roomid) then
    cecho("<yellow> Highlighting the rooms you need to visit ")
    cecho("<cyan>room#: " .. roomid .. "\n" .. table.concat(speedWalkDir, ", "))
    mmpkg.doHighLightPath()
  else
    hecho("\n#ff0000Unable to find a path.")
  end
end

function spairs(tbl, order)
  local keys = table.keys(tbl)
  if order then
    table.sort(
      keys,
      function(a, b)
        return order(tbl, a, b)
      end
    )
  else
    table.sort(keys)
  end

  local i = 0
  return function()
    i = i + 1
    if keys[i] then
      return keys[i], tbl[keys[i]]
    end
  end
end

function mmpkg.mwhere(pattern, gotofirst, areaonly)
  local matchingRooms = {}
  local searchedareas = {}
  local localonly = ""
  local tmpsearchedareas = searchRoom(pattern)
  local arearooms = getAreaRooms(getRoomArea(getPlayerRoom()))
  local matchingRooms = {}
  local key = 0
  for id, _ in pairs(tmpsearchedareas) do
    searchedareas[key] = id
    key = key + 1
  end
  if areaonly then
    matchingRooms = table.n_intersection(arearooms, searchedareas)
    localonly = " in Current Area"
  else
    matchingRooms = table.deepcopy(searchedareas)
  end
  if table.is_empty(matchingRooms) then
    cecho("\n<red>ERROR!: <cyan>No matching rooms found.")
    do
      return
    end
  end
  local reachableRooms = {}
  local unreachableRooms = {}

  for _, id in pairs(matchingRooms) do
    local _, tw = getPath(gmcp.room.info.num, id)
    if tw > - 1 then
      reachableRooms[id] = tw
    else
      unreachableRooms[id] = id
    end
  end
  if not gotofirst then
    cecho(
      "\n<white> Rooms" ..
      localonly ..
      " Matching " ..
      [["]] ..
      pattern ..
      [["]] .. " \n closest first. (n / a = unreachable) (right - click room# for more options)"
    )
    cecho("\n<white> ( dist)    #room - Name                                          -- Area\n")
    cecho("<blue>------------------------------------------------------------------------------------------\n\n")
  end
  if not table.is_empty(reachableRooms) then
    local sortFunc = function(t, a, b)
      return t[a] < t[b]
    end

    for id, tw in spairs(reachableRooms, sortFunc) do
      local area = getRoomAreaName(getRoomArea(id))
      local room = getRoomName(id)
      local gotocommand = "mapper goto " .. id
      local pathtocommand = "mapper path " .. id
      if gotofirst then
        mmpkg.gotoID(id)
        do
          return
        end
      end
      cecho(
        "<cyan> (" ..
        string.cut("       ", 5 - string.len(tw)) ..
        tw .. ")" .. string.cut("      ", 9 - string.len("#" .. id))
      )
      echoPopup(
        "#" .. id,
        {[[mmpkg.gotoID(]] .. id .. [[)]], [[mmpkg.pathtoID(]] .. id .. [[)]]},
        {gotocommand, pathtocommand}
      )
      cecho(
        "<cyan> - " ..
        string.cut(room .. "                                                         ", 55) ..
        " -- " .. string.cut(area, 21) .. "\n"
      )
    end
  end

  if gotofirst then
    do
      return
    end
  end

  if not table.is_empty(unreachableRooms) then
    for id, tw in spairs(unreachableRooms) do
      local area = getRoomAreaName(getRoomArea(id))
      local room = getRoomName(id)
      local gotocommand = "mapper goto " .. id
      cecho(
        "<cyan> (" ..
        string.cut("       ", 5 - string.len("n/a")) ..
        "n/a" .. ")" .. string.cut("      ", 9 - string.len("#" .. id))
      )
      echoLink("#" .. id, [[mmpkg.gotoID(]] .. id .. [[)]], gotocommand)
      cecho(
        "<cyan> - " ..
        string.cut(room .. "                                                         ", 55) ..
        " -- " .. string.cut(area, 21) .. "\n"
      )
    end
  end
end

function mmpkg.mfind(flag, gotofirst, areaonly)
  if mmpkg.conf.findareaonly == true then
    areaonly = true
  end
  local searchedareas = searchRoomUserData(flag, "true")
  local arearooms = getAreaRooms(getRoomArea(getPlayerRoom()))
  local matchingRooms = {}
  if areaonly then
    matchingRooms = table.n_intersection(arearooms, searchedareas)
  else
    matchingRooms = table.deepcopy(searchedareas)
  end
  if table.is_empty(matchingRooms) then
    cecho("\n<red>ERROR!: <cyan>No matching rooms found.")
    do
      return
    end
  end

  local reachableRooms = {}
  local unreachableRooms = {}

  for key, id in pairs(matchingRooms) do
    local _, tw = getPath(gmcp.room.info.num, id)
    if tw > - 1 then
      reachableRooms[id] = tw
    else
      unreachableRooms[id] = id
    end
  end

  if not gotofirst then
    cecho(
      "\n<white> Area Rooms with roomflag " ..
      [["]] .. flag .. [["]] .. " \n closest first. (n/a = unreachable) (right-click room# for more options)"
    )
    cecho("\n<white> ( dist)    #room - Name                                          -- Area\n")
    cecho("<blue>------------------------------------------------------------------------------------------\n\n")
  end

  if not table.is_empty(reachableRooms) then
    local sortFunc = function(t, a, b)
      return t[a] < t[b]
    end

    for id, tw in spairs(reachableRooms, sortFunc) do
      local area = getRoomAreaName(getRoomArea(id))
      local room = getRoomName(id)
      local gotocommand = "mapper goto " .. id
      local pathtocommand = "mapper path " .. id
      if gotofirst then
        mmpkg.gotoID(id)
        do
          return
        end
      end
      cecho(
        "<cyan> (" ..
        string.cut("       ", 5 - string.len(tw)) ..
        tw .. ")" .. string.cut("      ", 9 - string.len("#" .. id))
      )
      echoPopup(
        "#" .. id,
        {[[mmpkg.gotoID(]] .. id .. [[)]], [[mmpkg.pathtoID(]] .. id .. [[)]]},
        {gotocommand, pathtocommand}
      )
      cecho(
        "<cyan> - " ..
        string.cut(room .. "                                                         ", 45) ..
        " -- " .. string.cut(area, 21) .. "\n"
      )
    end
  end

  if gotofirst then
    do
      return
    end
  end

  if not table.is_empty(unreachableRooms) then
    for tw, id in spairs(unreachableRooms) do
      local area = getRoomAreaName(getRoomArea(id))
      local room = getRoomName(id)
      local gotocommand = "mapper goto " .. id
      cecho(
        "<cyan> (" ..
        string.cut("       ", 5 - string.len("n/a")) ..
        "n/a" .. ")" .. string.cut("      ", 9 - string.len("#" .. id))
      )
      echoLink("#" .. id, [[mmpkg.gotoID(]] .. id .. [[)]], gotocommand)
      cecho(
        "<cyan> - " ..
        string.cut(room .. "                                                         ", 45) ..
        " -- " .. string.cut(area, 21) .. "\n"
      )
    end
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
        -- return false, "more than one area matches"
      end
      returnid = id
      fullareaname = area
    end
  end
  return returnid, fullareaname
end
