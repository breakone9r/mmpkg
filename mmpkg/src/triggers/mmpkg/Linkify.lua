local site = matches[1]
if string.ends(site, "'") then
  site = site:sub(1, -2)
end
selectString(site, 1)
if not string.starts(string.lower(site), "http") then
  site = "http://" .. string.lower(site)
end
local command = string.format([[openWebPage("%s")]], site)
setUnderline(true)
setLink(command, "Open link in browser.")
resetFormat()
