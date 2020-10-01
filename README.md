# mmpkg - A Collection of scripts for mudlet, for use in Materia Magica

## Screenshots:
How it looks inside:
![](https://github.com/breakone9r/mmpkg/raw/master/Screenshot1.png)

How it looks outside:
![](https://github.com/breakone9r/mmpkg/raw/master/Screenshot2.png)


## Below you'll find mostly-up-to-date info on available commands and aliases.

### Available mapper commands:
**mapper help** will show you, in-game, all available commands.

**mapper sign** this will run you to the nearest roadsign. It works from any mapped room in the game.

**mapper goto** this command allows you to input either a room number, or a partial room name, and will in the case of the former, just run you to the room number specified, or in the case of the latter, run you to the closest room to match the partial room name.

**mapper path** will show you a printout of the exits needed to get to the room number, as well as highlight the path in the mapper.

**mapper find** this is to be used to find rooms in your current zone with specific flags or features, all room flags are supported (safe, high-regen, low-regen, etc) as well as shop, trainer, sign.

**mapper where** this can be used to locate rooms where the room name matches the provided option. example: (mapper where audience) will return all rooms with the word audience in the name. This can also be configured to only show rooms in your current area.

**mapper stop** stops any active speedwalks

**mapper clear** clears all highlighted rooms.

**mapper update** this will download and install the latest available maps. This WILL overwrite any areas you may have mapped, as well as any customization you may have done to your local map's layout. Use with care!

**mapper shop** Toggles the current room as a shop. If it's not known as a shop, it's set to one, if it is, then it's set to not a shop any more. This is used in conjunction with mapper find shop to list shops in your area. If you find a shop that isn't listed, you can use this command to fix it.

**mapper trainer** This does the same as the above command, but for trainers.

**Please note that rooms can be set to both shop and trainer, and the room color will be whichever was set last. Also, PK and Safe room colors will always override shop and trainer colors.**

### In addition to the mapper command, there is also mmpkg, which shows/controls configurations. 

**mmpkg** by itself will give you a help screen.

**mmpkg update** will check for, and install the latest version.

**mmpkg pages** will show the pages window if you've closed it.

**mmpkg config** brings up a configuration screen.

**mmpkg sounds** Download and install official Materia Magica soundpack.


### There are also the following aliases set up:
**runeqm** speedwalk to Lord Agrippa in Runic Castle.

**sigqm** same for Lord Vendredi in Sigil.

**nrqm** Lord Vashir in New Rigel.

**xavqm** Lady Undya in Xaventry.

**tellqm** Lord Telleri in Tellerium.

**temqm** Lady Templeton in Templeton.

**keepqm** Lord Maldra in Maldra's Keep.

**These speedwalk aliases will work from virtually anywhere in the game world as long as you can reach the room via roads**

**bw** show - shows spells on your buffwatcher watch list

**bw** add spellname - add spellname to your buffwatcher watch list

**bw** remove spellname - removes spellname on your buffwatcher watch list

**Please note: Do not use quotes when adding 2 or 3 word spell names. Just type them normally.**

### Finally, there's a special alias:
**repos** This alias can be used to reposition, visually, rooms in your map. repos n will find the room to the north of your current location, and move it directly north of your room. same for all the other directions. Keep in mind that this can seriously mangle visual maps in areas where rooms arent necessarily where they appear to be: Example, the lake on Irda Isle, where some rooms are just randomly linked to rooms and even back to themselves.

### Other options include, settable via the mmpkg config window:
**timestamps** can be turned on/off for the chat window

**tabs** can be enabled/disabled for the chat window

**mapper where** can be set to only show rooms in your current zone

**chat logging** can be turned on/off

**Linkify** Will turn almost any web address mentions into a clickable website.

**Scan Helper** Hides all empty scan returns, as well as turning it from "A brief walk" etc into an actual number of rooms away.

**Smart Prompt** Adds some useful info to your prompt: LPK/NPK/CPK, Safe, Shop, Trainer, High and Low regen, plus buffs such as invisibility (green asterisk), pass door or equivalent (cyan asterisk), fire shield (red asterisk), sanctuary (white asterisk) and lightning shroud (blue asterisk)

**BuffWatcher** Adds M: (missing buff) to your SmartPrompt (requires SmartPrompt to be enabled)

If you are missing any of these options, then you're running an outdated package and should update ASAP.

Enjoy!
