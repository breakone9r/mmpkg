mmpkg.scanned = true
deleteLine()
if mmpkg.scantimer then
  killTimer(mmpkg.scantimer)
end
if mmpkg.scanned == true and mmpkg.found == false then
  mmpkg.scantimer = tempTimer(0,
    function()
      deleteLine()
      echo("\nScan Complete: Nothing to see here.\n")
      send("\n")
    end
  )
end
