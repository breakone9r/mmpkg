local dirs = 0
mmpkg.scans = mmpkg.scans or 0
mmpkg.scanned = true
if mmpkg.scantimer then
  killTimer(mmpkg.scantimer)
end
mmpkg.scantimer = tempTimer(0, function()
    mmpkg.scanned = false
    mmpkg.scans = 0
  end)
if mmpkg.scanned == true then
  for _, _ in pairs(mmpkg.fixExits(gmcp.room.info.exits)) do
    dirs = dirs + 1
  end
end
mmpkg.scans = mmpkg.scans + 1
deleteLine()
if mmpkg.scans >= dirs then
  echo("\nScan Complete: Nothing to see here.\n")
end
