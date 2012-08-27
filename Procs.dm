/*******************************************
*** PROCS.DM REWRITEN BY KUMO ON 8/26/12 ***  // <--- I only kinda half rewrote this one.. Sorry. D:
*******************************************/


		// <--------- Variables --------->
var {

	DE_DVIEW 		= 3
	VERSION		= "v.2.4.3" // <--- This is the displayed version of the server.
	isserver2 	= 0
}


		// <--------- Procs --------->

proc
	start_game()
		if(hostenabled == 0)
			mappicked = 1
			create_vetos()
		else
			hostcheck()

	hostcheck()
		set background = 1
		var {

			time = 0
		}

		while(time <= 1200 && mappicked == 0)
			sleep(1)
			time += 1

		if(mappicked == 0)
			hostenabled = 0
			create_vetos()

		else
			return

proc
	de_view(var/range = DE_DVIEW, var/atom/A)
		if(A && range > 0)
			if(range > DE_DVIEW)
				range = DE_DVIEW

			var/list/L = list()
			var/sx = (A.x - range)

			if(sx < 1)
				sx = 1

			var/sy = (A.y - range)
			if(sy < 1)
				sy = 1

			var/ex = (A.x + range)
			if(ex > world.maxx)
				ex = world.maxx

			var/ey = (A.y + range)
			if(ey > world.maxy)
				ey = world.maxy

			for(var/turf/T in block(locate(sx, sy, A.z),locate(ex, ey, A.z)))
				if(T && isturf(T))
					L += T
					if(length(T.contents))
						L += T.contents
			return L

	de_sound(var/range = DE_DVIEW, var/atom/A, var/sound/sfile)
		if(sfile)
			for(var/mob/player/client/M in players)
				if(!M||!M.gamein)
					continue
				var/s_dist = get_dist(M, A)
				if(s_dist <= range)
					M << sfile

	update_status()
		var {

			hst 		= world.host
		}

		if(!hst)
			hst = "Unknown"
			if(isOfficial())
				hst = "Official Server"

			else if(isOfficial2())
				hst = "Official Server 2"

		world.status = {"<font size = 1>[hst]</font>]
					<font size = 1>Feed: {[VERSION]}
					<b>Map:</b> [current_map]
					<b>Wave:</b> [wave]"}

		if(gameon)
			world.name = "Feed | Wave: [wave]"
		else
			world.name = "Feed"

	isOfficial()
		if(world.internet_address == "67.210.108.209")
			return 1
		else
			return 0

	isOfficial2()
		if(global.isserver2 == 1)
			return 1
		else
			return 0