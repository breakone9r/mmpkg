local baseroom, moveroom
local dirs = {"n", "s", "w", "e", "nw", "ne", "sw", "se", "u", "d"}
if not matches[3] then
  cecho("\n<white:red>Invalid Usage.<reset>\n")
  cecho("<blue>/------------------------------------------------------\\<reset>\n")
  cecho("<blue>|         <white>repos [me] <direction> [roomID#]<blue>             |<reset>\n")
  cecho("<blue>\\------------------------------------------------------/<reset>\n")
  cecho(
    "<cyan>me and roomID are optional, roomID must be an existing room#. If me is specified, it will place your current room just to the direction specified of your previous room, or of roomID if specified.<reset>\n"
  )
  return
end
if matches[2] == "me" then
  baseroom = matches[4] or mmpkg.previousRoom.ID
  moveroom = gmcp.room.info.num
else
  baseroom = gmcp.room.info.num
  for _, dir in pairs(dirs) do
    if matches[3] == dir then
      if matches[4] then
        moveroom = matches[4]
      elseif gmcp.room.info.exits[dir] then
        moveroom = gmcp.room.info.exits[dir]
      else
        cecho("\n<white:red>ERROR: No exit in that direction!.<reset>\n")
        return
      end
    end
  end
end
if not roomExists(baseroom) or not roomExists(moveroom) then
  cecho("\n<white:red>ERROR: RoomID specified does not exist.<reset>\n")
  return
end

local x, y, z = getRoomCoordinates(baseroom)
local diradd = 
{
  u = {x, y, z + 1},
  d = {x, y, z - 1},
  n = {x, y + 1, z},
  s = {x, y - 1, z},
  e = {x + 1, y, z},
  w = {x - 1, y, z},
  ne = {x + 1, y + 1, z},
  se = {x + 1, y - 1, z},
  nw = {x - 1, y + 1, z},
  sw = {x - 1, y - 1, z},
}
local repos_str = string.format("\n<white>Repositioning Room# <magenta>%s <white>to the <magenta>%s <white>of Room# <magenta>%s<white>.<reset>\n", moveroom, matches[3], baseroom)
cecho(repos_str)
--setRoomCoordinates(moveroom,unpack(diradd[matches[3]]))
updateMap()
