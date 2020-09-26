enableTrigger("ScanDone", 1)
if matches[3] == "right here" then
  selectString(matches[3], 1)
  replace("one room")
elseif matches[3] == "close by" then
  selectString(matches[3], 1)
  replace("two rooms")
elseif matches[3] == "not far off" then
  selectString(matches[3], 1)
  replace("three rooms")
elseif matches[3] == "a brief walk away" then
  selectString(matches[3], 1)
  replace("four rooms")
elseif matches[3] == "rather far off" then
  selectString(matches[3], 1)
  replace("five rooms")
elseif matches[3] == "in the distance" then
  selectString(matches[3], 1)
  replace("six rooms")
elseif matches[3] == "almost out of sight" then
  selectString(matches[3], 1)
  replace("seven or more rooms")
end
mmpkg.found = true
