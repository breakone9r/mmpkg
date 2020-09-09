local affect = string.trim(matches[2])
if affect == "improved invisibilit" then
  affect = "improved invisibility"
elseif affect == "endurance of the rhi" then
  affect = "endurance of the rhinoceros"
end
mmpkg.doAffect(affect, "on", true)
