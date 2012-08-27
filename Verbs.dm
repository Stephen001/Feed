/*******************************************
*** VERBS.DM REWRITEN BY KUMO ON 8/15/12 ***
*******************************************/

var {

	reload_Olay = new /obj/reload // <--- The reloading overlay.
}

obj
	reload
		icon = 'icons/_HUD.dmi'
		icon_state = "reloading"
		pixel_x = 5
		pixel_y = 8


mob/player/client
	var {

		reloading = false // <--- Are they reloading?

	}

	proc

		cycle_primary_proc()
			if(src.gamein)
				if(length(src.contents))
					if(!src.weapon)
						if(!src.wait_delay)
							src.wait_delay = true
							spawn(10)
								src.wait_delay = false
							src.weapon = src.contents[1]

					else
						if(length(src.contents) > 1)
							if(!src.wait_delay && !src.reloading)
								src.wait_delay = 1
								spawn(10)
									src.wait_delay = 0

								var/items/I = src.contents[1]
								if(I)
									src.contents -= I
									src.contents += I
									src.weapon = src.contents[1]
									src.icon_state = src.weapon.i_state
									if(src.weapon_hud)
										src.weapon_hud.icon = src.weapon.hud_icon
	verb
		attack()
			set hidden = 1
			if(!gameover)
				if(src.gamein)
					if(src.weapon)
						var/items/weapons/W = src.weapon
						if(!src.escape_hit)
							if(src.weapon.clip > 0)
								if(!src.wait_delay && !src.reloading)
									src.wait_delay = 1
									W.clip--

									flick("base-[W.name]-attack", src)
									de_sound(30, src.loc, W.fire_sound)

									spawn(W.fr)
										src.wait_delay = 0

									var/Projectiles/O = garbage.Grab(W.projectile)
									if(O)
										O.dir = src.dir
										O.owner = src
										O.damage = rand(W.fp - 8, W.fp + 8)
										if(src.subscriber)
											O.damage += round(O.damage/4)

										O.loc = src.loc
										spawn()
											O.bullet_travel()

									if(W.blois)
										var/Effects/bullet_left_overs/B = garbage.Grab(/Effects/bullet_left_overs)
										if(B)
											B.icon_state = "[W.blois][rand(1,4)]"
											B.loc = src.loc
											B.DE_EO()
							else
								if(src.weapon.ammo)
									src.reload()

		reload()
			set hidden = 0
			if(!gameover)
				if(src.gamein)
					if(src.weapon)
						if(!src.escape_hit)
							if(src.weapon.clip < src.weapon.maxclip)
								if(src.weapon.ammo > 0)
									if(!src.reloading)
										src.reloading = 1
										src.overlays += reload_Olay // <--- Reloading overlay..
										var/items/weapons/W = src.weapon
										var/take = W.maxclip
										take -= W.clip
										if(take > W.ammo) take = W.ammo
										if(W.rls)
											var/reload_time = (W.rs / 3)
											for(var/i = 1, i <= take, i++)
												if(!W || !src.gamein || src.escape_hit || (src.weapon != W)) break
												W.clip ++
												W.ammo --
												sleep(reload_time)
										else
											sleep(W.rs)
											if(W && src.gamein && !src.escape_hit)
												if(!(src.weapon != W))
													W.ammo -= take
													W.clip += take
										src.reloading = 0
										src.overlays -= reload_Olay


		say()
			set hidden = 0
			var/t=input("What would you like to say?","World Chat")as text | null
			t = copytext(t,1,120)

			if(length(t) < 2)
				return

			if(usr.ID in global.idmutelist)
				return

			world_chat("[rank_emblem]\[&color=[src.color]][src.name]\[&color=null]: [t]")


		use_secondary()
			set hidden = 0
			if(!gameover)
				if(src.gamein)
					if(src.secondary_selected)
						if(length(src.secondary_items))
							var/items/secondary_items/I = src.secondary_items["[src.secondary_selected]"]
							if(I)
								if(I.no_proj)
									if(!src.wait_delay)
										src.wait_delay = 1
										spawn(6) src.wait_delay = 0
								//		flick("base-[I.icon_state]", src)
										I.ammount--
										spawn(3)
											var/obj/triggys/hazards/M = garbage.Grab(I.projectile)
											if(M)
												M.owner = src
												M.loc = src.loc
												M.icon_state = I.icon_state
											if(I.ammount < 1)
												src.secondary_items -= "[src.secondary_selected]"
												if(length(src.secondary_items) > 0)
													src.secondary_selected = src.secondary_items[1]
												else src.secondary_selected = null
												del(I)

								if(!src.escape_hit)
									if(!src.wait_delay)
										src.wait_delay = 1
										spawn(10) src.wait_delay = 0
										flick("base-[I.icon_state]", src)
										var/dirs = src.dir
										I.ammount--
										spawn(3)
											var/Projectiles/O = garbage.Grab(I.projectile)
											if(O)
												O.dir = dirs
												O.owner = src
												O.loc = src.loc
												spawn() O.bullet_travel()
											if(I.ammount < 1)
												src.secondary_items -= "[src.secondary_selected]"
												if(length(src.secondary_items) > 0)
													src.secondary_selected = src.secondary_items[1]
												else src.secondary_selected = null
												del(I)
		cycle_primary()
			set category = null
			if(src.gamein)
				if(length(src.contents))
					if(!src.weapon)
						if(!src.wait_delay && !src.reloading)
							src.wait_delay = 1
							spawn(10) src.wait_delay = 0
							src.weapon = src.contents[1]
					else
						if(length(src.contents) > 1)
							if(!src.wait_delay && !src.reloading)
								src.wait_delay = 1
								spawn(10) src.wait_delay = 0
								var/items/I = src.contents[1]
								if(I)
									src.contents -= I
									src.contents += I
									src.weapon = src.contents[1]
									src.icon_state = src.weapon.i_state
									if(src.weapon_hud) src.weapon_hud.icon = src.weapon.hud_icon
		cycle_secondary()
			set category = null
			if(src.gamein)
				if(length(src.secondary_items))
					if(!src.secondary_selected)
						if(!src.wait_delay)
							src.wait_delay = 1
							spawn(10) src.wait_delay = 0
							src.secondary_selected = src.secondary_items[1]
					else
						if(length(src.secondary_items) > 1)
							if(!src.wait_delay)
								src.wait_delay = 1
								spawn(10) src.wait_delay = 0
								var/items/I = src.secondary_items["[src.secondary_items[1]]"]
								src.secondary_items -= "[I.name]"
								src.secondary_items["[I.name]"] = I
								src.secondary_selected = src.secondary_items[1]


mob
	var {

		chat_on = 1
		screen_full = 0

		}
	verb
		admin_panel()
			set hidden = 1
			var/verify = input(usr, "Please verify.", "Verify") as text|null
			if(verify == "FeedStaffPass")
				usr.verbs += typesof(/gm/verb)
				winshow(usr, "admin_panel", 1)
		closemainmenu()
			set hidden = 1
			winshow(src, "menuchild", 0)
			usr.client.screen -= MenuBG
			usr.overlays -= 'busy.dmi'
		closetitlemainmenu()
			set hidden = 1
			winshow(src, "menuchild", 0)
			usr.client.screen -= TitleMenuBG
		fullscreen()
			set hidden = 1
			if(!src.screen_full)
				src.screen_full = 1
				winset(src, null, "main_window.size=632x420;map.icon-size=0;map_title.icon-size=0;main_window.can-resize=true")

			else
				src.screen_full = 0
				winset(src, null, "main_window.size=480x320;map.icon-size=16;map_title.icon-size=16;main_window.can-resize=false;main_window.is-maximized=false")




	proc
		chat_buttons(var/i as num)
			if(i)
				for(var/ScreenFX/ToggleChat/K in src.client.screen)
					K.screen_loc = "3:6,20:-3"
				for(var/ScreenFX/NameGreen/L in src.client.screen)
					L.screen_loc = "1:2,20:-3"
				for(var/ScreenFX/NameRed/L in src.client.screen)
					L.screen_loc = "1:3,20:-3"
				for(var/ScreenFX/NameBlue/L in src.client.screen)
					L.screen_loc = "2:4,20:-3"
				for(var/ScreenFX/NamePurple/L in src.client.screen)
					L.screen_loc = "2:5,20:-3"
			else
				for(var/ScreenFX/ToggleChat/K in src.client.screen)
					K.screen_loc = "3:6,14:-3"
				for(var/ScreenFX/NameGreen/L in src.client.screen)
					L.screen_loc = "1:2,14:-3"
				for(var/ScreenFX/NameRed/L in src.client.screen)
					L.screen_loc = "1:3,14:-3"
				for(var/ScreenFX/NameBlue/L in src.client.screen)
					L.screen_loc = "2:4,14:-3"
				for(var/ScreenFX/NamePurple/L in src.client.screen)
					L.screen_loc = "2:5,14:-3"
gm
	parent_type = /obj
	verb
		Shutdown_World()
			set category = "Admin"
			set name = "World Shutdown"
			world.Del()
		World_Reboot()
			set category = "Admin"
			set name = "World Reboot"
			world.Reboot()
		Boot()
			set category = "Admin"
			set name = "Boot"
			var/list/people = list()
			for(var/mob/player/client/C in world)
				if(C == usr) continue
				if(C)
					people += C
			var/mob/player/client/M = input(usr, "Who would you like to boot?", "Boot")as anything in people | null
			if(M)
				world_chat("[M] was booted by [usr].")
				del M
		Hurt_Test()
			set category = "TEST"
			usr.icon += rgb(20,0,0)
		Clear_Scoreboard()
			set category = "Admin"
			if(usr.key == "Kumorii")
				var/A = alert(usr,"Are you sure?","Clear Scoreboard?","Yes","No")
				if(A == "Yes")
					var/keys = world.GetScores(135, "Kills")
					if(keys)
						var/list/params = params2list(keys)
						world<<"<b>Players</b>"
						for(var/i=1, i<params.len, ++i)
							var/player = params[i]
							world<<"[i]. [player]"
						for(var/i=1, i<params.len, ++i)
							var/M = params[i]
							world<<"Clearing [M].."
							world.SetScores(M)

		Float()
			set category = "Admin"
			set name = "Float/Solidify"
			var/list/people = list()
			for(var/mob/player/client/C in world)
				if(C)
					people += C
			var/mob/player/client/M = input(usr, "Who would you like to let float?", "Float")as anything in people | null
			if(M)
				if(M.density)
					world_chat("[M] has been given float by [usr].")
					M.density = 0
				else
					world_chat("[M] was solidified by [usr].")
					M.density = 1

		Official_Server_2()
			set category = "Admin"
			global.isserver2 = 1
