/*********************************************
*** Effects.DM REWRITEN BY KUMO ON 8/21/12 ***
*********************************************/

		// <--------- Variables --------->

var {

	FIRE_OVERLAY			= image (icon = 'icons/_Bullets.dmi',icon_state = "fire1", layer = MOB_LAYER,pixel_x = -6)
	LAMP_TH 				= image (icon = 'icons/__64x64.dmi',icon_state = "streetlight2", layer = MOB_LAYER+1)
	NEWSTAND_TH 			= image (icon = 'icons/__32x32.dmi',icon_state = "newsstand2", layer = MOB_LAYER+1)

	const {

		PANTS_LAYER 		= FLOAT_LAYER-5
		SHIRT_LAYER 		= FLOAT_LAYER-4
		VANITY_LAYER 		= FLOAT_LAYER-2
		ARMS_LAYER 		= FLOAT_LAYER-3
		HAIR_LAYER 		= FLOAT_LAYER-1
		SLEEVE_LAYER 		= FLOAT_LAYER-2
	}

	list {

		pre_loaded_icons 	= new/list()
	}
}



		// <--------- Proc --------->


proc
	preload_icons()
		for(var/C in colors)
			var {
				list/de_rgb = hex2rgb(colors[C])
				image/S		= image (icon = 'icons/_Clothes.dmi', icon_state = "shirt", layer = SHIRT_LAYER)
			}

			S.icon *= rgb(de_rgb["r"], de_rgb["g"], de_rgb["b"])
			pre_loaded_icons["[colors[C]]shirt"] = S


			var {
				image/AS 		= image (icon = 'icons/_Arms_Clothes.dmi', layer = SLEEVE_LAYER)
			}

			AS.icon *= rgb(de_rgb["r"], de_rgb["g"], de_rgb["b"])
			pre_loaded_icons["[colors[C]]sleeve"] = AS

			var {
				image/P		= image(icon = 'icons/_Clothes.dmi', icon_state = "pants", layer = PANTS_LAYER)
			}

			pre_loaded_icons["pants"] = P

			var {
				image/A 		= image(icon = 'icons/_Arms.dmi', layer = ARMS_LAYER)
			}

			pre_loaded_icons["arms"] = A

		for(var/Q in list("style1", "style2", "style3", "style4","hat1","hat2","cameo1","style5","style6","hat3","hat4"))
			var {
				image/H 		= image(icon = 'icons/_Hair.dmi', icon_state = "[Q]", layer = HAIR_LAYER)
			}

			if(H.icon_state == "hat2")
				H.pixel_x = -5
				H.pixel_y = 1

			pre_loaded_icons["[Q]"] = H

		for(var/E in list("vanity1","vanity2","vanity3","vanity4","vanity5"))
			var {
				image/V 		= image(icon = 'icons/_Vanity.dmi', icon_state = "[E]", layer = VANITY_LAYER)
			}

			pre_loaded_icons["[E]"] = V

		pre_loaded_icons["substar"] = image(icon = 'icons/_HUD.dmi', icon_state = "substar", layer = FLOAT_LAYER+0.3)



		// <--- Effects Datum --- >


Effects
	parent_type = /obj
	proc
		DE_EO()

	Corpse
		is_garbage 	= 1
		layer 		= TURF_LAYER+0.4

		GC()
			src.loc 			= null
			src.icon 			= null
			src.icon_state 	= null
			garbage.Add(src)

		DE_EO()
			if(src.icon_state == "splatter")
				spawn(200)
					src.GC()
			else
				spawn(30)
					src.GC()

	Blood
		icon 		= 'icons/_Gore.dmi'
		is_garbage 	= 1
		layer		= TURF_LAYER+0.4

		GC()
			src.loc 			= null
			src.icon_state 	= null
			garbage.Add(src)

		DE_EO()
			spawn(300)
				src.GC()

	impact
		icon			= 'icons/_Gore.dmi'
		icon_state	= "impact"

		layer		= MOB_LAYER+2
		pixel_x		= -6

	body_part
		icon			= 'icons/_Gore_parts.dmi'

		is_garbage	= 1
		layer		= TURF_LAYER+0.5

		GC()
			src.loc 			= null
			src.pixel_x 		= 0
			src.pixel_y 		= 0
			src.icon_state 	= null
			garbage.Add(src)

		DE_EO()
			spawn(300)
				src.GC()

	bullet_left_overs
		icon			= 'items/items.dmi'

		is_garbage	= 1
		layer		= TURF_LAYER+0.4

		GC()
			src.loc			= null
			src.icon_state 	= null
			garbage.Add(src)

		DE_EO()
			spawn(600)
				src.GC()

	secondary_locator

		GC()
			src.icon 			= null
			src.icon_state 	= null
			garbage.Add(src)

	de_damage_text
		is_garbage 	= 1
		layer 		= MOB_LAYER + 1
		pixel_x 		= -8

		GC()
			src.loc 			= null
			src.icon 			= null
			src.icon_state 	= null
			src.pixel_x 		= -8
			garbage.Add(src)

		DE_EO()
			spawn(10)
				src.GC()

	spawn_stuff
		enemy_spawn_zone
			New()
				..()
				espawn_zone += src.loc
				del(src)

		erise_zone
			icon = '__16x16.dmi'
			icon_state = "erise"
			New()
				..()
				erise_zone += src.loc
				del(src)

		player_spawn_zone
			New()
				..()
				pspawn_zone += src.loc
				del(src)