var {

	map_loading = 0
	current_map = "Unknown"
	initial_zombies = 0

	list {
		official_maps 	= newlist(/dmm/streetside,/dmm/theatre,/dmm/evacuate,/dmm/autobahn,/dmm/escapeplan,/dmm/hallowed,/dmm/factory,/dmm/glitch)
		maps_played 	= new/list()

	}
}

dmm
	parent_type = /datum
	var/tmp{name = null;dmm_map = null;option_at = 0;option_is = 0} //option_is = number of zombies the map starts off with.
	streetside
		name = "Streetside"
		dmm_map = 'official_maps/Streetside.dmm'
	evacuate
		name = "Evacuate"
		dmm_map = 'official_maps/Evacuate.dmm'
		option_is = 90
	theatre
		name = "Theatre"
		dmm_map = 'official_maps/Theatre.dmm'
		option_is = 60
	autobahn
		name = "Autobahn"
		dmm_map = 'official_maps/Autobahn.dmm'
		option_is = 150
	escapeplan
		name = "Escape Plan"
		dmm_map = 'official_maps/Escape Plan.dmm'
		option_is = 50
	hallowed
		name = "Hallowed"
		dmm_map = 'official_maps/Hallowed.dmm'
		option_is = 90
	factory
		name = "Factory"
		dmm_map = 'official_maps/Factory.dmm'
		option_is = 90
	glitch
		name = "@§H#%E&¶L=#P+»"
		dmm_map = 'official_maps/@§H#%E&¶L=#P+».dmm'

var/veto_on = 0
var/veto_windows = 0

var/vetos = 0
var/mvetos = 0

voters
	parent_type = /datum
	New()
		mvetos++
		veto_windows++
		..()
	Del()
		veto_windows--
		..()

mob/player/client
	var
		voters/veto_data = null
	verb
		veto()
			set hidden = 1
			if(veto_on)
				if(src.veto_data)
					vetos++
					world_alert("[src] vetoed.", FadeFont, true)
					del(src.veto_data)
					src.veto_data = null
		selectmode()
			set hidden = 1
			if(usr.key != world.host)
				alert(src,"Must be the host to use this feature.")
			if(hostenabled == 0)
				alert(src,"Host picked maps are now enabled")
				hostenabled = 1
			else
				alert(src,"Host picked maps are now disabled")
				hostenabled = 0
		pickmap()
			if(hostenabled == 0) return
			if(mappicked == 1) return
			if(src.key != world.host) return
			mappicked = 1
			host_choice(src)
proc/create_vetos()
	while(length(players) <= 0)
		sleep(10)
	mvetos = 0
	var/voted = 0
	var/dmm/P = null
	again
	var/list/L = list()
	L += official_maps
	for(var/dmm/D in L)
		if((D in maps_played)) L -= D
	if(!length(L)){maps_played = new/list();goto again}
	P = pick(L)
	if(!voted)
		for(var/mob/player/client/M in world)
			if(!M) continue
			M.veto_data = new/voters
		veto_on = 1

		world_chat("\[&color=#C0C0C0]'[P.name]' selected. You have 30 seconds to veto(F1) this map.")
		var/counter = 30
		while(veto_windows && counter > 0)
			counter --
			sleep(10)
		for(var/voters/V in world)
			if(!V) continue
			del(V)
		veto_on = 0
		if(vetos > 0)
			if(vetos > (mvetos/2))
				world_chat("\[&color=#C0C0C0]Map dismissed.")
				maps_played += P
				voted = 1
				vetos = 0
				goto again
			else vetos = 0
	maps_played += P
//	while(length(players) <= 0) sleep(10)           Moved this up there. ^

	Normal(P)
proc/host_choice(mob/H)
	if(H.key != world.host)
		return
	while(length(players) <= 0)
		sleep(10)
	mvetos = 0
	var/voted = 0
	var/ddm = null
	var/dmm/P = null
	again
	var/list/L = list()
	L += official_maps
	if(ddm != null)
		L -= ddm
		ddm = null
	if(H.key == world.host)
		var/MA = input("Choose a map!") in L
		P = MA
		GM = input("Choose a game mode!") in list("Million Mode","Normal","Protect The TeamMate")
	else
		return
	if(!voted)
		for(var/mob/player/client/M in world)
			if(!M) continue
			M.veto_data = new/voters
		veto_on = 1

		world_chat("\[&color=#C0C0C0]'[H] has selected [P.name], with the gamemode: [GM]'. You have 30 seconds to veto(F1) this map.")
		var/counter = 30
		while(veto_windows && counter > 0)
			counter --
			sleep(10)
		for(var/voters/V in world)
			if(!V) continue
			del(V)
		veto_on = 0
		if(vetos > 0)
			if(vetos > (mvetos/2))
				world_chat("\[&color=#C0C0C0]Map dismissed.")
				maps_played += P
				ddm = P
				voted = 1
				vetos = 0
				goto again
			else vetos = 0
	maps_played += P
//	while(length(players) <= 0) sleep(10)           Moved this up there. ^
	if(GM == "Million Mode")
		var/zombieamount = input("Choose the maximum number of zombies on the map at once.") as num
		if(zombieamount > 2000)
			zombieamount = 2000
		max_zombies = zombieamount
		MillionMode(P)
	else if(GM == "Normal");
		Normal(P)
	else if(GM == "Protect The TeamMate")
		ProtectTheTeamMate(P)