local dirs = 0
local scans = scans or 0
local scanned = scanned or false
for _,_ in pairs(mmpkg.fixExits(gmcp.room.info.exits)) do
  if scanned == true then
    scanned = false
    break
  end
  dirs = dirs + 1
end
scanned = true
scans = scans + 1
if scans == dirs then
  echo("\nScan Complete: Nothing to see here.\n")
  scans = 0
  scanned = false
end
deleteLine()
