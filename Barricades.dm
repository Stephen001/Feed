/************************************************
*** BARRICADES.DM REWRITEN BY KUMO ON 8/21/12 ***
************************************************/

	// <--- The Barricades path/datum is here; it was seperated from the rest awhile back. May be moved into
					//turf.dm at some point.

Tiles
	Barricades
		parent_type 	= /obj  // <--- Since they get pushed around, they must be a movable atom; /obj works best for this situation.
		icon 		= 'icons/__32x32.dmi'
		rtype 		= 45

		var {

			pushing 	// <--- The number of players pushing a barricade.
			need_pushing  // <--- The amount of players that need to be pushing it to move it.
			big 		= 0  // <--- Is it a "big" barricade?
		}

		Cone
			icon_state 	= "cone1"

			layer		= TURF_LAYER+0.6
			density 		= 1
			de_dignore	= 1
			health 		= 30

		Crate
			icon			= 'icons/__new32x32.dmi'
			icon_state 	= "crate1"

			layer		= TURF_LAYER+0.6
			density 		= 1
			de_dignore	= 1
			health 		= 50

			Death()
				src.icon_state 	= "crate1-broken"
				src.density 		= 0

		Crate2
			icon			= 'icons/__new32x32.dmi'
			icon_state 	= "crate2"

			layer		= TURF_LAYER+0.6
			density 		= 1
			de_dignore	= 1
			health 		= 150

			bound_width 	= 32
			bound_height 	= 32

			big			= 1
			need_pushing	= 1

			Death()
				src.icon_state 	= "crate2-broken"
				src.density 		= 0

		Crate3
			icon			= 'icons/__new32x32.dmi'
			icon_state 	= "crate3"

			layer		= TURF_LAYER+0.6
			density 		= 1
			de_dignore	= 1
			health 		= 50

			Death()
				src.icon_state 	= "crate3-broken"
				src.density 		= 0