function mmpkg.checkupdate(auto)
  mmpkg.conf.autodl = auto
  local saveto = getMudletHomeDir() .. "/mmpkg.currentversion"
  local url = "https://github.com/breakone9r/mmpkg/raw/master/mmpkg.currentversion"
  if mmpkg.events.downloadOK then
    killAnonymousEventHandler(mmpkg.events.downloadOK)
  end
  mmpkg.events.downloadOK = registerAnonymousEventHandler("sysDownloadDone", "mmpkg.filedownload")
  if mmpkg.events.downloadFail then
    killAnonymousEventHandler(mmpkg.events.downloadFail)
  end
  mmpkg.events.downloadFail = 
  registerAnonymousEventHandler("sysDownloadError", "mmpkg.filedownload")
  downloadFile(saveto, url)
end

function mmpkg.checkversion(auto)
  if mmpkg.currentversion == mmpkg.packagename then
    cecho("<green>\nYou're already running the latest version: " .. mmpkg.currentversion .. "\n")
  elseif mmpkg.currentversion > mmpkg.packagename then
    cecho(string.format("<white>Updated version is: <green>'%s'<white>, but you're still running: '<green>'%s'", mmpkg.currentversion, mmpkg.packagename))
    if auto then
      cecho("\n<white>Downloading update...")
      mmpkg.downloadupdate(mmpkg.currentversion)
    end
  elseif mmpkg.currentversion < mmpkg.packagename then
    cecho("\n<blue:white>You appear to running a pre-release: <green:black>" .. mmpkg.packagename)
    cecho(
      "\n<blue:white> Current release                   : <green:black>" .. mmpkg.currentversion
    )
    cecho("\n")
  end
end

function mmpkg.getsounds()
  local saveto1 = getMudletHomeDir() .. "/tmp/mm_sound_pack1.zip"
  local url1 = "http://www.materiamagica.com/downloads/soundpacks/mm_sound_pack1.zip"
  local saveto2 = getMudletHomeDir() .. "/tmp/mm_sound_pack1.zip"
  local url2 = "http://www.materiamagica.com/downloads/soundpacks/mm_sound_pack2.zip"
  if mmpkg.events.downloadOK then
    killAnonymousEventHandler(mmpkg.events.downloadOK)
  end
  mmpkg.events.downloadOK = registerAnonymousEventHandler("sysDownloadDone", "mmpkg.filedownload")
  if mmpkg.events.downloadFail then
    killAnonymousEventHandler(mmpkg.events.downloadFail)
  end
  mmpkg.events.downloadFail = 
  registerAnonymousEventHandler("sysDownloadError", "mmpkg.filedownload")
  mmpkg.soundpacks = 0
  downloadFile(saveto1, url1)
  downloadFile(saveto2, url2)
end

function mmpkg.downloadupdate(filename)
  local saveto = getMudletHomeDir() .. "/" .. mmpkg.currentversion .. ".mpackage"
  local url = 
  "https://github.com/breakone9r/mmpkg/releases/download/" ..
  utf8.remove(mmpkg.currentversion, 1, 6) ..
  "/" ..
  mmpkg.currentversion ..
  ".mpackage"
  if mmpkg.events.downloadOK then
    killAnonymousEventHandler(mmpkg.events.downloadOK)
  end
  mmpkg.events.downloadOK = registerAnonymousEventHandler("sysDownloadDone", "mmpkg.filedownload")
  if mmpkg.events.downloadFail then
    killAnonymousEventHandler(mmpkg.events.downloadFail)
  end
  mmpkg.events.downloadFail = 
  registerAnonymousEventHandler("sysDownloadError", "mmpkg.filedownload")
  downloadFile(saveto, url)
end

function mmpkg.unzipmap(event, ...)
  local args = {...}
  local zipName = args[1]
  local unzipLocation = args[2]
  if event == "sysUnzipDone" then
    if zipName:find("mm_sound_pack1.zip") then
      soundpacks = soundpacks + 1
      cecho(string.format("<white>MP3 Sound Pack %s/2 installed.", soundpacks))
      os.remove(zipName)
    elseif zipName:find("mm_sound_pack2.zip") then
      soundpacks = soundpacks + 1
      cecho(string.format("<white>MP3 Sound Pack %s/2 installed.", soundpacks))
      os.remove(zipName)
    elseif zipName:find("mm_map.zip") then
      local unzippedMap = unzipLocation .. "/mm_map.dat"
      loadMap(unzippedMap)
      os.remove(zipName)
      os.remove(unzippedMap)
      local roomcount = 0
      for k, v in pairs(getRooms()) do
        roomcount = roomcount + 1
      end
      cecho(string.format("\n<white>Update complete! We now know %s rooms!\n", roomcount))
      if roomExists(gmcp.room.info.num) then
        centerview(gmcp.room.info.num)
      else
        cecho("<white>Unknown Room. Please move to a known room (And then map this one!)")
      end
    end
  elseif event == "sysUnzipError" then
    cecho(
      string.format("<firebrick>Update failed! Tried to unzip %s to %s\n", zipName, unzipLocation)
    )
  end
end

function mmpkg.filedownload(event, filename)
  if event == "sysDownloadError" then
    cecho(string.format("\n<red:white>ERROR:<white:black> Failed to download: %s", filename))
    return
  end
  if filename:find("mm_map.zip", 1, true) then
    cecho("\n\n<green>Download done. Unzipping & loading your new map.\n\n")
    if mmpkg.events.unzipOK then
      killAnonymousEventHandler(mmpkg.events.unzipOK)
    end
    if mmpkg.events.unzipFail then
      killAnonymousEventHandler(mmpkg.events.unzipFail)
    end
    mmpkg.events.unzipOK = registerAnonymousEventHandler("sysUnzipDone", mmpkg.unzipmap)
    mmpkg.events.unzipFail = registerAnonymousEventHandler("sysUnzipFail", mmpkg.unzipmap)
    unzipAsync(filename, getMudletHomeDir() .. "/tmp")
  elseif filename:find("mm_soundpack", 1, true) then
    cecho("\n\n<green>Download done. Unzipping & installing " .. filename .. ".\n\n")
    if mmpkg.events.unzipOK then
      killAnonymousEventHandler(mmpkg.events.unzipOK)
    end
    if mmpkg.events.unzipFail then
      killAnonymousEventHandler(mmpkg.events.unzipFail)
    end
    mmpkg.events.unzipOK = registerAnonymousEventHandler("sysUnzipDone", mmpkg.unzipmap)
    mmpkg.events.unzipFail = registerAnonymousEventHandler("sysUnzipFail", mmpkg.unzipmap)
    unzipAsync(filename, getMudletHomeDir() .. "/media")
  elseif filename:find("mmpkg.currentversion", 1, true) then
    mmpkg.currentversion = {}
    table.load(filename, mmpkg.currentversion)
    mmpkg.currentversion = table.concat(mmpkg.currentversion)
    os.remove(filename)
    mmpkg.checkversion(mmpkg.conf.autodl)
  elseif filename:find(mmpkg.currentversion, 1, true) then
    uninstallPackage(mmpkg.packagename)
    installPackage(filename)
    os.remove(filename)
    cecho("\n<blue:white>Update installed, please restart Mudlet for updates to take effect.")
  end
end

function mmpkg.updateMap()
  if mmpkg.downloadconfirmed then
    if mmpkg.downloadtimer then
      killTimer(mmpkg.downloadtimer)
    end
    mmpkg.downloadconfirmed = nil
    cecho(
      "\n<white>Downloading the latest map: <gray>https://github.com/breakone9r/mmpkg/raw/master/mm_map.zip\n"
    )
    local saveto = getMudletHomeDir() .. "/tmp/mm_map.zip"
    local url = "https://github.com/breakone9r/mmpkg/raw/master/mm_map.zip"
    if mmpkg.events.downloadOK then
      killAnonymousEventHandler(mmpkg.events.downloadOK)
    end
    mmpkg.events.downloadOK = registerAnonymousEventHandler("sysDownloadDone", "mmpkg.filedownload")
    if mmpkg.events.downloadFail then
      killAnonymousEventHandler(mmpkg.events.downloadFail)
    end
    mmpkg.events.downloadFail = 
    registerAnonymousEventHandler("sysDownloadError", "mmpkg.filedownload")
    downloadFile(saveto, url)
  else
    cecho(
      "<white>ARE YOU SURE? <cyan>Updating the map will overwrite any existing map you have. Re-run mapper update if you wish to continue."
    )
    mmpkg.downloadconfirmed = true
    if mmpkg.downloadtimer then
      killTimer(mmpkg.downloadtimer)
    end
    mmpkg.downloadtimer = tempTimer(5,
      function()
        cecho("<red:white>Confirmation timed out after 5 seconds!")
        mmpkg.downloadconfirmed = nil
      end
    )
  end
end
