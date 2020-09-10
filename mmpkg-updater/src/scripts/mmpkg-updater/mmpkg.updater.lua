mmpkg = mmpkg or {}
mmpkg.updates = mmpkg.updates or {}


function mmpkg.updates.checkupdate()
  local saveto = getMudletHomeDir() .. "/mmpkg-updater-1.0.mpackage"
  local url = "https://github.com/breakone9r/mmpkg/raw/master/mmpkg.currentversion"
  if mmpkg.updates.downloads then
    killAnonymousEventHandler(mmpkg.updates.downloads)
  end
  mmpkg.updates.downloads = registerAnonymousEventHandler("sysDownloadDone", "mmpkg.updates.checkversion")
  downloadFile(saveto, url)
end

function mmpkg.updates.getlatestversion(_, filename)
  if not filename:find("mmpkg.currentversion", 1, true) then
    return
  end
  table.load(filename,mmpkg.currentversion)
  mmpkg.currentversion = table.concat(mmpkg.currentversion)
  os.remove(filename)
  mmpkg.updates.checkversion()
end

function mmpkg.updates.checkversion()
  if mmpkg.packagename == mmpkg.currentversion then
    cecho("<green>\nYou're already running the latest version: "..mmpkg.currentversion.."\n")
  else
    cecho("<white>Updated version is: <green>'"..mmpkg.currentversion.."'<white>, but you're still running: '<green>"..mmpkg.packagename.."<white>'\nDownloading update.")
    mmpkg.updates.downupdate()
  end
end

function mmpkg.updates.downupdate()
  local saveto = getMudletHomeDir() .. "/" .. mmpkg.currentversion
  local url = "https://github.com/breakone9r/mmpkg/raw/master/" .. mmpkg.currentversion
  if mmpkg.updates.downloads then
    killAnonymousEventHandler(mmpkg.updates.downloads)
  end
  mmpkg.updates.downloads = registerAnonymousEventHandler("sysDownloadDone", "mmpkg.updates.installupdate")
  downloadFile(saveto, url)
end

function mmpkg.updates.installupdate()
  if not filename:find(mmpkg.currentversion, 1, true) then
    return
  end
  uninstallPackage(mmpkg.packagename)
  installPackage(filename)
  os.remove(filename)
  cecho("\n<blue:white>Update installed, please restart Mudlet for updates to take effect.")
end
