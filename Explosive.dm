/***********************************************
*** EXPLOSIVE.DM REWRITEN BY KUMO ON 8/26/12 ***
***********************************************/

		// <--------- Variables and such --------->


var {

	EXPLOSION_OVERLAY		= image (icon = 'icons/_Bullets.dmi', icon_state = "explosion", layer = MOB_LAYER, pixel_x = -8)
}


		// <--------- Procs and stuff --------->

atom
	movable
		proc
			Explode(var/radius = 1,  var/damage = 500,  var/mob/player/client/O)
				src.overlays.Add(EXPLOSION_OVERLAY)
				de_sound(30, src.loc, SOUND_GRENADE)
				src.icon_state = null

				for(var/atom/movable/A in de_view(radius, src))
					if(!A || !A.density || A.is_dead)
						continue

					switch(A.rtype)
						if(3, 43)
							A.health -= damage

							if(A.rtype == 43)
								var/obj/enviroment/hazard/barrel/B = A
								if(!B.owner)
									if(O)
										B.owner = O
							if(A.health < 1)
								if(A.rtype == 3 && O && !O.is_dead)

									O.kills ++
									O.exp ++
									O.rank_up()

								A.Death(, "Exploded", 1)

				spawn(5)
					src.overlays.Cut()
					if(src.rtype == 43)
						return

					if(src.is_garbage)
						src.GC()

					else
						del src

		// <--------- Explosive environment stuff --------->

obj/enviroment/hazard
	barrel
		icon 		= 'icons/_Objects.dmi'
		icon_state 	= "barrel"
		density 		= 1

		layer 		= TURF_LAYER+2

		mouse_opacity	= 0
		glide_size 	= 2

		health		= 50
		maxhealth		= 50
		rtype		= 43

		var {
			mob/player/client/owner = null
			init_loc
		}


		New()
			..()
			src.init_loc = src.loc

		Death()
			if(!src.is_dead)
				src.is_dead 	= 1
				src.density 	= 0
				src.Explode(2, 500, src.owner)

				spawn(1800)
					src.repop()

		proc
			repop()
				src.loc 		= src.init_loc
				src.health 	= src.maxhealth
				src.icon_state = "barrel"
				src.density 	= 1
				src.is_dead 	= 0