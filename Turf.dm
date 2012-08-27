mob/player/client/var/walking = 0
turf
	HIDE
		icon = 'icons/__16x16.dmi'
		icon_state = "void"
		layer = 500
		density = 1
	DENSE
		icon = 'icons/__16x16.dmi'
		icon_state = "void"
		density = 1

Tiles


	Decor
		parent_type = /obj
		SW1
			icon = '__new32x32.dmi'
			icon_state = "sw1"
			layer = TURF_LAYER+0.2
		SW2
			icon = '__new32x32.dmi'
			icon_state = "sw2"
			layer = TURF_LAYER+0.2




	name = ""
	rtype = 100
	parent_type = /turf

	Opacity
		opacity = 1
	Density
		icon = '__16x16.dmi'
		icon_state = "density"
		density = 1
		layer = MOB_LAYER+10
		New()
			..()
			src.icon_state = null
	Bullet_Only
		icon = '__16x16.dmi'
		icon_state = "b-only"
		density = 1
		de_dignore = 1
		layer = MOB_LAYER+10
		New()
			..()
			src.icon_state = null
	Restore_Ammo
		Entered(atom/movable/A)
			..()
			switch(A.rtype)
				if(2)
					var/mob/player/client/P = A
					P.ammo_regen()
	Small
		icon = 'icons/__16x16.dmi'
		Road
			icon = 'icons/__new16x16.dmi'
			Road_Main
				icon_state = "road1"
				New()
					..()
					if(prob(25))
						if(prob(25))
							src.icon_state = pick("road2","road3","road4")
			Road5
				icon_state = "road5"
			Road6
				icon_state = "road6"
			Road7
				icon_state = "road7"
			Road8
				icon_state = "road8"
			Road9
				icon_state = "road9"
			Roadshadow
				icon_state = "roadshadow"
		Grass
			icon_state = "grass1"
			New()
				..()
				if(prob(25))
					src.icon_state = "grass[rand(2,5)]"
		Grass_Edge
			icon = '__16x16.dmi'
			Grass_Top
				icon_state = "grass t"
			Grass_Bottom
				icon_state = "grass b"
			Grass_Left
				icon_state = "grass l"
			Grass_Right
				icon_state = "grass r"
			Grass_BL
				icon_state = "grass bl"
			Grass_BR
				icon_state = "grass br"
			Grass_TL
				icon_state = "grass tl"
			Grass_TR
				icon_state = "grass tr"
		Ditch
			icon_state = "ditch1"
			density = 1
			Ditch2
				icon_state = "ditch2"
			Ditch_pipe
				icon_state = "ditch1pipe"
		DirtyWater
			icon_state = "dirtywater1"
			density = 1
			DW2/icon_state = "dirtywater2"
		Roadline
			icon_state = "roadline1"
			New()
				..()
				if(prob(25))
					if(prob(25))
						src.icon_state = "roadline2"
		RoadlineB
			icon_state = "roadlineB1"
			New()
				..()
				if(prob(25))
					if(prob(25))
						src.icon_state = "roadlineB2"
		Parkingline
			icon_state = "parkingline1"
			New()
				..()
				if(prob(25))
					if(prob(25))
						src.icon_state = "parkingline2"
		Wall_A
			icon_state = "wallA2"
			density = 0
			A2/icon_state = "wallA1"
			A3/icon_state = "wallA3"
			A4/icon_state = "wallA4"
			A5/icon_state = "wallA5"
			A6/icon_state = "wallA6"
			A7/icon_state = "wallA7"
			A9/icon_state = "wallA9"
			A10/icon_state = "wallA10"
			A11/icon_state = "wallA11"
			A12/icon_state = "wallA12"
			A13/icon_state = "wallA13"
			A14/icon_state = "wallA14"
			A15/icon_state = "wallA15"
			A16/icon_state = "wallA16"
			A8
				icon_state = "roof1"
				New()
					..()
					if(prob(25))
						src.icon_state = "roof[rand(1,3)]"
				density = 0
		Streetlight
			icon = 'icons/__new16x16.dmi'
			icon_state = "pole1"
			layer = TURF_LAYER+3
			density = 1
			S2
				icon_state = "pole2"
				layer = MOB_LAYER+9
				density = 0
			S3
				icon_state = "pole3"
				layer = MOB_LAYER+9
				density = 0
			S4
				icon_state = "pole4"
				layer = MOB_LAYER+9
				density = 0
			S5
				icon_state = "pole5"
				layer = MOB_LAYER+9
				density = 0
			SL
				icon = 'icons/__new32x32.dmi'
				icon_state = "stoplight"
				layer = MOB_LAYER+10
				density = 0
		Building
			icon = 'icons/__new16x16.dmi'
			icon_state = "building1"
			density = 1
			B2/icon_state = "building2"
			B3
				icon_state = "building3"
				density = 0
				layer = TURF_LAYER+0.3
			B4
				icon_state = "building4"
				density = 0
				layer = TURF_LAYER+0.3
			B5
				icon_state = "building5"
				density = 0
				layer = TURF_LAYER+0.3
			B6/icon_state = "building6"
			B7/icon_state = "building7"
			Door
				icon = 'icons/__new64x64.dmi'
				icon_state = "door1"
				layer = TURF_LAYER+0.4
			Window1
				icon = 'icons/__new64x64.dmi'
				icon_state = "window1"
				layer = TURF_LAYER+0.2
				W2/icon_state = "window2"
		Wall_B
			icon_state = "wallB2"
			density = 1
			B2/icon_state = "wallB1"
			B3/icon_state = "wallB3"
		Wall_C
			density = 1
			WallC
				icon_state = "wallC1"
				New()
					..()
					if(prob(25))
						if(prob(25))
							src.icon_state = "wallC2"
			W2/icon_state = "wallC3"
			W3/icon_state = "wallC4"
			W4/icon_state = "wallC5"
			W5/icon_state = "wallC6"
			W6/icon_state = "wallC7"
			W7/icon_state = "wallC8"
			W8/icon_state = "wallC9"
			W9/icon_state = "wallC10"
			W10/icon_state = "wallC11"
			W11/icon_state = "wallC12"
			W12/icon_state = "wallC13"
			W13/icon_state = "wallC14"
			W14/icon_state = "wallC15"
		Factory_Wall
			icon_state = "factorywall1"
			density = 0
			F2/icon_state = "factorywall2"
			F3/icon_state = "factorywall3"
			F4/icon_state = "factorywall4"
			F5/icon_state = "factorywall5"
			F6/icon_state = "factorywall6"
			F7/icon_state = "factorywall7"
			F8/icon_state = "factorywall8"
			F9/icon_state = "factorywall9"
			F10/icon_state = "factorywall10"
			F11/icon_state = "factorywall11"
			F12/icon_state = "factorywall12"
			F13/icon_state = "factorywall13"
			F14/icon_state = "factorywall14"
			F15/icon_state = "factorywall15"
			F16/icon_state = "factorywall16"
			F17/icon_state = "factorywall17"
			F18/icon_state = "factorywall18"
			F19/icon_state = "factorywall19"
			F20/icon_state = "factorywall20"
			F21/icon_state = "factorywall21"
			F22/icon_state = "factorywall22"
			F23/icon_state = "factorywall23"
			F24/icon_state = "factorywall24"
			F25/icon_state = "factorywall25"
			F26/icon_state = "factorywall26"
			F27/icon_state = "factorywall27"
			F28/icon_state = "factorywall28"
			F29/icon_state = "factorywall29"
			F30/icon_state = "factorywall30"
			F31/icon_state = "factorywall31"
			F32/icon_state = "factorywall32"
			F33/icon_state = "factorywall33"
			F34/icon_state = "factorywall34"
			F35/icon_state = "factorywall35"
			F36/icon_state = "factorywall36"
			F37/icon_state = "factorywall37"
			F38/icon_state = "factorywall38"
			F39/icon_state = "factorywall39"
			F40/icon_state = "factorywall40"
			Fdrain/icon_state = "factorywall drain"
		Factory_Floor
			icon_state = "factoryfloor1"
			F2/icon_state = "factoryfloor2"
			F3/icon_state = "factoryfloor3"
			F4/icon_state = "factoryfloor4"
			Stairs/icon_state = "stairs"
		Acid
			icon_state = "acid1"
			A2/icon_state = "acid2"
			A3/icon_state = "acid3"
			A4/icon_state = "acid4"
			A5/icon_state = "acid5"
			A6/icon_state = "acid6"
			A7/icon_state = "acid7"
			A8/icon_state = "acid8"
		Bridge
			icon_state = "bridge1"
			density = 0
			B2/icon_state = "bridge2"
			B3/icon_state = "bridge3"
			B4/icon_state = "bridge4"
			B5/icon_state = "bridge5"
			B6/icon_state = "bridge6"
			B7/icon_state = "bridge7"
			B8/icon_state = "bridge8"
			B9/icon_state = "bridge9"
			B10/icon_state = "bridge10"
			B11/icon_state = "bridge11"
			B12/icon_state = "bridge12"
			B13/icon_state = "bridge13"
			Fall_Light/icon_state = "fall light"
		BridgeB
			icon_state = "bridgeB1"
			density = 0
			B2/icon_state = "bridgeB2"
			B3/icon_state = "bridgeB3"
			B4/icon_state = "bridgeB4"
			B5/icon_state = "bridgeB5"
			B6/icon_state = "bridgeB6"
			B7/icon_state = "bridgeB7"
			B8/icon_state = "bridgeB8"
			B9/icon_state = "bridgeB9"
		Woodfloor
			icon_state = "woodfloor1"
			Woodfloor2
				icon_state = "woodfloor2"
			Woodfloor3
				icon_state = "woodfloor3"
		WallC
			icon_state = "wallC1"
			WallC2
				icon_state = "wallC2"
			WallC3
				icon_state = "wallC3"
			WallC4
				icon_state = "wallC4"
		Pipe
			icon = '__new16x16.dmi'
			icon_state = "pipe1"
			layer = MOB_LAYER+3
			Pipe2
				icon_state = "pipe2"
			Pipe3
				icon_state = "pipe3"
			Pipe4
				icon_state = "pipe4"
			Pipe5
				icon_state = "pipe5"
			Pipe6
				icon_state = "pipe6"
			Pipe7
				icon_state = "pipe7"
			Pipe8
				icon_state = "pipe8"
			Pipe9
				icon_state = "pipe9"
			Pipe10
				icon_state = "pipe10"
			Pipe11
				icon_state = "pipe11"
			Pipe12
				icon_state = "pipe12"
		Puddle
			icon = '__new16x16.dmi'
			Puddle_Main
				icon_state = "puddle1"
				New()
					..()
					if(prob(25))
						src.icon_state = "puddle[rand(1,2)]"
			Puddle_Top
				icon_state = "puddle top"
			Puddle_Bottom
				icon_state = "puddle bottom"
			Puddle_Left
				icon_state = "puddle left"
			Puddle_Right
				icon_state = "puddle right"
			Puddle_Top_Right
				icon_state = "puddle top right"
			Puddle_Bottom_Right
				icon_state = "puddle bottom right"
			Puddle_Top_Left
				icon_state = "puddle top left"
			Puddle_Bottom_Left
				icon_state = "puddle bottom left"
		Sand
			icon = '__new16x16.dmi'
			icon_state = "sand1"
			New()
				..()
				if(prob(25))
					src.icon_state = "sand[rand(1,3)]"
		Plank
			icon = '__new16x16.dmi'
			icon_state = "plank1"
			density = 0
			Plank2/icon_state = "plank2"
			Plank3/icon_state = "plank3"
			Plank4/icon_state = "plank4"
			Plank5/icon_state = "plank5"
			Plank6/icon_state = "plank6"
			Plank7/icon_state = "plank7"
			Plank8/icon_state = "plank8"
			Plank9/icon_state = "plank9"
			Plank10/icon_state = "plank10"
		Total_Shadow
			icon = '__new16x16.dmi'
			icon_state = "total shadow"
		Highway
			icon = '__16x16.dmi'
			icon_state = "highway1"
			density = 1
			de_dignore = 1
			Highway2
				icon_state = "highway2"
			Highway3
				icon_state = "highway3"
			Highway4
				icon_state = "highway4"
		Rail
			icon = '__new16x16.dmi'
			icon_state = "top rail"
			density = 1
			de_dignore = 1
			Top_Rail_Right
				icon_state = "top rail3"
			Top_Rail_Left
				icon_state = "top rail2"
			Bottom_Rail
				icon_state = "bottom rail"
			Bottom_Rail_Right
				icon_state = "bottom rail3"
			Bottom_Rail_Left
				icon_state = "bottom rail2"
		Dirt
			icon = '__16x16.dmi'
			density = 0
			Dirt_Main
				icon_state = "dirt1"
				New()
					..()
					if(prob(25))
						src.icon_state = "dirt[rand(2,3)]"
			Dirt_End
				icon_state = "dirt end"
		Mausoleum_Inside
			icon = '__new16x16.dmi'
			Slab
				density = 0
				icon_state = "slab1"
				New()
					..()
					if(prob(25))
						if(prob(25))
							src.icon_state = "slab[rand(1,3)]"
			Old_Stairs
				icon_state = "old stairs"
			Slab_Wall
				icon_state = "slab wall1"
				New()
					..()
					if(prob(25))
						src.icon_state = "slab wall[rand(1,2)]"
			Slab_Wall_Base
				icon_state = "slab wall b"
				density = 1
			Slab_Wall_Top
				icon_state = "slab wall t"
			Slab_Wall_Left
				icon_state = "slab wall l"
			Slab_Wall_Right
				icon_state = "slab wall r"
			Slab_Wall_Back
				icon_state = "slab wall back"
			Slab_Wall_BL
				icon_state = "slab wall bl"
			Slab_Wall_TL
				icon_state = "slab wall tl"
			Slab_Wall_TR
				icon_state = "slab wall tr"
			Slab_Wall_BR
				icon_state = "slab wall br"
			Buried
				icon = '__new32x32.dmi'
				icon_state = "buried"
				layer = TURF_LAYER+0.1
			Empty_Burial
				icon = '__new32x32.dmi'
				icon_state = "empty burial"
				layer = TURF_LAYER+0.1
			Column_Top
				icon = '__new64x64.dmi'
				icon_state = "column t"
				layer = MOB_LAYER+5
			Column_Bottom
				icon = '__new64x64.dmi'
				icon_state = "column b"
				layer = TURF_LAYER+0.3
			Pulley
				icon_state = "pulley"
			Coffin_Top
				icon = '__96x96.dmi'
				icon_state = "coffin t"
				layer = MOB_LAYER+5
			Coffin_Base
				icon = '__96x96.dmi'
				icon_state = "coffin b"
				layer = TURF_LAYER+0.1
			Candle
				icon = 'items.dmi'
				icon_state = "candle1"
				Candle2
					icon_state = "candle2"
				Candle_Set
					icon_state = "candle3"
			Bone
				icon = 'items.dmi'
				icon_state = "bone"
			Bones
				icon = 'items.dmi'
				icon_state = "bones"
			Pentagram
				icon = '__96x96.dmi'
				icon_state = "pentagram"
				layer = TURF_LAYER+0.1
			Dry_Blood
				icon = '__new32x32.dmi'
				icon_state = "dry blood1"
				layer = TURF_LAYER+0.1
				Dry_Blood2
					icon_state = "dry blood2"
				Dry_Blood3
					icon_state = "dry blood3"

		Facility
			Big_Tile
				icon = '__new16x16.dmi'
				icon_state = "big tile1"
			Edge
				icon = '__new16x16.dmi'
				icon_state = "edge"
				density = 1
			faciwall
				icon = '__new16x16.dmi'
				icon_state = "faciwall"
			faciwall_b
				icon = '__new16x16.dmi'
				icon_state = "faciwall b"
			faciwall_t
				icon = '__new16x16.dmi'
				icon_state = "faciwall t"
			faciwall_line
				icon = '__new16x16.dmi'
				icon_state = "faciwall line"
			rail
				icon = '__new16x16.dmi'
				icon_state = "rail"
				density=1
			rail_top
				icon = '__new16x16.dmi'
				icon_state = "rail t"
				layer = MOB_LAYER+3
			rail_top2
				icon = '__new16x16.dmi'
				icon_state = "rail t2"
				layer = MOB_LAYER+3
			Desk_Top
				icon = '__64x64.dmi'
				icon_state = "Desk t"
				layer = MOB_LAYER+3
			Desk_Bottom
				icon = '__64x64.dmi'
				icon_state = "Desk b"
				layer = TURF_LAYER+0.3


	Medium
		icon = 'icons/__32x32.dmi'
		Posters
			layer = TURF_LAYER+0.2
			Biohazard1
				icon_state = "poster-biohazard1"
			Biohazard2
				icon_state = "poster-biohazard2"
			Burned
				icon_state = "poster-burned"
			Ripped
				icon_state = "poster-ripped"
			Rage
				icon_state = "poster-rage"
			Mickemoose
				icon_state = "poster-mickemoose"
		RoadlineA
			icon = 'icons/__new32x32.dmi'
			icon_state = "roadline1"
			layer = TURF_LAYER+0.1
			New()
				..()
				src.icon_state = "roadline[rand(1,5)]"
		RoadlineC
			icon = 'icons/__new32x32.dmi'
			icon_state = "roadline6"
			layer = TURF_LAYER+0.1
			New()
				..()
				src.icon_state = "roadline[rand(6,10)]"
		Machine
			layer = TURF_LAYER+0.1
			icon_state = "machine1"
			M2/icon_state = "machine2"
			M3/icon_state = "machine3"
		Window
			icon_state = "window1"
			layer = TURF_LAYER+0.2
		Bass
			icon_state = "bass1"
			layer = TURF_LAYER+0.3
		Crash
			icon_state = "crash1"
			layer = TURF_LAYER+0.3
		Tom
			icon_state = "tom1"
			layer = TURF_LAYER+0.3
		Guitar
			icon_state = "guitar1"
			layer = TURF_LAYER+0.3
		Wall_Chip
			icon_state = "wallchip1"
			layer = TURF_LAYER+0.2
		Sidewalk
			icon = 'icons/__new32x32.dmi'
			layer = TURF_LAYER+0.1
			Sidewalk1
				icon_state = "sidewalk1"
				New()
					..()
					if(prob(25))
						src.icon_state = "sidewalk[rand(0,1)]"
			Sidewalk2
				icon_state = "sidewalk2"
			Sidewalk3
				icon_state = "sidewalk3"
				New()
					..()
					if(prob(25))
						src.icon_state = "sidewalk[rand(3,4)]"
			New()
				..()
				if(prob(10))
					src.overlays += pick(/Tiles/Decor/SW1, /Tiles/Decor/SW2)
		AmmoCrate
			parent_type = /obj
			icon = 'icons/__32x32.dmi'
			icon_state = "ammocrate"
			layer = TURF_LAYER+0.2
			bound_width = 32
			bound_height = 32
			density = 1
		Cart1
			icon_state = "cart1"
			density = 1
			layer = TURF_LAYER+0.1
		Cart2
			icon_state = "cart2"
			density = 1
			de_dignore = 1
			layer = TURF_LAYER+0.1
			New()
				..()
				src.de_dignore = 1
				var/turf/T = locate(src.x, src.y + 1, src.z)
				if(isturf(T))
					T.density = 1
					T.de_dignore = 1
		News_Stand
			icon_state = "newsstand1"
			density = 1
			layer = TURF_LAYER+0.2
			New()
				..()
				src.overlays += NEWSTAND_TH
		Chainlink_Fencew
			icon_state = "chainlink3"
			layer = TURF_LAYER+0.2
			density = 1
			de_dignore = 1
			New()
				..()
				src.de_dignore = 1
				var/turf/T = locate(src.x, src.y+1, src.z)
				if(isturf(T))
					T.density = 1
					T.de_dignore = 1
		Chainlink_Fencee
			icon_state = "chainlink4"
			layer = TURF_LAYER+0.2
			density = 1
			de_dignore = 1
			New()
				..()
				src.de_dignore = 1
				var/turf/T = locate(src.x, src.y+1, src.z)
				if(isturf(T))
					T.density = 1
					T.de_dignore = 1
		Chainlink_Fence
			icon_state = "chainlink1"
			layer = TURF_LAYER+0.2
			density = 1
			de_dignore = 1
			New()
				..()
				src.de_dignore = 1
				var/turf/T = locate(src.x + 1, src.y, src.z)
				if(isturf(T))
					T.density = 1
					T.de_dignore = 1
		Chainlink_top
			icon_state = "chainlink2"
			density = 0
			layer = MOB_LAYER+0.2
			CL2
				icon_state = "chainlink3"
				density = 1
				layer = TURF_LAYER+0.2
			CL3
				icon_state = "chainlink4"
				density = 1
				layer = TURF_LAYER+0.2
			CL4
				icon_state = "chainlink5"
				layer = MOB_LAYER+0.2
			CL5
				icon_state = "chainlink6"
				layer = MOB_LAYER+0.2

		Drain
			icon = 'icons/__new32x32.dmi'
			icon_state = "drain1"
			layer = TURF_LAYER+0.1
		Trash_Bag
			icon = 'icons/__new32x32.dmi'
			icon_state = "trashbag1"
			density = 1
			layer = TURF_LAYER+0.1
		Crosswalk1
			icon_state = "crosswalk1"
			layer = TURF_LAYER+0.1
		Crosswalk2
			icon_state = "crosswalk2"
			layer = TURF_LAYER+0.1
		Sewer
			icon = 'icons/__new32x32.dmi'
			icon_state = "sewer1"
			layer = TURF_LAYER+0.1
		Trashcan
			icon = 'icons/__new32x32.dmi'
			icon_state = "trashcan1"
			density = 1
			layer = TURF_LAYER+0.2
		Payphone
			icon = '__new32x32.dmi'
			icon_state = "payphone"
			density = 1
			layer = TURF_LAYER+0.9
		Tombstone
			icon = '__new32x32.dmi'
			icon_state = "tombstone1"
			density = 0
			layer = TURF_LAYER+0.5
			Tombstone2
				icon_state = "tombstone2"
			Tombstone3
				icon_state = "tombstone3"
			Flowers
				icon = 'items.dmi'
				icon_state = "flowers"
		Hedges
			icon = '__new32x32.dmi'
			icon_state = "hedge b"
			layer = TURF_LAYER+0.5
			Hedge_TOP
				icon_state = "hedge t"
				layer = MOB_LAYER+5
	Large
		icon = 'icons/__64x64.dmi'
		Lamp1
			icon_state = "streetlight1"
			layer = TURF_LAYER+0.2
			density = 1
			New()
				..()
				src.overlays += LAMP_TH
		AC_Unit
			icon_state = "ACunit1"
			layer = TURF_LAYER+0.2
			density = 1
		Roof_Door
			icon_state = "roofdoor1"
			layer = TURF_LAYER+0.2
			density = 1
		Car
			icon_state = "car1"
			layer = TURF_LAYER+0.3
		Car_Alarm
			icon_state = "car1-alarm"
			layer = TURF_LAYER+0.3
		Car2
			icon_state = "car2"
			layer = TURF_LAYER+0.3
		Tree
			icon = 'icons/__96x96.dmi'
			icon_state = ""
			layer = MOB_LAYER+5
			Dead
				icon_state = "dead"
				layer = MOB_LAYER+5
			Tree_Bottom
				icon_state = "tree b"
				layer = TURF_LAYER
			Tree_Top
				icon_state = "tree t"
				layer = MOB_LAYER+5
			Dead_Top
				icon_state = "dead t"
				layer = MOB_LAYER+5
		Loading_Door
			icon = '__new64x64.dmi'
			icon_state = "loading door"
			layer = TURF_LAYER+0.3
		Monitor
			icon_state = "Monitor"
			Monitor_B
				icon_state = "Monitor b"
				layer = TURF_LAYER+0.5
			Monitor_T
				icon_state = "Monitor t"
				layer = MOB_LAYER+3
		Machine
			icon_state = "Machine"
			Machine_B
				icon_state = "Machine b"
				layer = TURF_LAYER+0.5
			Machine_T
				icon_state = "Machine t"
				layer = MOB_LAYER+3
	/*	Clouds
			icon = 'icons/__new16x16.dmi'
			icon_state = "cloud-s full"
			layer = MOB_LAYER+8
			Part
				icon = 'icons/__96x96.dmi'
				icon_state = "cloud-s part"*/
		Obelisk
			icon = '__96x96.dmi'
			icon_state = "obelisk"
			Obelisk_Base
				icon_state = "obelisk b"
				layer = TURF_LAYER+0.5
			Obelisk_Top
				icon_state = "obelisk t"
				layer = MOB_LAYER+5
		Grate
			icon = '__64x64.dmi'
			icon_state = "Grate"

	Theatre
		Carpet
			icon = '__new16x16.dmi'
			icon_state = "carpet"
			C2/icon_state = "carpet2"
			C3/icon_state = "carpet3"
			C4/icon_state = "carpet4"
			C5/icon_state = "carpet5"
			C6/icon_state = "carpet6"
			C7/icon_state = "carpet7"
			C8/icon_state = "carpet8"
			C9/icon_state = "carpet9"
		Wood
			icon = '__new16x16.dmi'
			icon_state = "wood"
		Shadow
			icon = '__new16x16.dmi'
			icon_state = "shadow"
			layer = TURF_LAYER+0.3
		Table
			icon = '__new32x32.dmi'
			icon_state = "table1"
			layer = TURF_LAYER+0.2
			density = 1
		Mold
			icon = '__new32x32.dmi'
			icon_state = "mold1"
			layer = TURF_LAYER+0.2
			M2/icon_state = "mold2"
		Painting
			icon = '__new16x16.dmi'
			icon_state = "painting1"
			density = 1
			layer = TURF_LAYER+2
			P2/icon_state = "painting2"
			P3/icon_state = "painting3"
			P4/icon_state = "painting4"
		Wall
			icon = '__new32x32.dmi'
			icon_state = "wall"
			layer = TURF_LAYER+0.2
			W2/icon_state = "wall2"
			W3/icon_state = "wall3"
			W4/icon_state = "wall4"
			W5/icon_state = "wall5"
			W6/icon_state = "wall6"
			W7/icon_state = "wall7"
			W8/icon_state = "wall8"
			W9/icon_state = "wall9"
			W10
				icon_state = "wall10"
				layer = MOB_LAYER+3
			Edges
				layer = MOB_LAYER+10
				icon = '__new16x16.dmi'
				icon_state = "wall1"
				W2/icon_state = "wall2"
				W3/icon_state = "wall3"
				W4/icon_state = "wall4"
		Ticket
			icon = '__new16x16.dmi'
			icon_state = "ticket1"
			layer = TURF_LAYER+0.5
			Ticket2
				icon_state = "ticket2"
			Ticket3
				icon_state = "ticket3"
			Ticket4
				icon_state = "ticket4"
			Ticket5
				icon_state = "ticket5"
			Ticket6
				icon_state = "ticket6"
			Ticket7
				icon_state = "ticket7"
			Ticket8
				icon_state = "ticket8"
				layer = MOB_LAYER+4
			Ticket9
				icon_state = "ticket9"
				layer = MOB_LAYER+4
			Ticket10
				icon_state = "ticket10"
				layer = MOB_LAYER+4
			Ticket11
				icon_state = "ticket11"
			Ticket12
				icon_state = "ticket12"
		Arcade
			icon = '__new32x32.dmi'
			icon_state = "arcade bottom"
			layer = TURF_LAYER+0.5
			Arcade_TOP
				icon_state = "arcade top"
			Arcade2
				icon_state = "arcade bottom2"
			Arcade_Top2
				icon_state = "arcade top2"
			Arcade3
				icon_state = "arcade bottom3"
			Arcade_Top3
				icon_state = "arcade top3"
		Concession
			icon = '__new16x16.dmi'
			icon_state = "concession1"
			layer = TURF_LAYER+0.3
			Concession2
				icon_state = "concession2"
				layer = MOB_LAYER+3
			Concession3
				icon_state = "concession3"
			Concession4
				icon_state = "concession4"
				layer = MOB_LAYER+3
			Concession5
				icon_state = "concession5"
			Concession6
				icon_state = "concession6"
				layer = MOB_LAYER+3
			Concession7
				icon_state = "concession7"
			Concession8
				icon_state = "concession8"
				layer = MOB_LAYER+3
		Screen
			icon = '_TheatreScreen.dmi'
			icon_state = "1"
			layer = TURF_LAYER+0.5
			Screen_Top
				icon_state = "top1"
				layer = MOB_LAYER+10
			Screen_Bottom
				icon_state = "bottom1"
		Tile
			icon = '__new16x16.dmi'
			icon_state = "tile1"
			New()
				..()
				if(prob(25))
					if(prob(25))
						src.icon_state = "tile[rand(1,3)]"
		Tile_Wall
			icon = '__new32x32.dmi'
			icon_state = "tile wall"
			Tile_Wall_Top
				icon = '__new16x16.dmi'
				icon_state = "tile wall 1"
			Tile_Wall_Bottom
				icon = '__new16x16.dmi'
				icon_state = "tile wall 2"
			Tile_Wall_Right
				icon = '__new16x16.dmi'
				icon_state = "tile wall 3"
			Tile_Wall_Left
				icon = '__new16x16.dmi'
				icon_state = "tile wall 4"
		Potty
			icon = '__new32x32.dmi'
			icon_state = "potty bottom"
			layer = TURF_LAYER+0.3
			Potty_Top
				icon_state = "potty top"
				layer = MOB_LAYER+5
		Rope_Line
			icon = '__new16x16.dmi'
			icon_state = "rope line"
			layer = MOB_LAYER+5
			Rope_Line_B
				icon_state = "rope line b"
				layer = TURF_LAYER+0.3
			Rope_Line_Top
				icon_state = "rope line t"
			Rope_Line_B2
				icon_state = "rope line b2"
				layer = TURF_LAYER+0.3
			Rope_Line_Top2
				icon_state = "rope line t2"
		Sink
			icon = '__new32x32.dmi'
			icon_state = "sink"
			layer = TURF_LAYER+0.3
		Seat
			icon = '__new16x16.dmi'
			icon_state = "seat b"
			layer = TURF_LAYER+0.3
			Seat_Top
				icon_state = "seat t"
				layer = MOB_LAYER+3
			Broken_Seat
				icon_state = "broken seat"
		Air_Hockey
			icon = '__96x96.dmi'
			icon_state = "air hockey b"
			layer = TURF_LAYER+0.3
			Air_Hockey_Top
				icon_state = "air hockey t"
				layer = MOB_LAYER+3
	Glitch
		Ground
			icon = '__16x16.dmi'
			icon_state = "glitch1"
			New()
				..()
				if(prob(25))
					if(prob(25))
						src.icon_state = "glitch[rand(1,2)]"

	Trash
		icon = 'items/items.dmi'
		parent_type = /obj
		layer = OBJ_LAYER+0.3
		Bottle
			icon_state = "bottle1"
			B2/icon_state = "bottle2"
		Paper
			icon_state = "paper1"
			P2/icon_state = "paper2"
		Newspaper
			icon = '__32x32.dmi'
			icon_state = "newspaper"
		Cardboard_Box
			icon_state = "box"
			Big_Box
				icon = '__32x32.dmi'
				icon_state = "cardboard box"
				density = 1
	Acid_Shilo
		icon = 'icons/acidthing.dmi'
		icon_state = "bottom"
		layer = TURF_LAYER+0.1

		Top
			icon_state = "top"
			layer = MOB_LAYER+9
	Dumpster
		icon = 'icons/_Dumpster.dmi'
		icon_state = "1"
		layer = TURF_LAYER+9

	Helipad
		icon = '__96x96.dmi'
		icon_state = "helipad"
	Billboard
		icon = '__96x96.dmi'
		icon_state = "billboard"
	Gothic_Fence
		icon = '__new16x16.dmi'
		icon_state = "gothic"
		density = 1
		Gothic_Fence_Top
			icon = '__new32x32.dmi'
			icon_state = "gothic fence"
			layer = MOB_LAYER+3
			density = 0
		Gothic_Gate
			icon = '__new64x64.dmi'
			icon_state = "gothic gate"
			layer = MOB_LAYER+3

	Mausoleum
		Mausoleum_Base
			icon = '_Mausoleum.dmi'
			layer = TURF_LAYER+0.5
		Mausoleum_TOP
			icon = '_Mausoleum.dmi'
			icon_state = "Top"
			layer = MOB_LAYER+5
	PATHS
		Mausoleum_OUTSIDE // Outside; when going inside the building.
			Entered(mob/P)
				if(P)
					P.loc = locate(P.x, P.y+1, P.z+1)
		Mausoleum_INSIDE // Inside; when going outside the building.
			Entered(mob/P)
				if(P)
					P.loc = locate(P.x, P.y-1, P.z-1)

