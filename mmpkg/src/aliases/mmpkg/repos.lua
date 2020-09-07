local x, y, z = getRoomCoordinates(gmcp.room.info.num)
--display(x,y,z)

if (matches[2] == "n") then
  setRoomArea(gmcp.room.info.exits.n, gmcp.room.info.zone)
  setRoomCoordinates(gmcp.room.info.exits.n, x, y + 1, z)
end

if (matches[2] == "s") then
  setRoomArea(gmcp.room.info.exits.s, gmcp.room.info.zone)
  setRoomCoordinates(gmcp.room.info.exits.s, x, y - 1, z)
end

if (matches[2] == "e") then
  setRoomArea(gmcp.room.info.exits.e, gmcp.room.info.zone)
  setRoomCoordinates(gmcp.room.info.exits.e, x + 1, y, z)
end

if (matches[2] == "w") then
  setRoomArea(gmcp.room.info.exits.w, gmcp.room.info.zone)
  setRoomCoordinates(gmcp.room.info.exits.w, x - 1, y, z)
end

if (matches[2] == "ne") then
  setRoomArea(gmcp.room.info.exits.ne, gmcp.room.info.zone)
  setRoomCoordinates(gmcp.room.info.exits.ne, x + 1, y + 1, z)
end

if (matches[2] == "nw") then
  setRoomArea(gmcp.room.info.exits.nw, gmcp.room.info.zone)
  setRoomCoordinates(gmcp.room.info.exits.nw, x - 1, y + 1, z)
end

if (matches[2] == "sw") then
  setRoomArea(gmcp.room.info.exits.sw, gmcp.room.info.zone)
  setRoomCoordinates(gmcp.room.info.exits.sw, x - 1, y - 1, z)
end

if (matches[2] == "se") then
  setRoomArea(gmcp.room.info.exits.se, gmcp.room.info.zone)
  setRoomCoordinates(gmcp.room.info.exits.se, x + 1, y - 1, z)
end

if (matches[2] == "u") then
  setRoomArea(gmcp.room.info.exits.u, gmcp.room.info.zone)
  setRoomCoordinates(gmcp.room.info.exits.u, x, y, z + 1)
end

if (matches[2] == "d") then
  setRoomArea(gmcp.room.info.exits.d, gmcp.room.info.zone)
  setRoomCoordinates(gmcp.room.info.exits.d, x, y, z - 1)
end
