/*
	fr = fire rate
	rs = reload speed
	fp = fire power
	clip = magazine capacity
	maxclip = max magazine capacity
	ammo = ammo this gun has
	maxammo = max ammo this gun can hold
	rls = reloads like a shotgun/reloads 1 shell at a time ect...  1 = TRUE 0/null = FALSE
	blois = does this weapon leave a empty shell after its fired? 1 = TRUE 0/null = FALSE
*/


items
	mouse_opacity = 0
	layer = TURF_LAYER+0.6
	rtype = 44
	density = 0
	parent_type = /obj
	var
		chance = 50
		taken = 0
	proc/Get()
	other_items
		proc/Effect()
		icon = 'items/items.dmi'
		health_pack
			icon_state = "health_pack"
			chance = 20
			Effect(var/mob/player/client/M)
				if(M.health < M.maxhealth)
					var/heal_base = round((M.maxhealth / rand(2, 3)))
					M.health += heal_base
					D_damage(M, "[heal_base]", 2)
					if(M.health > M.maxhealth)
						M.health = M.maxhealth
					return 1
		revive
			icon_state = "revive"
			chance = 5
			Effect(var/mob/player/client/M)
				if(!M.has_revive)
					M.has_revive = 1
					M.client.chat.addText("You picked up a revive.", ChatFont, true)
					return 1


		Get(var/mob/player/client/M, var/vc = 0)
			if(M.gamein)
				if(vc)
					if(!(src in oview(1)))
						return
				src.taken = 1
				if(!src.Effect(M)) {src.taken = 0; return}
				del(src)
	secondary_items
		icon = 'items/items.dmi'
		var/tmp
			secondary_slot = null
			ammount = 0
			maxammount = 0
			projectile = null
			no_proj = 0 //Is it a projectile?
		molotov
			chance = 80
			name = "Molotov"
			icon_state = "molotov"
			ammount = 1
			maxammount = 3
			projectile = /Projectiles/molotov
		grenade
			chance = 80
			name = "Grenade"
			icon_state = "grenade"
			ammount = 1
			maxammount = 6
			projectile = /Projectiles/grenade
		mine
			chance = 60
			name = "Mine"
			icon_state = "mine"
			ammount = 1
			maxammount = 14
			projectile = /obj/triggys/hazards/mine
			no_proj = 1
		wire
			chance = 75
			name = "Wire"
			icon = 'icons/__16x16.dmi'
			icon_state = "barbwire1"
			ammount = 1
			maxammount = 4
			projectile = /obj/triggys/hazards/BarbedWire
			no_proj = 1
		Get(var/mob/player/client/M, var/vc = 0)
			if(M.gamein)
				if(vc)
					if(!(src in oview(1)))
						return
				src.taken = 1
				var/items/secondary_items/I = M.secondary_items["[src.name]"]
				if(I)
					if(I.ammount < I.maxammount)
						var/take = (I.maxammount - I.ammount)
						if(src.ammount < take) take = src.ammount
						src.ammount -= take
						I.ammount += take
						if(src.ammount <= 0) del(src)
					src.taken = 0
					return
				src.maxammount = src.maxammount*2
				M.secondary_items["[src.name]"] = src
				src.loc = null
				if(!M.secondary_selected) M.secondary_selected = "[src.name]"

	weapons
		var/tmp
			weapon_type = "projectile"
			fr = 2
			rs = 10
			fp = 100
			rnge = 5
			clip = 0
			maxclip = 0
			ammo = 0
			maxammo = 0
			rls = 0
			projectile = null
			i_state = ""
			icon/hud_icon = null
			blois = null
			dname = ""
			sound/fire_sound
		New()
			..()
			src.ammo = round(src.maxammo/2)
		shotgun
			chance = 60
			clip = 6
			maxclip = 6
			maxammo = 50
			weapon_type = "projectile"
			rls = 1
			fr = 8
			rs = 10
			fp = 150
			icon = 'items/items.dmi'
			icon_state = "shotgun"
			name = "shotgun"
			dname = "Shotgun"
			i_state = "base-shotgun"
			hud_icon = 'hud_weapons/shotgun.dmi'
			projectile = /Projectiles/shotgun_spread
			blois = "emptyshell"
			New()
				..()
				src.fire_sound = SOUND_SHOTGUN
		pistol
			chance = 90
			clip = 8
			maxclip = 8
			maxammo = 80
			weapon_type = "projectile"
			fr = 5
			rls = 1
			rs = 15
			fp = 50
			icon = 'items/items.dmi'
			icon_state = "pistol"
			name = "pistol"
			dname = "Pistol"
			i_state = "base-pistol"
			hud_icon = 'hud_weapons/pistol.dmi'
			projectile = /Projectiles/pistol_bullet
			blois = "emptybullet"
			New()
				..()
				src.fire_sound = SOUND_GUNFIRE1
		crossbow
			chance = 70
			clip = 1
			maxclip = 1
			maxammo = 30
			weapon_type = "projectile"
			rls = 1
			fr = 5
			rs = 20
			fp = 120
			icon = 'items/items.dmi'
			icon_state = "crossbow"
			name = "crossbow"
			dname = "Crossbow"
			i_state = "base-crossbow"
			hud_icon = 'hud_weapons/crossbow.dmi'
			projectile = /Projectiles/bolt
			blois = null
			New()
				..()
				src.fire_sound = SOUND_CROSSBOW
		rifle
			chance = 20
			clip = 50
			maxclip = 50
			maxammo = 200
			weapon_type = "projectile"
			rls = 1
			fr = 2
			rs = 5
			fp = 45
			icon = 'items/items.dmi'
			icon_state = "rifle"
			name = "rifle"
			dname = "Rifle"
			i_state = "base-rifle"
			hud_icon = 'hud_weapons/rifle.dmi'
			projectile = /Projectiles/rifle_bullet
			blois = "emptybullet"
			New()
				..()
				src.fire_sound = SOUND_GUNFIRE1
		burst_rifle
			chance = 30
			clip = 3
			maxclip = 3
			maxammo = 300
			weapon_type = "projectile"
			rls = 3
			fr = 1
			rs = 10
			fp = 52
			icon = 'items/items.dmi'
			icon_state = "burstrifle"
			name = "burstrifle"
			dname = "Burst Rifle"
			i_state = "base-burstrifle"
			hud_icon = 'hud_weapons/burstrifle.dmi'
			projectile = /Projectiles/burst_bullet
			blois = "emptybullet"
			New()
				..()
				src.fire_sound = SOUND_GUNFIRE1
		magnum
			chance = 50
			clip = 6
			maxclip = 6
			maxammo = 35
			weapon_type = "projectile"
			fr = 10
			rs = 7
			fp = 120
			icon = 'items/items.dmi'
			icon_state = "magnum"
			name = "magnum"
			dname = "Magnum"
			i_state = "base-magnum"
			hud_icon = 'hud_weapons/magnum.dmi'
			projectile = /Projectiles/magnum_bullet
			blois = "emptybullet"
			New()
				..()
				src.fire_sound = SOUND_GUNFIRE1
		flamethrower
			chance = 5
			clip = 25
			maxclip = 25
			maxammo = 250
			weapon_type = "projectile"
			rls = 1
			fr = 2
			rs = 6
			fp = 45
			icon = 'items/items.dmi'
			icon_state = "flamethrower"
			name = "flamethrower"
			dname = "Flamethrower"
			i_state = "base-flamethrower"
			hud_icon = 'hud_weapons/flamethrower.dmi'
			projectile = /Projectiles/flamethrower_bullet
			blois = null
			New()
				..()
				src.fire_sound = null
		auto_shotgun
			chance = 20
			clip = 10
			maxclip = 10
			maxammo = 150
			weapon_type = "projectile"
			rls = 1
			fr = 2
			rs = 20
			fp = 150
			icon = 'items/items.dmi'
			icon_state = "autoshotgun"
			name = "auto shotgun"
			dname = "Auto Shotgun"
			i_state = "base-autoshotgun"
			hud_icon = 'hud_weapons/autoshotgun.dmi'
			projectile = /Projectiles/autoshotgun_blast
			blois = "emptyshell"
			New()
				..()
				src.fire_sound = SOUND_SHOTGUN
		grenade_launcher
			chance = 3
			clip = 1
			maxclip = 1
			maxammo = 20
			weapon_type = "projectile"
			rls = 1
			fr = 2
			rs = 9
			fp = 150
			icon = 'items/items.dmi'
			icon_state = "grenadelauncher"
			name = "launcher"
			dname = "Grenade Launcher"
			i_state = "base-launcher"
			hud_icon = 'hud_weapons/grenadelauncher.dmi'
			projectile = /Projectiles/launch_grenade
			blois = "emptyshell"
			New()
				..()
				src.fire_sound = SOUND_SHOTGUN

		Get(var/mob/player/client/M, var/vc = 0)
			if(M.gamein)
				if(vc)
					if(!(src in oview(1)))
						return
				src.taken = 1
				var/items/weapons/W = locate(src.type) in M.contents  //If a weapon of the sdame type is had..
				if(W)
					if(W.ammo < W.maxammo)
						var/take = (W.maxammo - W.ammo)
						if(src.ammo < take) take = src.ammo
						src.ammo -= take
						W.ammo += take
						if(!M.ammolay)  //If no ammo+
							M.ammolay = 1
							var/obj/ammoPLUS/AP = new
							AP.maptext = "<center>+[take] [src.name] ammo"
							M.overlays += AP

						//	M.overlays += /obj/ammoPLUS   //add one
							spawn(30)
								M.overlays -= AP
								M.ammolay = 0
								del src   //delete after 3 seconds.
						if(src.ammo <= 0)  //If ammo is gone..
							if(!M.ammolay)  //And no ammp+
								del src   //delete
						src.loc = null
					else
						src.taken = 0
				else
					M.contents += src
					src.maxclip = round(src.maxclip+(maxclip*0.2))
					src.maxammo = round(src.maxammo+(maxammo*0.2))
					src.clip = src.maxclip
					src.ammo = src.maxammo
					if(!M.weapon)
						M.weapon = src
						M.icon_state = src.i_state
						if(M.weapon_hud) M.weapon_hud.icon = src.hud_icon
	New()
		..()
		spawn(1200)
			if(!src.taken)
				if(isturf(src.loc))
					del(src)
obj
	ammoPLUS
		layer = MOB_LAYER+5
		pixel_y = 32
		pixel_x = -36
		maptext_width = 96
		maptext = "Ammo+"

mob/player/client/var
	ammolay = 0 //Is the ammo+ overlay on the client?