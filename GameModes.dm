//Created 8/12/12 by Kuro
proc
	Normal(var/dmm/P = null)
		map_loading = 1
		var/dmm/D = P.dmm_map
		current_map = "[P.name]"
		world_alert("Loading the map '[P.name]'")
		var/dmm_suite/new_reader = new()
		new_reader.load_map(D)
		Cycle_Music()
		DE_Weather()
		gameon = 1
		map_loading = 0
		update_status()

		if(P.option_at)
			auto_target = 1
		if(P.option_is)
			initial_zombies = P.option_is

		zombie_t_spawn = get_zombies()
		zombie_t_kill = zombie_t_spawn

		for(var/mob/player/client/C in world)
			if(C)
				C.respawn()

		world_chat("\[&color=#FF0000]Wave will begin in 10 seconds.")
		var/rc = "[round]"
		spawn(100)
			if(rc == "[round]")
				if(!gameover)
					world_chat("\[&color=#C0C0C0]Wave beginning.")
					players << SOUND_WAVE_BEGINING
					players << CURRENT_MUSIC
					spawn() spawner(espawn_zone, erise_zone)
	ProtectTheTeamMate(var/dmm/P = null)
		map_loading = 1
		var/dmm/D = P.dmm_map
		current_map = "[P.name]"
		world_alert("Loading the map '[P.name]'")
		var/dmm_suite/new_reader = new()
		new_reader.load_map(D)
		Cycle_Music()
		DE_Weather()
		gameon = 1
		map_loading = 0
		update_status()

		if(P.option_at)
			auto_target = 1
		if(P.option_is)
			initial_zombies = P.option_is

		zombie_t_spawn = get_zombies()
		zombie_t_kill = zombie_t_spawn

		for(var/mob/player/client/C in world)
			if(!C) continue
			C.respawn()
		ProtectedPlayer = pick(players)

		world_chat("Protect [ProtectedPlayer]!");
		world_chat("\[&color=#FF0000]Wave will begin in 10 seconds.")
		var/rc = "[round]"
		spawn(100)
			if(rc == "[round]")
				if(!gameover)
					world_chat("\[&color=#C0C0C0]Wave beginning.")
					players << SOUND_WAVE_BEGINING
					players << CURRENT_MUSIC
					spawn() spawner(espawn_zone, erise_zone)

	MillionMode(var/dmm/P = null)
		map_loading = 1
		var/dmm/D = P.dmm_map
		current_map = "[P.name]"
		world_alert("Loading the map '[P.name]'")
		var/dmm_suite/new_reader = new()
		new_reader.load_map(D)
		Cycle_Music()
		DE_Weather()
		gameon = 1
		map_loading = 0
		update_status()

		if(P.option_at)
			auto_target = 1
		if(P.option_is)
			initial_zombies = 5000

		zombie_t_spawn = 999999
		zombie_t_kill = zombie_t_spawn
		wave = 3
		outbreak = 0

		for(var/mob/player/client/C in world)
			if(!C) continue
			C.respawn()

		world_chat("\[&color=#FF0000]Wave will begin in 10 seconds.")
		var/rc = "[round]"
		spawn(100)
			if(rc == "[round]")
				if(!gameover)
					world_chat("\[&color=#C0C0C0]Wave beginning.")
					players << SOUND_WAVE_BEGINING
					players << CURRENT_MUSIC
					spawn() spawner(espawn_zone, erise_zone)
					world_chat("Teleporters are functioning.")
					for(var/Tiles/Machines/Teleporter1/T1 in world)
						if(T1)
							T1.can_use = 1
							T1.icon_state = "on"
							world<<"Teleporter 1 - ON"

					for(var/Tiles/Machines/Teleporter2/T2 in world)
						if(T2)
							T2.can_use = 1
							T2.icon_state = "on"
							world<<"Teleporter 2 - ON"
