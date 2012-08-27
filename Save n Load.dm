
mob/proc
	delete_save()
		if(fexists("saves/[ckey(src.Username)].sav"))
			var/savefile/S = new("saves/[ckey(src.Username)].sav")
			del S

		var/savefile/F = new("saves/[ckey(src.Username)].sav")

		F["SC"] << 0
		F["TC"] << null
		F["T1"] << null
		F["T2"] << null
		F["T3"] << null
		F["R1"] << 0
		F["R2"] << 0
		F["E1"] << 0
		F["E2"] << 0
		F["NP"] << 0
		F["patched"] << 1

mob/player/client
	proc
		save_account()
			world << "Saving: [src.Username]"
			var/savefile/F = new("saves/[ckey(src.Username)].sav")
			F["SC"] << 1
			F["TC"] << src.color
			F["T1"] << src.hairstyle
			F["T2"] << src.vanity
			F["T3"] << src.skintone
			F["R1"] << src.rank
			F["R2"] << src.rank_emblem
			F["exp"] << src.exp
			F["maxexp"] << src.maxexp
			F["NP"] << 0
			F["patched"] << 1



mob/new_client
	proc
		load_account()
			if(usr.key == world.host)
				alert(src,"You may enable host-picked options by clicking F4, and pick the map and gamemode with F5 if you have enabled host-picked maps.")
			var/mob/O = src.client.mob
			var/mob/player/client/M = new()
			M.name = src.Username
			M.Username = src.Username
			M.Password = src.Password
			M.ID = src.ID

			top
			if(fexists("saves/[ckey(src.Username)].sav"))
				var/savefile/F = new("saves/[ckey(src.Username)].sav")
				if(F["SC"])
					if(!F["patched"])
						src.delete_save()
						goto top

					F["TC"] >> M.color
					F["T1"] >> M.hairstyle
					F["T2"] >> M.vanity
					F["T3"] >> M.skintone
					F["R1"] >> M.rank
					F["R2"] >> M.rank_emblem
					F["exp"] >> M.exp
					F["maxexp"] >> M.maxexp
					F["NP"] >> M.new_player

				if(!(M.color in color_check))
					M.color = colors[pick(colors)]

			else
				M.color = colors[pick(colors)]
				M.hairstyle = "style1"
				M.vanity = pick("", "bandana1", "eyepatch1", "monical1")
				M.skintone = pick('icons/_BaseW.dmi','icons/_BaseT.dmi','icons/_BaseD.dmi','icons/_BaseB.dmi')
				M.rank = 1
				M.rank_emblem = "¡"
				M.exp = 0
				M.maxexp = 50

			M.generate_icon()
			src.client.mob = M
			del O

mob/player/client
	var/tmp
		hairstyle = ""
		skintone = ""
		vanity = ""
	proc

		generate_icon()
			src.overlays = new/list()
			src.overlays += pre_loaded_icons["[src.color]shirt"]
			src.overlays += pre_loaded_icons["[src.color]sleeve"]
			src.overlays += pre_loaded_icons["pants"]
			src.overlays += pre_loaded_icons["arms"]
			if(src.hairstyle) src.overlays += pre_loaded_icons["[src.hairstyle]"]
			if(src.vanity) src.overlays += pre_loaded_icons["[src.vanity]"]
			if(src.subscriber) src.overlays += pre_loaded_icons["substar"]
			if(src.skintone) src.icon = src.skintone
			src.addname()
