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
  ["stone skin"] = "StonSkn",
  ["improved invisibility"] = "ImpInv",
  ["detect invisibility"] = "DetInv",
  ["shadow armor"] = "ShadArm",
  ["protection from good"] = "ProtGood",
  ["protection from evil"] = "ProtEvil",
  ["bless"] = "Bles",
  ["force field"] = "ForcFld",
  ["phalanx"] = "Phlx",
  ["spell shield"] = "SpelShld",
  ["wind walk"] = "WndWalk",
  ["mind shield"] = "MndShld",
  ["underwater breathing"] = "UndBreath",
  ["guise of nature"] = "Guise",
  ["ominous"] = "Omni",
  ["sensory enhancement"] = "SensEnh",
  ["necromancers guile"] = "NecGui",
  ["telekinetic shield"] = "TelShld",
  ["ascendance"] = "Ascnd",
  ["concealment"] = "Conceal",
  ["detect truth"] = "DetTru",
  ["demigod visage"] = "Demi",
  ["harden exoskeleton"] = "HrdExo",
  ["mimic"] = "Mmc",
  ["augment aura"] = "AugAra",
  ["camouflage"] = "Camo",
  ["sense life"] = "SensLfe",
  ["lava cloak"] = "LvaClk",
  ["bathe"] = "Bthe",
  ["enlighten"] = "EnLi",
  ["subvocal focus"] = "SubFoc",
  ["holy strike"] = "Holy",
  ["bubble cluster"] = "BblClu",
  ["otolithic growth"] = "OtoGro",
  ["inoculate ignorance"] = "InoIgn",
  ["glacierskin"] = "GlaSki",
  ["mental clarity"] = "MenClr",
  ["spell shield"] = "SplShld",
  ["goliath"] = "Golth",
  ["keen insight"] = "Keen",
  ["beast of burden"] = "Beast",
  ["home on the range"] = "HmRng",
  ["cover of darkness"] = "CovDrk",
  ["infravision"] = "Infra",
  ["elemental shield"] = "EleShld",
  ["rites of solemnity"] = "Rites",
  ["fearless"] = "fearless",
  ["smiting blows"] = "SmitBlo",
  ["desperation"] = "Desp",
  ["battle march"] = "March",
  ["inspirational hymn"] = "InspHym",
  ["rime of the glacierbreaker"] = "Rime",
  ["feign presence"] = "FeiPre",
  ["pense"] = "pnse"
}

mmpkg = mmpkg or {}
mmpkg.buffwatcher = mmpkg.buffwatcher or {}
mmpkg.conf = mmpkg.conf or {}
mmpkg.conf.wantedbuffs = mmpkg.conf.wantedbuffs or {}

function mmpkg.buffwatcher:add(spellname)
  if table.contains(shortspell, spellname) then
    if not table.contains(mmpkg.conf.wantedbuffs, spellname) then
      table.insert(mmpkg.conf.wantedbuffs, matches[3])
    else
      cecho("\n<white:red>BuffWatcher ERROR<white:black>: Already watching: "..spellname.."\n")
    end
    mmpkg.buffwatcher:show()
  else
    cecho("\n<white:red>BuffWatcher ERROR<white:black>: Unknown buff: "..spellname.."\n")
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
