local newstring
local part2 = string.split(matches[2], " and a ")
local part1 = string.split(part2[1], ", a ")
if part1 and part2[2] then
  newstring = table.concat(part1, ",") .. "," .. part2[2]
else
  newstring = matches[2]
end
local reagents = string.split(newstring, ",")
reagentlist = table.count(reagents)
deleteLine()
cecho("\n<white:blue>Reagents Used:<reset> " .. reagentlist .. "\n")
