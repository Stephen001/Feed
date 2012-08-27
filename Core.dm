/************************************
*** REWRITEN BY KUMO SOMETIME AGO ***
************************************/

var {

	gameon 			= 0
	gameover 			= 0
	round 			= 1
	wave 			= 1

	zombie_t_spawn 	= 25
	zombie_t_kill 		= 25
	auto_target 		= 0
	boss 			= null

	max_zombies		= 500
	zombies_alive		= 0

	MOVEDELAY 		= 1

	const {

		RESPAWN_TIME 	= 400
		HITDELAY 		= 10

		}

	list {

		played 		= new/list()
		espawn_zone 	= new/list()
		erise_zone 	= new/list()
		pspawn_zone 	= new/list()
		ptracker 		= new/list()

		}
	}


proc

	get_zombies(var/outbreak) // <--- outbreak; 1 if it's an outbreak.
		var {
			plyrZombie = 1
			spawn_count = 1
			}
		if(length(players) > 1)
			plyrZombie = length(players)/0.45

		spawn_count = round((plyrZombie*(20*wave)+rand(10,15)+initial_zombies)/2)
		if(outbreak)
			spawn_count = spawn_count*2

		return spawn_count

	clean_up()

		current_map = "Unknown"
		zombies_alive = 0


	// <--- Clean all of the lists. --->

		played 		= new/list()
		ptracker 		= new/list()
		espawn_zone 	= new/list()
		erise_zone 	= new/list()
		pspawn_zone 	= new/list()


		for(var/area/A in world) {

			if(!A) continue
			del(A)

			}

		for(var/turf/T in world) {

			if(!T) continue

			for(var/atom/movable/A in T)
				if(!A) continue


				if(A.is_garbage)
					A.GC()
				else
					switch(A.rtype) {

						if(2) {

							var/mob/player/client/M = A
							if(M.gamein) {

								M.Death(1)

								}

							M.restore_vars() // <--- If they're a player, restore their variables. --->

							}
						}
			if(T.z > 1) {

				new/turf(T)

				}
			}

	// <--- Reset some global variables! -->

		world.maxx 		= 30
		world.maxy 		= 30
		world.maxz 		= 1

		gameover 			= 0
		mappicked       = 0
		gameon 			= 0
		wave 			= 1
		zombie_t_spawn 	= 25
		zombie_t_kill 		= 25
		auto_target 		= 0

		update_status()
		players << MUSIC_WAIT

		spawn() {

			start_game()

			}


	check_round()
		if(!gameover) {
			if(GM == "Protect The TeamMate"&&hostenabled == 1&ProtectedPlayer != null)
				for(i = 1,i<length(players)+1,i++)
					if(players[i] == ProtectedPlayer)
						if(dead == 1)
							dead = 0
							gameover = 1
							gameon = 3
							round ++
							world_alert("Protected Player has died.")
							players << SOUND_ALL_PLAYERS_DEAD
							sleep(20)
							world_chat("\[&color=#FF0000]Sending scores to hub..")
							for(var/mob/player/client/M in world)
								if(!M)continue
								M.set_scores()

							spawn()
								clean_up()
			else
				if(length(ptracker) < 1) {

					gameover = 1
					gameon = 3
					round ++

					world_alert("All players are dead.")
					players << SOUND_ALL_PLAYERS_DEAD

					sleep(20)

					world_chat("\[&color=#FF0000]Sending scores to hub..")

					for(var/mob/player/client/M in world)
						if(!M)continue
						M.set_scores()

					spawn()
						clean_up()

				}
		}


	wave_check()
		if(!gameover) {
			if(zombie_t_kill < 1)
				for(var/client/C in world)	// <--- Changed from "for(var/mob/player/client/P in world)" --->
					if(C)
						C.screen += wave_complete
						spawn(15)
							C.screen -= wave_complete


				wave ++ 	// <--- Add to the wave numeral. --->
				players << SOUND_WAVE_COMPLETE
				zombie_t_spawn = get_zombies() // <--- Get the new zombie total.
				zombie_t_kill = zombie_t_spawn


				for(var/mob/player/client/C in world)
					if(!C) continue
					if(C.is_dead)
						C.client.screen -= spectate_stuff
						C.health 		= C.maxhealth
						C.is_dead 	= 0
						C.gamein 		= 1
						C.density 	= 1
						C.unmovable 	= 0
						C.frozen 		= 0
						C.is_hit 		= 0
						C.escape_hit 	= 0
						C.invisibility = 0

						if(C.weapon)
							C.weapon.clip = C.weapon.maxclip
						else
							var/items/weapons/pistol/G = new/items/weapons/pistol
							G.Get(C) // <--- YES, YES.


						if(!(C in ptracker)) ptracker.Add(C)
						C.hide_unhide_huds(0)
						C.client.eye = C
						C.loc = pick(pspawn_zone)


				if(wave == 8) {
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

				}

				if(wave > 5 && !boss) {
					if(prob((wave/2)+length(players)*5))
						world_chat("A large horde is approaching..")
						boss = "outbreak"
						zombie_t_kill = get_zombies(1)
						zombie_t_spawn = zombie_t_kill

				}

				update_status()
				world_chat("\[&color=#FF0000]Wave [wave] will begin in 10 seconds.")
				var/rc = "[round]"
				spawn(200) {
					if(rc == "[round]")
						if(!gameover)
							world_chat("\[&color=#C0C0C0]Wave [wave] beginning.")
							players << SOUND_WAVE_BEGINING
							spawn() spawner(espawn_zone, erise_zone)
				}

		}

	spawner(var/list/L, var/list/R) // <--- L; spawn location near edges. R; Rise locations.
		var/spawned = 0
		if(length(L))
			if(boss == "outbreak") {

				for(var/mob/player/client/P in world)
					if(P.gamein)
						P.client.screen += outbreak
						spawn(30)
							P.client.screen -= outbreak

				world_chat("Outbreak!")
				boss = null

			}

			while(spawned < zombie_t_spawn)
				if(zombies_alive < max_zombies) // <--- If the amount of zombies alive is less than the maximum zombies.
					var/Enemies/Z

					if(prob(10) && wave >= 3) // <--- Crawlers only spawn on waves 3+
						Z = garbage.Grab(/Enemies/crawler)

					else if(prob(6) && wave >= 5) // <--- Pukers & Brutes only spawn on wave 5+
						Z = garbage.Grab(pick(/Enemies/puker,/Enemies/brute))

					else if(prob(0.2) && wave >= 10) // <--- Spectres and Blazes only spawn on wave 10+
						Z = garbage.Grab(/Enemies/spectre)
						if(prob(0.2))
							Z = garbage.Grab(/Enemies/blaze)
					else
						Z = garbage.Grab(/Enemies/zombie)

					if(Z)
						Z.is_dead = 0
						Z.target = null
						Z.health = Z.maxhealth
						Z.health += wave*3+rand(10,15)

						if(wave >= 10)
							Z.speed = 2

						if(R)
							if(Z.type == /Enemies/zombie && prob(25))
								Z.loc = pick(R)
								flick("[Z.icon_state]-rise", Z)
								spawn(20)
									Z.AI()
							else
								Z.loc = pick(L)
								spawn(rand(5,10))
									Z.AI()
						else
							Z.loc = pick(L)
							spawn(rand(5,10))
								Z.AI()
					spawned += 1
					zombies_alive += 1
				sleep(rand(5, 10))