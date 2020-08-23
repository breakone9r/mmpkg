function mmpkg_Installed(_, name)
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
