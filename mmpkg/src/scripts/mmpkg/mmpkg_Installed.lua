function mmpkg_Installed(_, name)
   if string.starts(name,"mmpkg") then
    resetProfile()
    send("protocol gmcp sendchar",false)
    send("affects",false)
    cecho(
      "<cyan>Please Open your preferences, and go to the 'mapper colors' tab. Then set your link color to black.\n"
    )
    cecho(
      "<cyan>Also set your mapper background color to cyan. These cannot be set via script, and this package expects.\n"
    )
    cecho("<cyan>the mapper to be those colors.\n\n")
    cecho("<green>Welcome to Xozes's script package for Materia Magica.\n\n")
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
    cecho(
      "<white> If you need an updated map of known areas, you can run 'mapper update' and download the latest map.\n\n"
    )
    local signrooms = {
      3534660,
      2332064,
      1547405,
      2356549,
      2669134,
      3304508,
      2000381,
      3887978,
      2308240,
      3684102,
      2309054,
      2809518,
      3765964,
      3831487,
      1779457,
      2638058,
      2112538,
      1960870,
      2066541,
      1862175,
      2620937,
      3881069,
      2761226,
      1583861,
      2105636,
      2358832,
      2377105,
      3923434,
      1788665,
      3710799,
      3710795,
      3768246,
      2754336,
      3324605,
      2164192,
      2085131,
      2607016,
      1880584,
      1765641,
      4072040,
      1586161,
      2657736,
      3916564,
      2558911,
      2558910,
      1964016,
      1807085,
      1807082,
      2625535,
      3908670,
      2021064,
      3729129,
      2061957,
      2608161,
      3925733,
      3573738,
      4074340,
      2030293,
      3917873,
      1652800,
      2087430,
      2134317,
      1957223,
      4189387,
      3525388,
      1767941,
      2765834,
      2511593,
      2660032,
      2717472,
      2602424,
      3927078,
      1900988,
      3928049,
      2143525,
      2315135,
      3878769,
      2816440
    }
      for key,room in pairs(signrooms) do
        if roomExists(room) then
          setRoomUserData(room,"sign","true")
        else
          cecho("\n<red:white> ERROR: Missing Rooms detected! No map loaded? Please run mapper update")
          break
        end
      end
  end
end
