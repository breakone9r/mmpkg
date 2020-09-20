local commands = {"add", "show", "remove"}
if matches[2] == "help" or not table.contains(commands, matches[2]) then
  cecho("\n<blue>BuffWatcher!\n")
  cecho("<green>  bw add <spellname>    <white>:<yellow>  Adds <spellname> to the watch list\n")
  cecho("<green>  bw remove <spellname> <white>:<yellow>  Removes <spellname> from the watch list\n")
  cecho("<green>  bw show               <white>:<yellow>  Prints the watch list\n")
elseif matches[2] == "add" then
  mmpkg.buffwatcher:add(matches[3])
elseif matches[2] == "remove" then
  mmpkg.buffwatcher:remove(matches[3])
elseif matches[2] == "show" then
  mmpkg.buffwatcher:show()
end
