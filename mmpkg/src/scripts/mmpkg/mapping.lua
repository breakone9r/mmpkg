mudlet = mudlet or {}
mudlet.mapper_script = true

function mapping()
  -- Do nothing but center on maze if in maze
  if mmpkg.isMaze(gmcp.room.info.num) then
    mmpkg.infoMap()
    centerview(1)
    mmpkg.doExits(
      gmcp.room.info.zone,
      gmcp.room.info.num,
      gmcp.room.info.exits,
      gmcp.room.info.coord.sym,
      gmcp.room.info.terrain
    )
    do
      return
    end
  end
  if (gmcp.room.info.num ~= mmpkg.currentRoom.ID) then
    mmpkg.previousRoom.ID = mmpkg.currentRoom.ID
    mmpkg.previousRoom.exits = mmpkg.currentRoom.exits
    mmpkg.currentRoom.ID = gmcp.room.info.num
    mmpkg.currentRoom.exits = mmpkg.fixExits(gmcp.room.info.exits)
    mmpkg.previousRoom.Area = mmpkg.currentRoom.Area
    mmpkg.currentRoom.Area = gmcp.room.info.zone
    raiseEvent("mmpkg.onNewRoom")
    if (mmpkg.previousRoom.Area ~= mmpkg.currentRoom.Area) then
      raiseEvent("mmpkg.onNewZone")
    end
  end
  setRoomName(gmcp.room.info.num, gmcp.room.info.name)
  setRoomArea(gmcp.room.info.num, gmcp.room.info.zone)
  mmpkg.setFlags()
  mmpkg.infoMap()
  -- doExits(zone, room, exits, symbol, terrain)
  mmpkg.doExits(
    gmcp.room.info.zone,
    gmcp.room.info.num,
    mmpkg.fixExits(gmcp.room.info.exits),
    gmcp.room.info.coord.sym,
    gmcp.room.info.terrain
  )
  centerview(gmcp.room.info.num)
end
