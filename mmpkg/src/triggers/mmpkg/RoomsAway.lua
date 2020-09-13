if matches[3] == "right here" then
  selectString(matches[3], 1)
  replace("one room")
  --cecho(" <blue>[<gray>1<blue>]")
elseif matches[3] == "close by" then
  selectString(matches[3], 1)
  replace("two rooms")
  --cecho(" <blue>[<gray>2<blue>]")
elseif matches[3] == "not far off" then
  selectString(matches[3], 1)
  replace("three rooms")
  --cecho(" <blue>[<gray>3<blue>]")
elseif matches[3] == "a brief walk away" then
  selectString(matches[3], 1)
  replace("four rooms")
  --cecho(" <blue>[<gray>4<blue>]")
elseif matches[3] == "rather far off" then
  selectString(matches[3], 1)
  replace("five or more rooms")
  --cecho(" <blue>[<gray>5+<blue>]")
end
