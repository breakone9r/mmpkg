if (matches[2] == "goto") then
  mmpkg.gotoID(string.trim(matches[3]))
elseif (matches[2] == "path") then
  if getPath(gmcp.room.info.num, string.trim(matches[3])) then
    cecho("<yellow> Highlighting the rooms you need to visit ")
    cecho("<cyan>room#: " .. matches[3] .. "\n" .. table.concat(speedWalkDir, ", "))
    mmpkg.doHighLightPath()
  else
    hecho("\n#ff0000Unable to find a path.")
  end
elseif (matches[2] == "update") then
  mmpkg.updateMap()
elseif (matches[2] == "stop") then
  mmpkg.isWalking = false
  cecho("<red>STOPPING YOUR RUN.<cyan> To clear highlighted rooms type: <gray>mapper clear\n")
elseif (matches[2] == "where") then
  local matchingRooms = searchRoom(string.trim(matches[3]))
  if not table.is_empty(matchingRooms) then
    for id, room in pairs(matchingRooms) do
      local roomarea = getRoomAreaName(getRoomArea(id))
      local gotocommand = "mapper goto " .. id
      cechoLink(
        "\n<cyan> #" ..
        string.cut(id .. "  ", 7) ..
        " - " ..
        string.cut(room .. "                                                         ", 55) ..
        " -- " ..
        roomarea,
        [[mmpkg.gotoID(]] .. id .. [[)]],
        gotocommand,
        true
      )
    end
  else
    cecho("\n<red>ERROR!: <cyan>No matching rooms found.")
  end
elseif (matches[2] == "find") then
  local arearooms = getAreaRooms(getRoomArea(getPlayerRoom()))
  local searchedareas = searchRoomUserData(string.trim(matches[3]), "true")
  local areashops = table.n_intersection(arearooms, searchedareas)
  local area = getRoomAreaName(getRoomArea(getPlayerRoom()))
  local room = ""
  cecho("<white>Rooms in " .. area .. " that match type/flag: " .. matches[3] .. "\n")
  if table.is_empty(areashops) then
    cecho("<red>ERROR: No matching rooms!\n")
  else
    for id, roomid in pairs(areashops) do
      local gotocommand = "mapper goto " .. roomid
      local room = getRoomName(roomid)
      cechoLink(
        string.cut("\n<cyan>" .. room .. "                                           ", 55) ..
        " -- " ..
        area,
        [[mmpkg.gotoID(]] .. roomid .. [[)]],
        gotocommand,
        true
      )
    end
  end
elseif (matches[2] == "trainer") then
  if (getRoomUserData(gmcp.room.info.num, "trainer") == "true") then
    setRoomEnv(gmcp.room.info.num, 262)
    cecho("\n<cyan>Removing <blue>Trainer<cyan> flag from room " .. gmcp.room.info.num)
    clearRoomUserDataItem(gmcp.room.info.num, "trainer")
  else
    setRoomEnv(gmcp.room.info.num, 260)
    cecho("\n<cyan>Setting room " .. gmcp.room.info.num .. " to type: <blue>trainer")
    setRoomUserData(gmcp.room.info.num, "trainer", "true")
    clearRoomUserDataItem(gmcp.room.info.num, "_empty")
  end
elseif (matches[2] == "shop") then
  if (getRoomUserData(gmcp.room.info.num, "shop") == "true") then
    setRoomEnv(gmcp.room.info.num, 262)
    cecho("\n<cyan>Removing <green>Shop<cyan> flag from room " .. gmcp.room.info.num)
    clearRoomUserDataItem(gmcp.room.info.num, "shop")
  else
    setRoomEnv(gmcp.room.info.num, 267)
    cecho("\n<cyan>Setting room " .. gmcp.room.info.num .. " to type: <green>shop")
    setRoomUserData(gmcp.room.info.num, "shop", "true")
    clearRoomUserDataItem(gmcp.room.info.num, "_empty")
  end
elseif (matches[2] == "clear") then
  for i, v in pairs(getAreaRooms(getRoomArea(getPlayerRoom()))) do
    unHighlightRoom(v)
  end
else
  cecho("\n<red>mapper " .. matches[2] .. " is not a valid mapper command.")
  cecho("\n<cyan> Please use one of the following commands:")
  cecho("\n<cyan>    mapper where string")
  cecho("\n<green>          Will search for rooms with name that includes string\n")
  cecho("\n<cyan>    mapper goto roomIDnumber")
  cecho("\n<green>          Will speedwalk to the specified room number\n")
  cecho("\n<cyan>    mapper stop")
  cecho("\n<green>          Will halt any active speedwalks.\n")
  cecho("\n<cyan>    mapper path roomIDnumber")
  cecho("\n<green>          Will show the path to the specified room numer\n")
  cecho("\n<cyan>    mapper find roomflag")
  cecho("\n<green>          Where roomflag is either safe, shop, trainer, or high-regen.\n          (or other known roomflags) will show rooms in your area that match.\n")
  cecho("\n<cyan>    mapper shop")
  cecho("\n<green>          Will toggle the room flag: shop and color the room appropriately (room\n          colors will be overwritten by PK and SAFE colors)\n")
  cecho("\n<cyan>    mapper trainer")
  cecho("\n<green>          Will toggle the room flag: trainer and color the room appropriately (room\n          colors will be overwritten by PK and SAFE colors)\n")
  cecho("\n<cyan>    mapper clear")
  cecho("\n<green>          Clears all highlighted rooms from your current area.\n")
  cecho("\n<cyan>    mapper update")
  cecho("\n<green>          Downloads and installs the latest map database from github.\n          <white>THIS WILL OVERWRITE YOUR CURRENT MAP!\n")
end