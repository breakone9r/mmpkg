-- Yes, I know the regex wont return a matches[3] for the second pattern
-- it's 100% intentional due to how doors are scanned.
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
  replace("six or more rooms")
end
