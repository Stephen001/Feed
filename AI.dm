/*********************************************
 ***  AI Stuff rewrote by Kumo on 8/11/12  ***
*********************************************/


			// <-------------------------------- Variables

var
	const

		CHANCE_DROP = 40

	list
											// <--- This is a list of all the items that can be dropped by enemies.
		drop_powerups = newlist(/items/other_items/revive, \
							/items/other_items/health_pack, \
							/items/secondary_items/molotov,\
							/items/secondary_items/wire,\
							/items/secondary_items/grenade,\
							/items/secondary_items/mine,\
							/items/weapons/shotgun,\
							/items/weapons/pistol,\
							/items/weapons/crossbow,\
							/items/weapons/rifle,\
							/items/weapons/magnum, \
							/items/weapons/burst_rifle, \
							/items/weapons/flamethrower, \
							/items/weapons/grenade_launcher, \
							/items/weapons/auto_shotgun)

mob
	var

		fire_proof = FALSE // <--- False if it can be hurt by fire; True if it's immune to fire.

proc
	calculate_damage(var/atk) // <--- Calculating damage done by enemies!
		atk = round(atk+wave/2)
		if(prob(10)) // <--- Critical Hit!
			atk = atk*2
		return atk

obj
	shadow
		crawler
			icon = 'icons/_Crawler.dmi'
			icon_state = "shadow"
			layer = TURF_LAYER+0.3
		zombie
			icon = 'icons/_Zombie.dmi'
			icon_state = "shadow"
			layer = TURF_LAYER+0.3
		player
			icon = 'icons/_Clothes.dmi'
			icon_state = "shadow"
			layer = TURF_LAYER+0.3


			// <-------------------- Enemy datums ----------------------?


Enemies
	parent_type = /mob
	rtype = 3
	var
		tmp
			atk // <--- The average damage done per attack.
			speed // <--- The ticks between steps.
			points // <--- The amount of points the enemy is worth.   FORMARLY 'score'

			can_check = TRUE // <--- Whether or not the AI is allowed to check for targets.
			mob/player/target // <--- The player that's being targetted.
			lcheck

	proc
		AI()

		get_target()
			if(length(ptracker)) // <---If there are any players actually playing at the time.
				for(var/mob/player/P in ptracker)
					if(!P || !P.gamein || !P.safe_delay || P.z != src.z)
						continue
					if(!src.target || get_dist(src, P) < get_dist(src, src.target) || get_dist(src, P) == get_dist(src, src.target) && prob(50))
						src.target = P

	Bump(var/atom/A)
		..()
		if(A)
			switch(A.rtype)
				if(1, 2)
					if(!A.is_hit)
						A.is_hit = 1
						A.escape_hit = 1
						spawn(HITDELAY)
							if(A)
								A.is_hit = 0
						spawn(HITDELAY/2)
							if(A)
								A.escape_hit = 0

						flick("[src.icon_state]-attack", src)
						var/dmg = calculate_damage(src.atk)

						var/mob/player/client/C = A
						C.client.screen += hurt
						sleep(1)
						C.client.screen -= hurt
						A.health -= dmg

						var/Effects/Blood/O = garbage.Grab(/Effects/Blood) // <--- Is this even in the pre_recycle?
						if(O)
							O.icon_state = "blood[rand(1,5)]"
							O.loc = A.loc
							O.DE_EO()

						if(A.health < 1)
							A.Death()
				if(43)
					if(prob(10))
						step(A, src.dir)
				if(45)
					var/Tiles/Barricades/B = A
					if(B.big)
						if(prob(30))
							B.health -= calculate_damage(src.atk)
							if(B.health < 1)
								B.Death()
					else
						if(prob(20))
							step(B, src.dir)
						else if(prob(20))
							A.health -= calculate_damage(src.atk)
							if(A.health < 1)
								A.Death()
				else
					if(prob(50))
						step_rand(src)

	Death(var/s, var/sa, var/dt = 0)
		if(!src.is_dead)
			src.is_dead = 1
			zombies_alive -= 1

			var/Effects/Corpse/O = garbage.Grab(/Effects/Corpse)
			if(O)
				if(dt)
					O.icon = 'icons/_Gore.dmi'
					O.icon_state = "splatter[pick(1,2)]"

					var/Effects/body_part/B = garbage.Grab(/Effects/body_part)
					if(B)
						B.pixel_x = rand(-4, 4)
						B.pixel_y = rand(-4, 4)
						B.density = 1
						B.icon_state = "[src.icon_state]-torso[pick(list("A", "B"))]"
						B.dir = pick(NORTH, EAST, SOUTH, WEST, NORTHEAST, SOUTHEAST, NORTHWEST, SOUTHWEST)
						B.loc = src.loc
						walk(B, B.dir, 1, 1)
						spawn(rand(3, 10))
							walk(B, 0)
							B.density = 0
						B.DE_EO()

					var/Effects/body_part/H = garbage.Grab(/Effects/body_part)
					if(H)
						H.pixel_x = rand(-4, 4)
						H.pixel_y = rand(-4, 4)
						H.density = 1
						H.icon_state = "[src.icon_state]-head[pick(list("A","B"))]"
						H.dir = pick(NORTH, EAST, WEST, SOUTH, NORTHEAST, SOUTHEAST, NORTHWEST, SOUTHWEST)
						H.loc = src.loc
						walk(H, H.dir, 1, 1)
						spawn(rand(3, 10))
							walk(H, 0)
							H.density = 0
						H.DE_EO()
				else
					O.icon = 'icons/_Zombie_Corpse.dmi'
					O.icon_state = "[src.icon_state]-dead"
					O.layer = TURF_LAYER+pick(0.41, 0.42, 0.43, 0.44, 0.45)
				O.loc = src.loc
				O.DE_EO()

			if(prob(CHANCE_DROP))
				if(!locate(/items) in src.loc)
					var/items/I = pick(drop_powerups)
					if(prob(I.chance))
						new I.type(src.loc)

			src.loc = null
			src.GC()
			zombie_t_kill--
			wave_check()

		// <---------------------------- Enemies

	zombie
		icon = 'icons/_Zombie.dmi'
		health = 80
		maxhealth = 80
		atk = 10
		speed = 3
		points = 1

		is_garbage = 1

		New()
			..()
			src.icon_state = pick("grey","green","purple","white")
			src.underlays += new /obj/shadow/zombie
		GC()
			src.loc = null
			src.is_dead = 1
			src.target = null
			src.can_check = 1
			garbage.Add(src)

	Skeleton	// <----------------------This is a mockup enemy I've been toying with; not complete.
		icon = 'icons/_Zombie.dmi'
		icon_state = "skeleton"
		health = 600
		maxhealth = 600
		atk = 10
		speed = 2

	crawler
		icon = 'icons/_Crawler.dmi'
		health = 50
		maxhealth = 50
		atk = 7
		speed = 1
		points = 1

		is_garbage = 1

		New()
			..()
			src.icon_state = pick(list("white","grey"))
			src.underlays += new /obj/shadow/crawler
		GC()
			src.loc = null
			src.is_dead = 1
			src.target = null
			src.can_check = 1
			garbage.Add(src)

	brute
		icon = 'icons/_Brute.dmi'
		icon_state = "brute"
		health = 400
		maxhealth = 400
		atk = 70
		speed = 4
		points = 5

		is_garbage = 1

		GC()
			src.loc = null
			src.is_dead = 1
			src.target = null
			src.can_check = 1
			garbage.Add(src)

	puker
		icon = 'icons/_Puker.dmi'
		icon_state = "blue"
		health = 80
		maxhealth = 80
		atk = 20 // <--- Irrelevant since the Puler doesn't directly attack.
		speed = 3
		points = 5

		is_garbage = 1

		var/tmp
			special_attack = 0

		New()
			..()
			src.underlays += new /obj/shadow/crawler
		GC()
			src.loc = null
			src.is_dead = 1
			src.target = null
			src.can_check = 1
			src.special_attack = 0
			garbage.Add(src)

		AI()
			if(!gameover)
				if(!src.is_dead)
					var/time = MOVEDELAY
					if(src.can_check)
						src.can_check = 0
						for(var/mob/player/M in ptracker)
							if(M.z == src.z)
								if(!M || !M.gamein) continue
								var/distc = get_dist(src, M)
								if(distc > 8) continue
								if(prob(30)) M << pick(s_growl)
								if(!src.target||distc < get_dist(src, src.target))
									src.target = M
									break
					else
						if(src.lcheck > 2)
							src.lcheck = 0
							src.can_check = 1
						else
							src.lcheck++
					if(!src.target || !src.target.gamein || src.target.z != src.z)
						if(auto_target)
							src.get_target()
							time += rand(5,10)
						else
							time += rand(3,6)
							step_rand(src)
					else
						time += rand(2, 4)
						var/disch = get_dist(src, src.target)
						if(disch <= 6)
							if(!src.special_attack)
								var/turf/T = get_step(src, get_dir(src, src.target))
								if(T)
									if(!T.density)
										var/obj/triggys/hazards/vomit/C = locate(/obj/triggys/hazards/vomit) in T
										if(!C)
											var/obj/triggys/hazards/vomit/V = garbage.Grab(/obj/triggys/hazards/vomit)
											if(V)
												src.special_attack = 1
												spawn(40) src.special_attack = 0
												flick("[src.icon_state]-attack", src)
												V.loc = T
												spawn(rand(200, 400)) V.GC()
						var/ldir = get_dir(src, src.target)
						var/turf/T = get_step(src, ldir)
						if(isturf(T))
							if(prob(25))
								var/atom/C = null
								switch(rand(1,2))
									if(1) C = get_step(src, turn(ldir, 45))
									if(2) C = get_step(src, turn(ldir, -45))
								if(isturf(C)) T = C
							step_towards(src, T)
						else step_towards(src, src.target)
					spawn(time) src.AI()
	spectre
		icon = 'icons/_Spectre.dmi'
		icon_state = "spectre"
		health = 500
		maxhealth = 500
		atk = 5
		speed = 3
		points = 50

		is_garbage = 1

		var/tmp
			special_attack = 0
			run_away = 0

		GC()
			src.loc = null
			src.is_dead = 1
			src.target = null
			src.can_check = 1
			src.run_away = 0
			src.special_attack = 0
			src.density = 1
			src.icon_state = "spectre"
			garbage.Add(src)

		Bump(var/atom/A)
			..()
			if((A != null))
				switch(A.rtype)
					if(1, 2)
						if(!A.is_hit)
							A.is_hit = 1
							A.escape_hit = 1
							spawn(HITDELAY) if(A) A.is_hit = 0
							spawn((HITDELAY/2)) if(A) A.escape_hit = 0
							flick("[src.icon_state]-attack", src)
							if(prob(40))
								A.fire_damage(5, 3)
							else
								var/dmg = calculate_damage(src.atk)
								var/mob/player/client/C = A
								C.client.screen += hurt
								sleep(1)
								C.client.screen -= hurt
								A.health -= dmg
								var/Effects/Blood/O = garbage.Grab(/Effects/Blood)
								if(O){O.icon_state = "blood[rand(1,5)]";O.loc = A.loc;O.DE_EO()}
								if(A.health < 1) A.Death()

					if(43, 45)
						if(prob(10))
							step(A, src.dir)
					else if(prob(50)) step_rand(src)
		AI()
			if(!gameover)
				if(!src.is_dead)
					var/time = MOVEDELAY
					if(!src.target||!src.target.gamein)
						src.run_away = 0
						src.density = 1
						src.icon_state = "spectre"
						src.special_attack = 0
						src.get_target()
						time += rand(5,10)
					else
						time ++
						if(src.run_away)
							src.run_away--
							if(src.run_away <= 0)
								src.run_away = 0
								src.icon_state = "spectre-teleport"
								src.density = 0
								spawn(50) src.special_attack = 0
							else step_away(src, src.target, 30)
						else
							if(!src.special_attack)
								src.special_attack = 1

								var/list/L = list()
								for(var/mob/player/M in ptracker)
									if(!M||!M.gamein) continue
									L += M

								if(length(L))
									src.target = pick(L)
									src.loc = src.target.loc
									src.density = 1
									src.icon_state = "spectre"
									if(prob(40))
										src.Bump(src.target)
									src.run_away = rand(20, 30)
								else src.special_attack = 0

					spawn(time) src.AI()
	blaze
		icon = 'icons/_Blaze.dmi'
		icon_state = "blaze"
		health = 500
		maxhealth = 500
		atk = 20
		speed = 3
		points = 50

		is_garbage = 1
		fire_proof = 1

		var/tmp
			special_attack = 0
			run_away = 0

		GC()
			src.loc = null
			src.is_dead = 1
			src.target = null
			src.can_check = 1
			src.run_away = 0
			src.special_attack = 0
			src.density = 1
			src.icon_state = "blaze"
			garbage.Add(src)

		Bump(var/atom/A)
			..()
			if((A != null))
				switch(A.rtype)
					if(1, 2)
						if(!A.is_hit)
							A.is_hit = 1
							A.escape_hit = 1
							spawn(HITDELAY) if(A) A.is_hit = 0
							spawn((HITDELAY/2)) if(A) A.escape_hit = 0
							flick("[src.icon_state]-attack", src)
							if(prob(40))
								A.fire_damage(5, 3)
							else
								var/dmg = calculate_damage(src.atk)
								var/mob/player/client/C = A
								C.client.screen += hurt
								sleep(1)
								C.client.screen -= hurt
								A.health -= dmg
								var/Effects/Blood/O = garbage.Grab(/Effects/Blood)
								if(O){O.icon_state = "blood[rand(1,5)]";O.loc = A.loc;O.DE_EO()}
								if(A.health < 1) A.Death()

					if(43, 45)
						if(prob(10))
							step(A, src.dir)
					else if(prob(50)) step_rand(src)
		AI()
			if(!gameover)
				if(!src.is_dead)
					step_rand(src)
					var/obj/triggys/hazards/fire/O = garbage.Grab(/obj/triggys/hazards/fire)
					if(O)
						O.pixel_x = rand(-4, 4)
						O.pixel_y = rand(-4, 4)
						O.icon_state = "fire[rand(1,2)]"
						O.loc = src.loc
						spawn(rand(30, 50)) O.GC()
					sleep(rand(1,3))
					src.AI()

	AI()
		if(!gameover)
			if(!src.is_dead)
				if(src.can_check)
					src.can_check = 0
					for(var/mob/player/M in ptracker)
						if(M.z == src.z)
							if(!M||!M.gamein) continue
							var/distc = get_dist(src, M)
							if(distc > 8) continue
							if(prob(50)) M << pick(s_growl)
							if(!src.target||distc < get_dist(src, src.target))

								src.target = M
								break
				else
					if(src.lcheck > 2) {src.lcheck = 0;src.can_check = 1}
					else src.lcheck++
				if(!src.target||!src.target.gamein||src.target.z != src.z)
					if(auto_target)
						src.get_target()
					else
						step_rand(src)
				else
					var/disch = get_dist(src, src.target)
					if(disch <= 1 && src.z == src.target.z)
						src.Bump(src.target)
					else
						var/ldir = get_dir(src, src.target)
						var/turf/T = get_step(src, ldir)
						if(isturf(T))
							if(prob(25))
								var/atom/C = null
								switch(rand(1,2))
									if(1) C = get_step(src, turn(ldir, 45))
									if(2) C = get_step(src, turn(ldir, -45))
								if(isturf(C)) T = C
							step_towards(src, T)
						else step_towards(src, src.target)
				spawn(rand(src.speed, src.speed+2)) src.AI()



/////////////////////////////////////////////////////////////////////////////////////////////////







 /* <--- Needs revamping.


	skulker
		name = "Big bawse"
		is_garbage = 1
		atk = 25
		health = 20000
		maxhealth = 20000
		fire_proof = 1
		score = 500
		icon = 'icons/_Skulker.dmi'
		icon_state = "skulker"
		pixel_x = -14
		var/tmp
			run_away = 0
			run_to = 0
			hide = 0
		GC()
			src.loc = null
			src.is_dead = 1
			src.target = null
			src.can_check = 1
			src.run_away = 0
			src.hide = 0
			src.run_to = 0
			src.density = 1
			src.icon_state = "skulker"
			garbage.Add(src)
		Bump(var/atom/A)
			..()
			if((A != null))
				switch(A.rtype)
					if(1, 2)
						if(!A.is_hit)
							A.is_hit = 1
							A.escape_hit = 1
							spawn(HITDELAY) if(A) A.is_hit = 0
							spawn((HITDELAY/2)) if(A) A.escape_hit = 0
							flick("[src.icon_state]-attack", src)
							if(prob(40))
								A.fire_damage(5, 3)
							else
								var/dmg = rand(src.atk+5,src.atk-5)
								var/mob/player/client/C = A
								C.client.screen += new /ScreenFX/Hurt
								spawn(1)
									C.remove_hurt()
								A.health -= dmg
								var/Effects/blood/O = garbage.Grab(/Effects/blood)
								if(O){O.icon_state = "blood[rand(1,5)]";O.loc = A.loc;O.DE_EO()}
								if(A.health < 1) A.Death()
		AI()
			if(!gameover)
				if(!src.is_dead)
					if(hide)  //If it's hiding, waiting to be hit..
						for(var/mob/player/client/C in oview(2,src))
							if(C && C.gamein)
								src.run_to = 1
								src.hide = 0
								src.target = C
								for(var/Enemies/spyder/S in world)
									if(S) // <-- lolwut?
										S.icon_state = "spyder-vanish"
										spawn(4)
											S.GC()
					if(run_to)
						if(src.target)
							step_towards(src, src.target)
							if(get_dist(src, src.target) == 1 && src.z == src.target.z)
								src.frozen = 1
								sleep(3)
								flick("skulker-attack", src)
								src.frozen = 0
								src.target.client.screen += new /ScreenFX/Hurt
								spawn(1)
									var/mob/player/client/P = src.target
									P.remove_hurt()
								src.target.health -= rand(15,30)
								if(src.target.health < 1)
									src.target.Death()

								src.run_away = 1
								src.run_to = 0
							if(prob(2))
								src.run_to = 0
								src.run_away = 1
						else
							for(var/mob/player/client/P in world)
								if(P && P.gamein && P.z == src.z)
									src.target = P
					if(run_away)
						step_rand(src)
						var/obj/triggys/hazards/fire/O = garbage.Grab(/obj/triggys/hazards/fire)
						if(O)
							O.pixel_x = rand(-4, 4)
							O.pixel_y = rand(-4, 4)
							O.icon_state = "fire[rand(1,2)]"
							O.loc = src.loc
							spawn(rand(30, 50)) O.GC()
						if(prob(5))
							run_away = 0

					if(hide == run_to == run_away == 0) //If none of the above are true
						if(prob(60))
							run_to = 1
							for(var/mob/player/client/O in world)
								if(O)
									src.target = O
						else
							hide = 1
							var/spyders = rand(40,90)
							for(spyders, spyders > 0, spyders--)
								var/Enemies/spyder/S = garbage.Grab(/Enemies/spyder)
								if(S)
									S.is_dead = 0
									S.target = null
									S.health = S.maxhealth
									S.loc = pick(erise_zone)
									flick("spyder-rise", S)
									spawn() S.AI()
									sleep(rand(1,2))





					sleep(1.5)
					src.AI()




		Death(var/s = null, var/sa = null, var/dt = 0)
			if(!src.is_dead)
				src.is_dead = 1
				zombies_alive -= 1

				var/Effects/corpse/O = garbage.Grab(/Effects/corpse)
				if(O)
					if(!dt){O.icon = 'icons/_Zombie_Corpse.dmi';O.icon_state = "[src.icon_state]-dead";O.layer = pick(TURF_LAYER+0.41, TURF_LAYER+0.42, TURF_LAYER+0.43, TURF_LAYER+0.44, TURF_LAYER+0.45)}
					else
						O.icon = 'icons/_Gore.dmi'
						O.icon_state = "splatter"

						var/Effects/body_part/B = garbage.Grab(/Effects/body_part)
						if(B)
							B.pixel_x = rand(-4, 4)
							B.pixel_y = rand(-4, 4)
							B.density = 1
							B.icon_state = "[src.icon_state]-torso[pick(list("A","B"))]"
							B.dir = pick(NORTH,EAST,WEST,SOUTH,NORTHEAST,SOUTHEAST,NORTHWEST,SOUTHWEST)
							B.loc = src.loc
							spawn(rand(3,8))
								walk(B,0)
								B.density = 0
							walk(B,pick(NORTH,EAST,SOUTH,WEST,NORTHEAST,NORTHWEST,SOUTHEAST,SOUTHWEST),1,1)
							B.DE_EO()
						var/Effects/body_part/H = garbage.Grab(/Effects/body_part)
						if(H)
							H.pixel_x = rand(-4, 4)
							H.pixel_y = rand(-4, 4)
							H.density = 1
							H.icon_state = "[src.icon_state]-head[pick(list("A","B"))]"
							H.dir = pick(NORTH,EAST,WEST,SOUTH,NORTHEAST,SOUTHEAST,NORTHWEST,SOUTHWEST)
							H.loc = src.loc
							spawn(rand(3,8))
								walk(H,0)
								H.density = 0
							walk(H,pick(NORTH,EAST,SOUTH,WEST,NORTHEAST,NORTHWEST,SOUTHEAST,SOUTHWEST),1,1)
						H.DE_EO()
					O.loc = src.loc
					O.DE_EO()
				for(var/Enemies/spyder/S in world)
					if(S)
						S.icon_state = "spyder-vanish"
						spawn(4)
							S.GC()
				if(prob(CHANCE_DROP))
					if(!(locate(/items/) in src.loc))
						var/items/I = pick(drop_powerups)
						if(prob(I.chance)) new I.type(src.loc)
				src.loc = null
				src.GC()
				zombie_t_kill--
				wave_check()



	spyder
		name = "Yo, they explode, niqqa"
		is_garbage = 1
		atk = 5
		health = 50
		maxhealth = 50
		score = 3
		icon = 'icons/_Spyder.dmi'
		icon_state = "spyder"
		GC()
			src.loc = null
			src.is_dead = 1
			src.target = null
			src.can_check = 1
			src.density = 1
			src.icon_state = "spyder"
			garbage.Add(src)
		AI()
			if(!gameover)
				if(!src.is_dead)
					for(var/mob/player/client/C in world)
						if(C.gamein)
							if(get_dist(src, C) <= 2)
								src.Death()
					sleep(5)
					src.AI()
		Death()
			if(!src.is_dead)
				src.is_dead = 1
				src.icon_state = "spyder-attack"
				sleep(9)
				for(var/mob/player/client/P in oview(2,src))
					if(P && P.gamein)
						P.health -= 600
						P.Death()
				src.Explode(2, 600)

 */