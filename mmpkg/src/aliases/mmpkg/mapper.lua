if (matches[2] == "goto") then
    if tonumber(matches[3]) then
        mmpkg.gotoID(string.trim(matches[3]))
    else
        mmpkg.mwhere(string.trim(matches[3]),true,false)
    end
elseif (matches[2] == "path") then
    mmpkg.pathtoID(string.trim(matches[3]))
elseif (matches[2] == "update") then
    mmpkg.updateMap()
elseif (matches[2] == "stop") then
    mmpkg.isWalking = false
    cecho(
        "<red>STOPPING YOUR RUN.<cyan> To clear highlighted rooms type: <gray>mapper clear\n")
elseif (matches[2] == "where") then
    mmpkg.mwhere(string.trim(matches[3]))
elseif (matches[2] == "find") then
    mmpkg.mfind(string.trim(matches[3]),false,true)
elseif (matches[2] == "sign") then
    mmpkg.mfind("sign",true,false)
elseif (matches[2] == "trainer") then
    if (getRoomUserData(gmcp.room.info.num, "trainer") == "true") then
        setRoomEnv(gmcp.room.info.num, 262)
        cecho("\n<cyan>Removing <blue>Trainer<cyan> flag from room " ..
                  gmcp.room.info.num)
        clearRoomUserDataItem(gmcp.room.info.num, "trainer")
    else
        setRoomEnv(gmcp.room.info.num, 260)
        cecho("\n<cyan>Setting room " .. gmcp.room.info.num ..
                  " to type: <blue>trainer")
        setRoomUserData(gmcp.room.info.num, "trainer", "true")
        clearRoomUserDataItem(gmcp.room.info.num, "_empty")
    end
elseif (matches[2] == "shop") then
    if (getRoomUserData(gmcp.room.info.num, "shop") == "true") then
        setRoomEnv(gmcp.room.info.num, 262)
        cecho("\n<cyan>Removing <green>Shop<cyan> flag from room " ..
                  gmcp.room.info.num)
        clearRoomUserDataItem(gmcp.room.info.num, "shop")
    else
        setRoomEnv(gmcp.room.info.num, 267)
        cecho("\n<cyan>Setting room " .. gmcp.room.info.num ..
                  " to type: <green>shop")
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
    cecho(
        "\n<green>          Will search for rooms with name that includes string\n")
    cecho("\n<cyan>    mapper goto room# or string")
    cecho("\n<green>          Will speedwalk to the specified room number, or the closest room to match string\n")
    cecho("\n<cyan>    mapper sign")
    cecho("\n<green>          Will speedwalk to the nearest roadsign for running.\n")
    cecho("\n<cyan>    mapper stop")
    cecho("\n<green>          Will halt any active speedwalks.\n")
    cecho("\n<cyan>    mapper path roomIDnumber")
    cecho("\n<green>          Will show the path to the specified room number\n")
    cecho("\n<cyan>    mapper find roomflag")
    cecho(
        "\n<green>          Where roomflag is either safe, shop, trainer, or high-regen.\n          (or other known roomflags) will show rooms in your area that match.\n")
    cecho("\n<cyan>    mapper shop")
    cecho(
        "\n<green>          Will toggle the room flag: shop and color the room appropriately (room\n          colors will be overwritten by PK and SAFE colors)\n")
    cecho("\n<cyan>    mapper trainer")
    cecho(
        "\n<green>          Will toggle the room flag: trainer and color the room appropriately (room\n          colors will be overwritten by PK and SAFE colors)\n")
    cecho("\n<cyan>    mapper clear")
    cecho(
        "\n<green>          Clears all highlighted rooms from your current area.\n")
    cecho("\n<cyan>    mapper update")
    cecho(
        "\n<green>          Downloads and installs the latest map database from github.\n          <white>THIS WILL OVERWRITE YOUR CURRENT MAP!\n")
end
