local shortspell = {
  ["detect illusion"] = "DetIll",
  ["levitation"] = "Lev",
  ["whirlwind"] = "WhrlWnd",
  ["detect magic"] = "DetMag",
  ["haste"] = "Hst",
  ["sanctuary"] = "Sanc",
  ["enhanced strength"] = "EnhStr",
  ["armor"] = "Arm",
  ["pentacle"] = "Pent",
  ["combat blink"] = "ComBlnk",
  ["endurance of the rhinoceros"] = "EndRhi",
  ["physical reinforcement"] = "PhysRe",
  ["fireshield"] = "Fire",
  ["shield"] = "Shld",
  ["improved invisibility"] = "ImpInv",
  ["detect invisibility"] = "DetInv",
  ["shadow armor"] = "ShadArm",
  ["protection from good"] = "ProtGood",
  ["protection from evil"] = "ProtEvil"
}

mmpkg.buffwatcher = mmpkg.buffwatcher or {}
mmpkg.conf.wantedbuffs = mmpkg.conf.wantedbuffs or {}

function mmpkg.buffwatcher:add(spellname)
  if table.contains(shortspell, spellname) then
    table.insert(mmpkg.conf.wantedbuffs, matches[3])
    mmpkg.buffwatcher:show()
  else
    cecho("\n<white:red>BuffWatcher ERROR<white:black>:Unknown buff: "..spellname.."\n")
  end
end

function mmpkg.buffwatcher:remove(spellname)
  if table.contains(mmpkg.conf.wantedbuffs, spellname) then
    table.remove(mmpkg.conf.wantedbuffs, table.index_of(mmpkg.conf.wantedbuffs, spellname))
    mmpkg.buffwatcher:show()
  else
    cecho("\n<white:red>BuffWatcher ERROR<white:black>:Unable to remove: "..spellname.."\n")
  end
end

function mmpkg.buffwatcher:show()
  local bufflist = ""
  if not table.is_empty(mmpkg.conf.wantedbuffs) then
    bufflist = table.concat(mmpkg.conf.wantedbuffs, ", ")
  end
  cecho("\n<blue>BuffWatcher watch list: <white>"..bufflist)
end

function mmpkg.buffwatcher:getNextSpell()
  local missing, _ = mmpkg.buffwatcher:getMissingBuffs(mmpkg.conf.wantedbuffs, mmpkg.myAffects.affects)
  if not table.is_empty(missing) then
    return missing[1]
  else
    return nil
  end
end

function mmpkg.buffwatcher:getMissingBuffs(wanted, have)
  local missing = {}
  local shortmissing = {}
  for _, buffsIwant in pairs(wanted) do
    if not table.contains(have, buffsIwant) then
      table.insert(missing, buffsIwant)
      table.insert(shortmissing, shortspell[buffsIwant])
    end
  end
  return missing, shortmissing
end
