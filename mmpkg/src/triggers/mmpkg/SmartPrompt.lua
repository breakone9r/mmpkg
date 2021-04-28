--Do nothing if smart-prompt is disabled, or variables not initialized
if not mmpkg.conf.smartprompt or not mmpkg.myAffects then
  return
end
--Copy2decho the hp/sp/st part of the prompt.
local prompt = copy2decho(matches[9])
local search = ""
local away = ""
local tank = ""
if matches[2] ~= "" then
  search = "<yellow>"..matches[2]
end
if matches[4] ~= "" then
  away = "<magenta>[Afk]"
end
if matches[3] ~= "" then
  -- Show the tank if in combat
  tank = copy2decho(matches[3])
end
-- Gag the prompt
deleteLine()
local mailnews = ""
if matches[5] == "[Mail]" then
  mailnews = mailnews.."<red>[Mail]"
end
if matches[6] == "[NEWS]" then
  mailnews = mailnews.."<yellow>[News]"
end
if matches[7] == "[Library]" then
  mailnews = mailnews.."<magenta>[Library]"
end
-- Create our own prompt based on affects, roomflags, and any missing buffs from watchlist
local effects = ""
local missingprompt = ""
local roomflag = roomflag or ""
if mmpkg.myAffects.affects then
  local passdoor, sanc, fireshield, invis, shroud = false, false, false, false, false
  for _, v in pairs(mmpkg.myAffects.affects) do
    if v == "pass door" or v == "wind walk" then
      passdoor = true
    end
    if v == "lightning shroud" then
      shroud = true
    end
    if v == "sanctuary" then
      sanc = true
    end
    if v == "improved invisibility" or v == "invisibility" then
      invis = true
    end
    if v == "fireshield" then
      fireshield = true
    end

  end
  -- keep effects in a standard order.
  if passdoor then
    effects = effects .. "<cyan>*"
  end
  if sanc then
    effects = effects .. "<white>*"
  end
  if fireshield then
    effects = effects .. "<red>*"
  end

  if shroud then
    effects = effects .. "<blue>*"
  end
  if invis then
    effects = effects .. "<green>*"
  end
  wanted = mmpkg.conf.wantedbuffs
  have = mmpkg.myAffects.affects
  if mmpkg.conf.buffwatcher then
    local missing, missingshort = mmpkg.buffwatcher:getMissingBuffs(wanted, have)
    if not table.is_empty(missingshort) then
      local spells = table.concat(missingshort, "' '")
      missingprompt = string.format(" <red>M: <white>'%s'", spells)
    end
  end
end
local roomflags = getRoomUserDataKeys(gmcp.room.info.num)
if matches[8] == "[SAFE]" then
  roomflag = roomflag.."<white>[Safe]"
end
if table.contains(roomflags, "shop") then
  roomflag = roomflag.."<yellow>[Shop]"
end
if table.contains(roomflags, "trainer") then
  roomflag = roomflag.."<blue>[Trainer]"
end
if table.contains(roomflags, "high-regen") then
  roomflag = roomflag.."<cyan>[HiRgn]"
end
if table.contains(roomflags, "low-regen") then
  roomflag = roomflag.."<firebrick>[LoRgn]"
end
if table.contains(roomflags, "no-regen") then
  roomflag = roomflag.."<red>[NoRgn]"
end
if table.contains(roomflags, "no-trap") then
  roomflag = roomflag.."<red>[NoTrap]"
end
if table.contains(roomflags, "player-kill-neutral") then
  roomflag = roomflag.."<red>[NPK]"
end
if table.contains(roomflags, "player-kill-lawful") then
  roomflag = roomflag.."<red>[LPK]"
end
if table.contains(roomflags, "player-kill-chaotic") then
  roomflag = roomflag.."<red>[CPK]"
end
cecho("\n" .. effects .. away ..search .. mailnews .. roomflag)
decho(tank..prompt)
cecho(missingprompt)
echo("\n")
