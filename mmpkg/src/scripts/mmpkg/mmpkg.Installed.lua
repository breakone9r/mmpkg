function mmpkg_Installed(_, name)
  mmpkg = mmpkg or {}
  mmpkg.previousRoom = mmpkg.previousRoom or {}
  mmpkg.currentRoom = mmpkg.currentRoom or {}
  mmpkg.previousRoom.ID = mmpkg.previousRoom.ID or {}
  mmpkg.previousRoom.Area = mmpkg.previousRoom.Area or {}
  mmpkg.previousRoom.exits = mmpkg.previousRoom.exits or {}
  mmpkg.currentRoom.ID = mmpkg.currentRoom.ID or {}
  mmpkg.currentRoom.Area = mmpkg.currentRoom.Area or {}
  mmpkg.currentRoom.exits = mmpkg.currentRoom.exits or {}
  mmpkg.mapimg = getMudletHomeDir() .. "/mmpkg/resources/alyria.png"
  mmpkg.ugimp = getMudletHomeDir() .. "/mmpkg/resources/ug.png"
  mmpkg.fpimg = getMudletHomeDir() .. "/mmpkg/resources/fp.png"
  mmpkg.sugimg = getMudletHomeDir() .. "/mmpkg/resources/sug.png"
  mmpkg.laslerimg = getMudletHomeDir() .. "/mmpkg/resources/lasler.png"
  mmpkg.verityimg = getMudletHomeDir() .. "/mmpkg/resources/verity.png"
  mmpkg.social = getMudletHomeDir() .. "/mmpkg/resources/social.png"
  mmpkg.arrowimg = getMudletHomeDir() .. "/mmpkg/resources/arrow.png"
  mmpkg.outsideZones = {"Alyria","Faerie Plane Wilderness","Lasler Valley","Great Alyrian Underground"}
  mmpkg.roadSymbols = {"#","=",":"}
  mmpkg.imapx = mmpkg.imapx or 1400
  mmpkg.startx = mmpkg.startx or 0
  mmpkg.imapy = mmpkg.impay or 1400
  mmpkg.starty = mmpkg.starty or 0
  if name ~= "mmpkg-0.7.7" then
    return
  end
  cecho(
    "<cyan>Please Open your preferences, and go to the 'mapper colors' tab. Then set your link color to black.\n"
  )
  cecho(
    "<cyan>Also set your mapper background color to cyan. These cannot be set via script, and this package expects.\n"
  )
  cecho("<cyan>the mapper to be those colors.\n\n")
  cecho("<green>Welcome to Xozes's script package for Materia Magica.\n\n")
  cecho("<yellow>It is still a work-in-progress, and many things are not yet implemented.\n\n")
  cecho(
    "<white>Useful aliases:\n<yellow>mapper goto <roomid><white>:<green>speedwalk to the specified room#.\n<yellow>mapper where <name of room><white>:<green>attempt to search for a room named <name of room> is a wildcard search.\n"
  )
  cecho(
    "<yellow>mapper help<white>:<green>Shows you the full help text of the mapper command.\n"
  )
  cecho(
    "<yellow>repos <direction><white>:<green>Where <dir> is the short version of any direction. Will reposition the room that exists just to the <dir> of the current room, just in case it gets placed in the wrong area.\n\n"
  )
  cecho(
    "<white> Thank you for trying out my package. If you have problems, look me up in-game, on discord as 'breakone9r#5150', or send me an email to break19@gmail.com."
  )
end
