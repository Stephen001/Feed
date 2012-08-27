/******************************************
*** MAIN.DM REWRITEN BY KUMO ON 8/17/12 ***
******************************************/

world
	name 		= "Feed"
	hub			= "Kumorii.Feed"
	hub_password	= "KingFORaDay"

	mob 			= /mob/new_client
	map_format	= TOPDOWN_MAP

	loop_checks 	= 0
	tick_lag		= 0.30
	icon_size		= 16
	view 		= 1
	fps			= 30

	New()
		..()
		MOVEDELAY = 1
		pre_recycle()

		spawn(50)
			start_game()

		update_status()
		preload_icons()
		color_gen_checker()
		Load_Account_Database()

		load_first = 0

		// <------------------- Variables -------------------->

var {

	load_first		= 1
	zombies_killed		= 0
	player_deaths		= 0
	waves_survives		= 0
	afk_timer			= 0

}

client {
	var {

		ChatBox
			chat
			alert
	}
}

mob {
	var {

		subscriber 	= 0
	}
}

		// <----------------- Login Stuff ----------------->
mob
	new_client

		Login()
			..()

			winset(src, null, "main_window.size=480x320;map.icon-size=16;map_title.icon-size=16;main_window.can-resize=false;main_window.is-maximized=false")
			if(src.key == "Gogeta7789" || src.key == "Grundone1")
				var/a = alert(src, "You've been banned from Feed for various reports of unfair play.", "Oops!", "Okay")
				if(a == "Okay")
					del a

			if(src.client.CheckPassport("14c9604f12e30f7c"))
				src.subscriber = 1

			src.interface_reset()

			src.client.screen += new /ScreenFX/fraktureStudios
			sleep(30)
			src.client.screen += new /ScreenFX/fade
			sleep(9)
			for(var/ScreenFX/fraktureStudios/F in src.client.screen)
				del F

			src.client.screen += title_screen
			sleep(9)
			for(var/ScreenFX/fade/K in src.client.screen)
				del K

		Logout()
			..()
			del src



	player/client
		icon = 'icons/_BaseW.dmi'
		icon_state = "base-"

		Login()
			..()

			addDefaultChatBox()
			addDefaultAlertBox()

			src.client.chat.addText("For controls, open the 'Help' menu.", DefaultFont, true)
			world_chat("(+)\[&color=[src.color]][src.name]\[&color=null] Connected.")

			src.create_hud()
			src.hide_unhide_huds(1)
			src.client.screen += buttons

			spawn()
				src.hud()

			spawn()
				src.MovementLoop()

			spawn()
				health_regen()

			src.underlays += new /obj/shadow/player
			players.Add(src)

			if(gameon < 3) // <--- Formerly "if(gameon && gameon < 3)"  I'm pretty sure this is the same thing.
				src << CURRENT_MUSIC
				src.respawn()

			else
				src << MUSIC_WAIT
				src.loc = locate(1,1,1)

		Logout()
			src.save_account()

			if(src in ptracker) // <--- Ololololololol.
				ptracker.Remove(src)
				check_round()

			if(!src.is_dead)
				if(length(ptracker))
					for(var/mob/player/client/M in world)
						if(!M || !M.client || !M.is_dead || M.client.eye != src)
							continue

						var/mob/player/client/E = pick(ptracker)
						if(E)
							M.client.eye = E
			if(src.veto_data)
				del src.veto_data

			players.Remove(src)
			world_chat("(-)\[&color=[src.color]][src.name]\[&color=null] Disconnected.")
			..()
			del src

		// <------------- Misc. --------------->

	Stat()
		stat("CPU:", world.cpu)
		stat("Total zombies:", "[zombie_t_kill]/[zombie_t_spawn]")

mob/player/client
	proc

		addDefaultChatBox()  //width height padding layer
			client.chat = new(client, 242, 84, 2, EFFECTS_LAYER)
			client.chat.setScreenX(1)
			client.chat.setScreenY(19)
			src.client.screen += chat

		addDefaultAlertBox()
			client.alert = new(client, 224, 10, 1, EFFECTS_LAYER)
			client.alert.setScreenX(19)
			client.alert.setScreenY(1)

		ammo_regen()
			if(src.weapon)
				var/items/weapons/W = src.weapon

				if(W.ammo < W.maxammo)
					W.ammo = W.maxammo

		set_scores()
			var previous_kills = world.GetScores(src.name, "Kills")
			if(previous_kills)
				var list/params = params2list(previous_kills)

				if(params["Kills"])
					previous_kills = text2num(params["Kills"])

					if(src.kills > previous_kills)
						var export = list("Kills" = src.kills, "Wave" = src.survived_wave)
						world.SetScores(src.name, list2params(export))

			else
				var exportt = list("Kills" = src.kills, "Wave" = src.survived_wave)
				world.SetScores(src.name, list2params(exportt))
