turf
	Entered(atom/movable/a)
		..()
		if(ismob(a))
			for(var/obj/triggys/O in src.contents)
				if(!O||O.trigged) continue
				O.trigger(a)

obj/triggys
	var/tmp
		trigged = 0
		mob/player/client/owner = null
	proc/trigger()
	hazards
		fire
			var/tmp{intensity = 50}
			is_garbage = 1
			layer = TURF_LAYER+2
			icon = 'icons/_Bullets.dmi'
			icon_state = "fire1"
			GC()
				src.loc = null
				garbage.Add(src)
			trigger(var/mob/M)
				if(M)
					if(!M.is_dead)
						if(!M.fire_proof)
							switch(M.rtype)
								if(1,2)
									var/mob/player/P = M
									if(P.gamein)
										P.fire_damage(20, 5, src.owner)
								if(3)
									M.fire_damage(40, 5, src.owner)
		vomit
			var/tmp{intensity = 50}
			is_garbage = 1
			layer = TURF_LAYER+1.9
			icon = 'icons/_Bullets.dmi'
			icon_state = "vomit1"
			pixel_x = -8
			GC()
				src.loc = null
				garbage.Add(src)
			trigger(var/mob/M)
				if(M)
					if(!M.is_dead)
						switch(M.rtype)
							if(1, 2)
								var/mob/player/client/P = M
								if(P.gamein)
									if(!P.frozen)
										P.frozen = 1
										P.health -= 30
										P.client.screen += new /ScreenFX/hurt
										spawn(1)
											P.remove_hurt()
										if(P.health < 1) P.Death()
										spawn(30) if(P) P.frozen = 0
		mine
			var/tmp{intensity = 50}
			is_garbage = 1
			layer = TURF_LAYER+1.9
			icon = 'icons/_Bullets.dmi'
			icon_state = "mine"
			pixel_x = -4
			GC()
				src.loc = null
				garbage.Add(src)
			trigger(var/mob/M)
				if(M)
					if(!M.is_dead)
						switch(M.rtype)
							if(3)
								src.Explode(2, 600, src.owner)
								spawn(10)
									src.GC()
							if(1, 2)
								var/mob/player/P = M
								if(P.gamein)
									P.health -= 600
									P.Death()
									P.medal_check("Oops!")
									src.Explode(2, 600, src.owner)
									spawn(10)
										src.GC()
		BarbedWire
			icon = 'icons/__16x16.dmi'
			icon_state = "barbwire2"
			layer = TURF_LAYER+1.9
			trigger(var/mob/M)
				if(!M.is_dead)
					M.loc = src.loc
					M.frozen = 1
					var/tmp
						timer = 40
					while(timer > 0)
						M.health -= 15
						timer -= 10
						sleep(10)
						if(M.health < 1)
							M.Death()
					timer = 40
					M.frozen = 0
					src.GC()
			GC()
				src.loc = null
				garbage.Add(src)
