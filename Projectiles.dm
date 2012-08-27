/*****************************************************
****  PROJECTILES.DM REWRITEN BY KUMO ON 8/14/12  ****
*****************************************************/

atom
	var
	{

		de_dignore = 0 // <--- If true, bullets will ignore the density of said object and continue through them.

	}

proc
	calculate_bullet_damage(var/dmg = 0, var/mob/player/client/owner = null)
		if(dmg && owner)
			var/new_dmg = round(rand((dmg-dmg/2), (dmg+dmg/2)))+20
			new_dmg = new_dmg*owner.rank/2

			if(prob(10)) // <--- CRITICAL HIT!
				new_dmg = new_dmg*2

			return new_dmg
		else
			return 5 // <--- Default to 5 becaue fuck you.


Projectiles
	parent_type 	= /obj
	icon 		= 'icons/_Bullets.dmi'
	layer 		= TURF_LAYER+2

	is_garbage 	= 1

	var/tmp {
		speed 		= 1 // <--- The delay in ticks of each step; lower the number, the faster it moves!
		damage 		= 0 // <--- The average damage that the projectile does.
		max_dist 		= 100 // <--- The maximum distance the projectile can travel before being recycled.

		mob/player/client/owner // <--- The owner of the projectile; i.e. the player who shot it.
		turf/wloc // <--- No clue; possibly/probably drop this.

		}

	GC() // <--- The 'Garbage Collection' proc. This defines how an object is treated if it gets recycled.
		src.max_dist 	= initial(src.max_dist) // <--- Restore the max_dist to what it should be.
		src.damage 	= 0
		src.loc 		= null
		src.owner 	= null

		garbage.Add(src)

	proc
		impact_damage(var/atom/movable/A) // <--- This is called when the projectile bumps into something. FORMERLY DE_D()
			if(A)
				switch(A.rtype)
					if(3) // <--- If it's a zombie..
						var/Enemies/E = A

						E.health -= calculate_bullet_damage(src.damage, src.owner)

						if(prob(60)) // <--- Here is where we drop blood.
							var/Effects/Blood/O = garbage.Grab(/Effects/Blood)
							if(O)
								O.icon_state 	= "blood[rand(1,9)]"
								O.pixel_y 	= rand(-8, 16)
								O.loc 		= E.loc
								O.DE_EO() // <--- Cleanup the blood and recycle!

						if(E.health < 1)
							if(src.owner)
								src.owner.kills += E.points
								src.owner.exp += E.points+E.points/2

							A.Death()
							src.owner.rank_up()
						return 1

					if(43)
						var/obj/enviroment/hazard/barrel/B = A
						if(!B.owner)
							if(src.owner)
								B.owner = src.owner

						B.Death()
						return 1
		tile_check(var/turf/T) // <--- Check if the tile can be entered/passed by a projectile. FORMERLY DE_T
			if(T)
				if(T.x <= 1 || T.x >= world.maxx || T.y <= 1 || T.y >= world.maxy || T.density && !T.de_dignore)
					return 1 // <--- If the above, you cannot pass the tile!

		after_effect() // <--- What happens with the projectile after travelling. FORMERLY DE_A
			src.GC()

		bullet_travel() // <--- How the projectile travels, etc. FORMERLY DE_L
			var
				count 		= src.max_dist
				cancel_tc 	= 0

			while(count > 0) // <--- While the value of count is greater than 0.
				if(gameover)
					src.wloc = null
					return

				var/turf/T = src.loc
				if(src.tile_check(T))
					cancel_tc++
					break

				for(var/atom/movable/A in T)
					if(!A || !A.density || A.is_good_bad || A.de_dignore)
						continue
					src.impact_damage(A)
					cancel_tc++
					break

				if(cancel_tc)
					break

				count--
				if(src.wloc)
					if(src.loc != src.wloc)
						step(src, get_dir(src, src.wloc))
					else
						break
				else
					step(src, src.dir)

				sleep(MOVEDELAY/2 + src.speed)

			src.wloc = null
			src.after_effect()


			// <----------------------------- PROJECTILES ------------------------------->


	shotgun_spread // <--- FORMERLY shotgun_blast
		icon_state 	= "spread"
		speed 		= 0
		max_dist 		= 8


	pistol_bullet
		icon_state 	= "bullet"
		speed 		= 0
		max_dist 		= 40


	magnum_bullet
		icon_state 	= "bullet"
		speed 		= 0
		max_dist 		= 12


	rifle_bullet
		icon_state 	= "bullet"
		speed 		= 0
		max_dist 		= 40


	burst_bullet
		icon_state 	= "bullet"
		speed 		= 0
		max_dist 		= 50


	bolt
		icon_state 	= "bolt"
		speed 		= 0
		max_dist 		= 40


	flamethrower_bullet
		icon_state 	= "fireblast"
		speed 		= 0
		max_dist 		= 8

		impact_damage(var/atom/movable/A)
			if(A)
				switch(A.rtype)
					if(3)
						A.fire_damage(70, 3, src.owner)
						return 1
					if(43)
						var/obj/enviroment/hazard.barrel/B = A
						if(!B.owner)
							if(src.owner)
								B.owner = src.owner
						B.Death()
						return 1

		bullet_travel()
			var
				count 		= src.max_dist
				cancel_tc 	= 0

			while(count > 0) // <--- While the value of count is greater than 0.
				if(gameover)
					src.wloc = null
					return

				var/turf/T = src.loc
				if(src.tile_check(T))
					cancel_tc++
					break

				for(var/atom/movable/A in T)
					if(!A || !A.density || A.is_good_bad || A.de_dignore)
						continue
					src.impact_damage(A)
					cancel_tc++
					break

				if(cancel_tc)
					break

				count--
				if(src.wloc)
					if(src.loc != src.wloc)
						step(src, get_dir(src, src.wloc))
					else
						break
				else
					if(prob(40) && count <= src.max_dist-5)
						var/obj/triggys/hazards/fire/O = garbage.Grab(/obj/triggys/hazards/fire)
						if(O)
							O.pixel_x 	= rand(-4, 4)
							O.pixel_y 	= rand(-4, 4)
							O.icon_state 	= "fire[rand(1,2)]"
							O.loc 		= src.loc
							O.owner 		= src.owner
							spawn(rand(50, 100))
								O.GC()

					step(src, src.dir)

				sleep(MOVEDELAY/2 + src.speed)

			src.wloc = null
			src.after_effect()

		after_effect()
			var/list/F = new/list()

			for(var/turf/T in de_view(2, src))
				if(!T || T.density)
					continue

				for(var/atom/movable/A in T)
					if(!A || !A.density || A.is_dead)
						continue

					switch(A.rtype)
						if(1, 2)
							var/mob/player/P = A
							if(P.gamein)
								P.fire_damage(20, 5, src.owner)

						if(3)
							var/mob/M = A
							M.fire_damage(40, 5, src.owner)

						if(43)
							var/obj/enviroment/hazard/barrel/B = A
							if(!B.owner)
								if(src.owner)
									B.owner = src.owner
							B.fire_damage(20, 5, src.owner, 1)
				F += T

			if(length(F))
				var/ftc = rand(3, 8)

				for(var/i = 1, i <= ftc, i++)
					if(!length(F))
						break

					var/obj/triggys/hazards/fire/O = garbage.Grab(/obj/triggys/hazards/fire)
					if(O)
						O.pixel_x 	= rand(-4, 4)
						O.pixel_y 	= rand(-4, 4)
						O.icon_state 	= "fire[rand(1,2)]"
						var/turf/tp 	= pick(F)
						O.loc 		= tp
						O.owner 		= src.owner

						F -= tp
						spawn(rand(50, 100))
							O.GC()
			src.GC()


	autoshotgun_blast
		icon_state 	= "spread"
		speed 		= 0
		max_dist 		= 5


	molotov
		icon_state 	= "molotov"
		speed 		= 0
		max_dist 		= 7

		after_effect()
			var/list/F = new/list()
			for(var/turf/T in de_view(2, src))
				if(!T||T.density) continue
				for(var/atom/movable/A in T)
					if(!A||!A.density||A.is_dead) continue
					switch(A.rtype)
						if(1,2)
							var/mob/player/P = A
							if(P.gamein)
								P.fire_damage(20, 5, src.owner)
						if(3)
							var/mob/M = A
							M.fire_damage(40, 5, src.owner)
						if(43)
							var/obj/enviroment/hazard/barrel/O = A
							if(!O.owner) if(src.owner) O.owner = src.owner
							O.fire_damage(20, 5, src.owner, 1)
				F += T
			if(length(F))
				var/ftc = rand(8, 16)
				for(var/i = 1, i <= ftc, i++)
					if(!length(F)) break
					var/obj/triggys/hazards/fire/O = garbage.Grab(/obj/triggys/hazards/fire)
					if(O)
						O.pixel_x = rand(-4, 4)
						O.pixel_y = rand(-4, 4)
						O.icon_state = "fire[rand(1,2)]"
						var/turf/tp = pick(F)
						O.loc = tp
						O.owner = src.owner
						F -= tp
						spawn(rand(200, 400)) O.GC()
			src.GC()


	grenade
		icon_state 	= "grenade"
		speed 		= 0
		max_dist 		= 7

		after_effect()
			src.Explode(3, 500, src.owner)


	launch_grenade
		icon_state 	= "launchgrenade"
		speed 		= 0
		max_dist 		= 15

		after_effect()
			src.Explode(3, 500, src.owner)

