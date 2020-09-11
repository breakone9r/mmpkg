function mmpkg.getupdater()
  local saveto = getMudletHomeDir() .. "/mmpkg-updater-1.0.mpackage"
  local url = "https://github.com/breakone9r/mmpkg/raw/master/mmpkg-updater-1.0.mpackage"
  if mmpkg.events.downloads then
    killAnonymousEventHandler(mmpkg.events.downloads)
  end
  mmpkg.events.downloads = registerAnonymousEventHandler("sysDownloadDone", "mmpkg.installupdater")
  downloadFile(saveto, url)
end

function mmpkg.installupdater(_, filename)
  if not filename:find("mmpkg-updater-1.0.mpackage", 1, true) then
    return
  end
  cecho("\n\n<green>Download complete, installing updater.")
  installPackage(filename)
  os.remove(filename)
  cecho("<white>Updater installed, please re-run '<yellow>mmpkg update<white>'")
end

function mmpkg.mapdownloaded(_, filename)
  if not filename:find("mm_map.dat.new", 1, true) then
    return
  end
  cecho("\n\n<green>DONE! Loading your new map.\n\n")
  loadMap(getMudletHomeDir() .. "/map/mm_map.dat.new")
  os.remove(filename)
  mmpkg.downloadconfirmed = nil
  if roomExists(gmcp.room.info.num) then
    centerview(gmcp.room.info.num)
  else
    cecho("<white>Unknown Room. Please move to a known room (And then map this one!)")
  end
end

function mmpkg.updateMap()
  if mmpkg.downloadconfirmed then
    cecho(
      "\n<white>Downloading the latest map: <gray>https://github.com/breakone9r/mmpkg/raw/master/mm_map.dat\n<green>This may take a bit. It's a large map."
    )
    local saveto = getMudletHomeDir() .. "/map/mm_map.dat.new"
    local url = "https://github.com/breakone9r/mmpkg/raw/master/mm_map.dat"
    if mmpkg.events.downloads then
      killAnonymousEventHandler(mmpkg.events.downloads)
    end
    mmpkg.events.downloads = registerAnonymousEventHandler("sysDownloadDone", "mmpkg.mapdownloaded")
    downloadFile(saveto, url)
  else
    cecho(
      "<white>ARE YOU SURE? <cyan>Updating the map will overwrite any existing map you have. Re-run mapper update if you wish to continue."
    )
    mmpkg.downloadconfirmed = true
    tempTimer(
      3,
      function()
        mmpkg.downloadconfirmed = nil
      end
    )
  end
end
