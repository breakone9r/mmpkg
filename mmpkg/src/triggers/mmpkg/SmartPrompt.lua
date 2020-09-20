--Do nothing if smart-prompt is disabled.
if not mmpkg.conf.smartprompt then
  return
end
--Copy2decho the hp/sp/st part of the prompt.
local prompt = copy2decho(matches[4])
-- Gag the prompt
deleteLine()
local mailnews = ""
if matches[2] == "[Mail]" then
  mailnews = mailnews.."<red>[Mail]"
end
if matches[3] == "[News]" then
  mailnews = mailnews.."<yellow>[News]"
end
-- Create our own prompt based on affects, roomflags, and any missing buffs from watchlist
local effects = ""
for _, v in pairs(mmpkg.myAffects.affects) do
  if v == "sanctuary" then
    effects = effects .. "<cyan>*"
  end
  if v == "improved invisibility" or v == "invisibility" then
    effects = effects .. "<blue>*"
  end
  if v == "fireshield" then
    effects = effects .. "<red>*"
  end
end
local roomflag = roomflag or ""
local roomflags = getRoomUserDataKeys(gmcp.room.info.num)
if table.contains(roomflags, "safe") then
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
if table.contains(roomflags, "player-kill-neutral") then
  roomflag = roomflag.."<red>[NPK]"
end
if table.contains(roomflags, "player-kill-lawful") then
  roomflag = roomflag.."<red>[LPK]"
end
if table.contains(roomflags, "player-kill-chaotic") then
  roomflag = "<red>[CPK]"
end
local missingprompt = ""
wanted = mmpkg.conf.wantedbuffs
have = mmpkg.myAffects.affects
if mmpkg.conf.buffwatcher then
  local missing, missingshort = mmpkg.buffwatcher:getMissingBuffs(wanted, have)
  if not table.is_empty(missingshort) then
    local spells = table.concat(missingshort, "' '")
    missingprompt = string.format(" <red>M: <white>'%s'", spells)
  end
end
cecho("\n" .. effects .. mailnews .. roomflag)
decho(prompt)
cecho(missingprompt)
