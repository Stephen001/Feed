/**********************************************
*** MACHINES.DM REWRITEN BY KUMO ON 8/26/12 ***
**********************************************/



		// <--------- Variables and such --------->

obj
	TELEuse
		icon			= 'Teleporter.dmi'
		icon_state	= "use"
		layer		= MOB_LAYER+10



		// <--------- Machines Stuff --------->


Tiles
	Machines

		Teleporter1
			parent_type = /obj

			icon			= 'Teleporter.dmi'
			icon_state	= "off"

			layer 		= TURF_LAYER+1
			pixel_x		= -8
			pixel_y		= -8
			bound_width	= 32
			var/can_use = 0

			Crossed(atom/A)
				if(A.type != /mob/player/client)
					return

				var/mob/player/client/P = A
				if(P.gamein)
					if(src.can_use)
						src.can_use = 0
						P.loc = src.loc
						P.frozen = 1
						P.dir = SOUTH
						src.overlays += /obj/TELEuse

						spawn(15)
							src.overlays -= /obj/TELEuse

						sleep(10)

						for(var/Tiles/Machines/Teleporter2/T in world)
							if(T)
								T.can_use = 0
								T.overlays += /obj/TELEuse

								spawn(10)
									T.overlays -= /obj/TELEuse

								P.loc = T.loc
								P.frozen = 0
								T.icon_state = "off"

								spawn(200)
									T.icon_state = "on"
									T.can_use = 1

						src.icon_state = "off"

						spawn(200)
							src.icon_state = "on"
							src.can_use = 1

		Teleporter2
			parent_type 	= /obj

			icon			= 'Teleporter.dmi'
			icon_state	= "off"

			layer 		= TURF_LAYER+1
			pixel_x		= -8
			pixel_y		= -8
			bound_width	= 32
			var/can_use = 0

			Crossed(atom/A)
				if(A.type != /mob/player/client)
					return

				var/mob/player/client/P = A
				if(P.gamein)
					if(src.can_use)
						src.can_use = 0
						P.loc = src.loc
						P.frozen = 1
						P.dir = SOUTH
						src.overlays += /obj/TELEuse

						spawn(15)
							src.overlays -= /obj/TELEuse

						sleep(10)

						for(var/Tiles/Machines/Teleporter1/T in world)
							if(T)
								T.can_use = 0
								T.overlays += /obj/TELEuse

								spawn(10)
									T.overlays -= /obj/TELEuse

								P.loc = T.loc
								P.frozen = 0
								T.icon_state = "off"

								spawn(200)
									T.icon_state = "on"
									T.can_use = 1

						src.icon_state = "off"

						spawn(200)
							src.icon_state = "on"
							src.can_use = 1