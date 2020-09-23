if mmpkg.found ~= true then
  echo("Nothing in any direction.\n\n")
end
mmpkg.found = nil
disableTrigger("ScanDone", 1)
