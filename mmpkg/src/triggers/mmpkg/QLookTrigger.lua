mmpkg.QL = {}
mmpkg.QL.searchstring = table.concat(string.split(matches[3], " "), "+")
mmpkg.QL.link = "https://annwn.info/quest/search/?search=quest&keyword=" .. mmpkg.QL.searchstring .. "&sort=questname"
cechoLink(" <cyan>[annwn.info]", [[openWebPage("]] .. mmpkg.QL.link .. [[")]], "Lookup quest on annwn.info", true)
