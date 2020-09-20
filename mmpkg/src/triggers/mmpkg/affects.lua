local affect = string.trim(matches[2])
if affect == "improved invisibilit" then
  affect = "improved invisibility"
elseif affect == "endurance of the rhi" then
  affect = "endurance of the rhinoceros"
elseif affect == "physical reinforceme" then
  affect = "physical reinforcement"
end
mmpkg.doAffect(affect, "on", true)
