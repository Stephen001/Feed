obj/huds/layer = MOB_LAYER + 99

mob/player/client
	var/tmp
		last_health = -1
		last_exp = -1
		last_clip = -1
		last_ammo = -1
		last_ZTK = -1
		last_status = -1
		last_rank = -1
		last_kill = -1
		last_secondary = -1
		image/health_bar = null
		image/exp_bar = null
		image/status_hud = null
		image/rank_hud = null
		image/weapon_hud = null
		image/health_Olay = null
		list/hud_tracker = new/list()
		list/uhudclip_tracker = new/list()
		list/uhudsecondary_tracker = new/list()
		list/uhudcpu_tracker = new/list()
		list/uhudkill_tracker = new/list()
		list/uhudzombie_tracker = new/list()
	proc
		hide_unhide_huds(var/i = 0)
			if(length(src.hud_tracker))
				for(var/obj/huds/O in src.hud_tracker)
					if(!O) continue
					if(i) src.client.screen -= O
					else src.client.screen += O
		create_hud()

			var/obj/huds/F = new/obj/huds
			F.name = "Hud"
			F.screen_loc = "1,1"
			var/image/FI = image('icons/_HUDframe.dmi', F, "58", 200)
			src << FI
			src.client.screen += F
			src.hud_tracker += F

			var/obj/huds/Z1 = new/obj/huds
			Z1.name = "Kills"
			Z1.screen_loc = "16:6,20"
			var/image/ZI = image('icons/zombiesleft.dmi', Z1, "kills", 200)
			src << ZI
			src.client.screen += Z1
			src.hud_tracker += Z1

			var/obj/huds/kills = new/obj/huds
			kills.name = "Kills"
			kills.screen_loc = "18,20"  //over 10 down 9
			for(var/c = 1, c <= 5, c ++)
				var/image/I = image('icons/zombiesleft.dmi', kills, "0", 200)
				I.pixel_x = (7 * c)
				src << I
				src.uhudkill_tracker += I
			src.client.screen += kills
			src.hud_tracker += kills

			var/obj/huds/ZT1 = new/obj/huds
			ZT1.name = "Zombies"
			ZT1.screen_loc = "10:3,1"
			var/image/ZTI = image('icons/zombiesleft.dmi', ZT1, "zombiesleft", 200)
			src << ZTI
			src.client.screen += ZT1
			src.hud_tracker += ZT1

			var/obj/huds/ZT2 = new/obj/huds
			ZT2.name = "Zombies Left"
			ZT2.screen_loc = "13:3,1:2"
			for(var/c = 1, c <= 5, c ++)
				var/image/I = image('icons/zombiesleft.dmi', ZT2, "0", 200)
				I.pixel_x = (7 * c)
				src << I
				src.uhudzombie_tracker += I
			src.client.screen += ZT2
			src.hud_tracker += ZT2

			var/obj/huds/H = new/obj/huds
			H.name = "Health"
			H.screen_loc = "1:4,3:10"
			var/image/B = image('icons/_HUDhealth2.dmi', H, "41", 200)
			src.health_bar = B
			src << src.health_bar
			src.client.screen += H
			src.hud_tracker += H

			var/obj/huds/O = new/obj/huds
			O.name = "Experience"
			O.screen_loc = "1:3,3"
			var/image/L = image('icons/_HUDexp2.dmi', O, "41", 200)
			src.exp_bar = L
			src << src.exp_bar
			src.client.screen += O
			src.hud_tracker += O

/*			var/obj/huds/SH = new/obj/huds
			SH.name = "Status"
			SH.screen_loc = "5:7,3:11"
			var/image/SI = image('icons/_HUD.dmi', SH, "status-ok", 200)
			src.status_hud = SI
			src << src.status_hud
			src.client.screen += SH
			src.hud_tracker += SH */

		/*	var/obj/huds/SR = new/obj/huds
			SR.name = "Rank"
			SR.screen_loc = "5:7,3:-2"
			var/image/RI = image('icons/_HUDrank.dmi', SR, "1", 200)
			src.rank_hud = RI
			src << src.rank_hud
			src.client.screen += SR
			src.hud_tracker += SR */

			var/obj/huds/W = new/obj/huds
			W.name = "Weapon"
			W.screen_loc = "1:0,1:0"
			var/image/WI = image(null, W, "10", 200)
			src.weapon_hud = WI
			src << src.weapon_hud
			src.client.screen += W
			src.hud_tracker += W

			var/obj/huds/F2 = new/obj/huds
			F2.name = "Clip"
			F2.screen_loc = "4:2,2:-10"
			for(var/c = 1, c <= 5, c ++)
				var/image/I = image('icons/_Font.dmi', F2, "", 200)
				I.pixel_x = (6 * c)
				I.pixel_y = -12
				src << I
				src.uhudclip_tracker += I
			src.client.screen += F2
			src.hud_tracker += F2

			var/obj/huds/F3 = new/obj/huds
			F3.name = "Secondary"
			F3.screen_loc = "7,1:3"
			for(var/c = 1, c <= 4, c ++)
				var/image/I = image('icons/_Font.dmi', F3, "", 200)
				I.pixel_x = (9 * c)
				I.pixel_y = -16
				src << I
				src.uhudsecondary_tracker += I
			src.client.screen += F3
			src.hud_tracker += F3

		add_hud_letters(var/x, var/xx, var/y, var/yy, var/text = "")
			if(!text) return
			text = lowertext(text)
			var/obj/huds/F = new/obj/huds
			F.name = "[text]"
			F.screen_loc = "[x]:[xx],[y]:[yy]"
			for(var/i = 1, i <= length(text), i ++)
				var/image/I = image('icons/_Font.dmi', F, "", 200)
				I.icon_state = "[copytext(text, i,(i + 1))]"
				I.pixel_x = (7 * i)
				I.pixel_y = 0
				src << I
			src.client.screen += F

		hud()
			//if(src.gameon)
			var/hb = round(src.health / src.maxhealth * 41, 1)
			if(src.last_health != hb)
				src.last_health = hb
				if(src.health_bar)src.health_bar.icon_state = "[hb]"

			var/eb = round(src.exp / src.maxexp * 41, 1)
			if(src.last_exp != eb)
				src.last_exp = eb
				if(src.exp_bar) src.exp_bar.icon_state = "[eb]"

			var/lsu = ""
			var/lsau = ""
			if(src.secondary_selected)
				if(length(src.secondary_items))
					var/items/secondary_items/I = src.secondary_items["[src.secondary_selected]"]
					if(I) {lsu = "[src.secondary_selected][I.ammount]";lsau = "_X[I.ammount]"}
			if(src.last_secondary != lsu)
				src.last_secondary = lsu
				if(src.uhudsecondary_tracker.len)
					for(var/i = 1, i <= src.uhudsecondary_tracker.len, i++)
						var/image/F = src.uhudsecondary_tracker[i]
						if(F)
							switch(i)
								if(1) F.icon_state = "[src.secondary_selected]"
								else F.icon_state = "[copytext(lsau, i,(i + 1))]"

			var/ccu = "--/--"
			if(src.weapon) ccu = "[src.weapon.clip]/[src.weapon.maxclip]"
			if(src.last_clip != ccu)
				src.last_clip = ccu
				if(src.uhudclip_tracker.len)
					var/ut = "[ccu]"
					for(var/i = 1, i <= src.uhudclip_tracker.len, i++)
						var/image/F = src.uhudclip_tracker[i]
						if(F) F.icon_state = "[copytext(ut, i,(i + 1))]"

			if(src.last_kill != src.kills)
				src.last_kill = src.kills
				if(src.uhudkill_tracker.len)
					var/ku = "[src.kills]"
					for(var/i = 1, i <= src.uhudkill_tracker.len, i++)
						var/image/F = src.uhudkill_tracker[i]
						if(F) F.icon_state = "[copytext(ku, i,(i + 1))]"

			if(last_ZTK != zombie_t_kill)
				last_ZTK = zombie_t_kill
				if(src.uhudzombie_tracker.len)
					var/ku = "[zombie_t_kill]"
					for(var/i = 1, i <= src.uhudzombie_tracker.len, i++)
						var/image/F = src.uhudzombie_tracker[i]
						if(F) F.icon_state = "[copytext(ku, i,(i + 1))]"

			var/amu = ""
			if(src.weapon && src.weapon.maxammo) amu = "[round(src.weapon.ammo / src.weapon.maxammo * 10, 1)]"
			if(src.last_ammo != amu)
				src.last_ammo = amu
				if(src.weapon_hud) src.weapon_hud.icon_state = "[amu]"

			spawn(1) src.hud()
