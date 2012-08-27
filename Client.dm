/********************************************
*** CLIENT.DM REWRITEN BY KUMO ON 8/21/12 ***
********************************************/

client
	New()
		while(load_first)
			sleep(10)

		..()

	view			= "30x20"

	perspective	= (EYE_PERSPECTIVE | EDGE_PERSPECTIVE)
	control_freak 	= (CONTROL_FREAK_SKIN | CONTROL_FREAK_MACROS)

		// <-------->

	North()
		return 0

	South()
		return 0

	East()
		return 0

	West()
		return 0

	Northeast()
		return 0

	Southeast()
		return 0

	Southwest()
		return 0

	Northwest()
		return 0

	Center()
		return 0