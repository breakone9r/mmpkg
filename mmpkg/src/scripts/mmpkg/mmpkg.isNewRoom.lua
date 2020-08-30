function mmpkg.isNewRoom()
    unHighlightRoom(gmcp.room.info.num)
    -- Center View on current room.
    mmpkg.nextSpeedStep()
    if mmpkg.isOutside(gmcp.room.info.zone) then
      GUI.myarrow:move(((mmpkg.imapx * gmcp.room.info.coord.x)+mmpkg.startx), ((mmpkg.imapy  * gmcp.room.info.coord.y)+mmpkg.starty))
      if mmpkg.isRoad(gmcp.room.info.coord.sym,gmcp.room.info.terrain) then
        if not roomExists(gmcp.room.info.num) then
          addRoom(gmcp.room.info.num)
        end
        setRoomChar(gmcp.room.info.num, gmcp.room.info.coord.sym)
        setRoomEnv(gmcp.room.info.num, 262)
      else
        do
          return
        end
      end
      mmpkg.doCoords()
    else
      if not roomExists(gmcp.room.info.num) then
        addRoom(gmcp.room.info.num)
        setRoomEnv(gmcp.room.info.num, 262)
        mmpkg.doCoords()
      end
    end
  end