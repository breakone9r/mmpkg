function mmpkg.checkupdate(auto)
  mmpkg.conf.autodl = auto
  local saveto = getMudletHomeDir() .. "/mmpkg.currentversion"
  local url = "https://github.com/breakone9r/mmpkg/raw/master/mmpkg.currentversion"
  if mmpkg.events.downloads then
    killAnonymousEventHandler(mmpkg.events.downloads)
  end
  mmpkg.events.downloads = registerAnonymousEventHandler("sysDownloadDone", "mmpkg.getlatestversion")
  downloadFile(saveto, url)
end

function mmpkg.getlatestversion(_, filename)
  if not filename:find("mmpkg.currentversion", 1, true) then
    return
  end
  mmpkg.currentversion = {}
  table.load(filename, mmpkg.currentversion)
  mmpkg.currentversion = table.concat(mmpkg.currentversion)
  os.remove(filename)
  mmpkg.checkversion(mmpkg.conf.autodl)
end

function mmpkg.checkversion(auto)
  local newver = utf8.remove(mmpkg.currentversion, 1, 6)
  local curver = utf8.remove(mmpkg.packagename, 1, 6)
  if newver == curver then
    cecho("<green>\nYou're already running the latest version: "..mmpkg.currentversion.."\n")
  elseif newver > curver then
    cecho("<white>Updated version is: <green>'"..mmpkg.currentversion.."'<white>, but you're still running: '<green>"..mmpkg.packagename)
    if auto then
      cecho("\n<white>Downloading update...")
      mmpkg.downupdate()
    end
  elseif newver < curver then
    cecho("\n<blue:white>You appear to running a pre-release: <green:black>"..mmpkg.packagename)
    cecho("\n<blue:white> Current release                   : <green:black>"..mmpkg.currentversion)
    cecho("\n")
  end
end

function mmpkg.downupdate(_, filename)
  local saveto = getMudletHomeDir() .. "/" .. mmpkg.currentversion .. ".mpackage"
  local url = "https://github.com/breakone9r/mmpkg/raw/master/" .. mmpkg.currentversion .. ".mpackage"
  if mmpkg.events.downloads then
    killAnonymousEventHandler(mmpkg.events.downloads)
  end
  mmpkg.events.downloads = registerAnonymousEventHandler("sysDownloadDone", "mmpkg.installupdate")
  downloadFile(saveto, url)
end

function mmpkg.installupdate(_, filename)
  if not filename:find(mmpkg.currentversion, 1, true) then
    return
  end
  uninstallPackage(mmpkg.packagename)
  installPackage(filename)
  os.remove(filename)
  cecho("\n<blue:white>Update installed, please restart Mudlet for updates to take effect.")
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
