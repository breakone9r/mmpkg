local affect = string.trim(matches[2])
if affect == "improved invisibilit" then
    affect = "improved invisibility"
end
mmpkg.doAffect(affect,"on",true)