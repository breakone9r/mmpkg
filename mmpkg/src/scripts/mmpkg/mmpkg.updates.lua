function mmpkg.checkforUpdate()
    noop()
  end
  
  function mmpkg.doUpdate()
    noop()
  end

function mmpkg.mapdownloaded(_,filename)
  if not filename:find("mm_map.dat", 1, true) then
    return
  end
  cecho("<green>DONE! Loading your new map.")
  loadMap(getMudletHomeDir() .. "/map/mm_map.dat")
end
  
function mmpkg.updateMap()
  cecho("\n<white>Downloading the latest map: <gray>https://github.com/breakone9r/mmpkg/raw/master/mm_map.dat\n<green>This may take a bit. It's a large map.")
  local saveto = getMudletHomeDir() .. "/map/mm_map.dat"
  local url = "https://github.com/breakone9r/mmpkg/raw/master/mm_map.dat"    
  registerAnonymousEventHandler("sysDownloadDone", "mmpkg.mapdownloaded")
  downloadFile(saveto, url)
end  