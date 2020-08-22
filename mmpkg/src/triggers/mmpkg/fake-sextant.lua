if (gmcp.room.info.zone == "Alyria") or (gmcp.room.info.zone == "Faerie Plane Wilderness") or (gmcp.room.info.zone == "Lasler Valley") then
    local length = matches[2]:len()
    local coords = gmcp.room.info.coord.x .. ", " .. gmcp.room.info.coord.y
    local dashlength = 44 - string.len(coords)
    local coordinsert = "<blue>;-[ <gray>" .. coords .. "<blue> ]" .. string.rep("-",dashlength)
    selectCaptureGroup(2)
    creplace(coordinsert)
    deselect()
    resetFormat()
end