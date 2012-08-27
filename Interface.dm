/***********************************************
*** INTERFACE.DM REWRITEN BY KUMO ON 8/17/12 ***
***********************************************/

var {

	wave_complete 		= new /ScreenFX/wave_done
	spectate_stuff 	= new /ScreenFX/spectate
	MenuBG 			= new /ScreenFX/MenuBG
	TitleMenuBG 		= new /ScreenFX/TitleMenuBG
	outbreak 			= new /ScreenFX/outbreak
	hurt				= new /ScreenFX/hurt

	list {

		title_screen 		= newlist (/ScreenFX/Title/Background, /ScreenFX/Title/JoinGame, /ScreenFX/Title/Credits)

		buttons 			= newlist (/ScreenFX/Help, /ScreenFX/Customize, /ScreenFX/ToggleChat, /ScreenFX/NameGreen, \
								/ScreenFX/NameRed, /ScreenFX/NameBlue, /ScreenFX/NamePurple)

		chat				= newlist (/ScreenFX/chatBG, /ScreenFX/chatBGright, /ScreenFX/chatBGbottom, /ScreenFX/chatBGcorner)
	}
}


		// <------------------------ Screen datums ------------------------->

ScreenFX 		// <--- Basically the universal datum for 90% of the screen effects.
	parent_type = /obj

	Title  // <--- Moved this under ScreenFX for etter organization. I'm weird, I know.

		Background
			icon 		= 'Background.png'
			screen_loc 	= "map_title:1,1"

		JoinGame
			icon			= '_Connect.dmi'
			icon_state 	= "off"
			screen_loc	= "map_title:13:5,5:4"

			mouse_opacity 	= 2

			MouseEntered()
				..()
				usr << SOUND_CLICK
				src.icon_state = "on"

			MouseExited()
				..()
				src.icon_state = "off"

			Click()
				..()
				var/mob/M = usr
				if(M.type == /mob/new_client)
					var/mob/new_client/N = M
					N.login_server()

		Credits
			icon			= '_Credit.dmi'
			icon_state 	= "off"
			screen_loc	= "map_title:13:13,3:8"

			mouse_opacity 	= 2

			MouseEntered()
				..()
				usr << SOUND_CLICK
				src.icon_state = "on"

			MouseExited()
				..()
				src.icon_state = "off"

			Click()
				..()
				usr.client.screen += TitleMenuBG
				winset(usr, null, "menuchild.left =\"creditpane\"")
				winshow(usr, "menuchild", 1)

		// <---------------ScreenFX that aren't Title related. ------------------>

	wave_done
		icon 		= 'wave_done.png'
		screen_loc 	= "1,1"

		layer 		= EFFECTS_LAYER+50
		mouse_opacity 	= 0

	outbreak
		icon 		= 'outbreak.png'
		screen_loc 	= "1,1"

		layer 		= EFFECTS_LAYER+50
		mouse_opacity 	= 0

	chatBG
		icon 		= 'icons/__16x16.dmi'
		icon_state 	= "chatBG"
		screen_loc 	= "1,20 to 15,15"

		layer 		= EFFECTS_LAYER
		mouse_opacity 	= 0

	chatBGright
		icon 		= 'icons/__16x16.dmi'
		icon_state 	= "chatBG-right"
		screen_loc 	= "16,20 to 16,15"

		layer 		= EFFECTS_LAYER
		mouse_opacity 	= 0

	chatBGbottom
		icon 		= 'icons/__16x16.dmi'
		icon_state 	= "chatBG-bottom"
		screen_loc 	= "1,14 to 15,14"

		layer 		= EFFECTS_LAYER
		mouse_opacity 	= 0

	chatBGcorner
		icon 		= 'icons/__16x16.dmi'
		icon_state 	= "chatBG-corner"
		screen_loc 	= "16,14"

		layer 		= EFFECTS_LAYER
		mouse_opacity 	= 0

	spectate
		icon 		= 'spectate.png'
		screen_loc 	= "1,1"

		layer 		= EFFECTS_LAYER+50
		mouse_opacity 	= 0

	hurt
		icon 		= 'Hurt.png'
		screen_loc 	= "1,1"

		layer 		= EFFECTS_LAYER+50
		mouse_opacity 	= 0

	fraktureStudios
		icon 		= 'frakture_studios.png'
		screen_loc 	= "map_title:1,1"

		layer 		= EFFECTS_LAYER

	fade
		icon 		= 'icons/_Effects.dmi'
		icon_state	= "fade"
		screen_loc 	= "map_title:1,1 to 30,20"

		layer 		= EFFECTS_LAYER+50

	Help
		icon 		= 'Help.dmi'
		icon_state 	= "off"
		screen_loc 	= "29:6,20"

		layer 		= EFFECTS_LAYER+99
		mouse_opacity 	= 2

		MouseEntered()
			..()
			src.icon_state = "on"

		MouseExited()
			..()
			src.icon_state = "off"

		Click()
			..()
			usr.client.screen += MenuBG
			winset(usr, null, "menuchild.left \"helppane\"")
			winshow(usr, "menuchild", 1)
			usr.overlays += 'busy.dmi'

	Customize
		icon 		= 'Customize.dmi'
		icon_state 	= "off"
		screen_loc 	= "25:9,20:1"

		layer 		= EFFECTS_LAYER+99
		mouse_opacity 	= 2

		MouseEntered()
			..()
			src.icon_state = "on"

		MouseExited()
			..()
			src.icon_state = "off"

		Click()
			..()
			usr.client.screen += MenuBG
			winset(usr, null, "menuchild.left \"custompane\"")
			winshow(usr, "menuchild", 1)
			usr.overlays += 'busy.dmi'

	NameGreen
		icon 		= 'icons/_Menu.dmi'
		icon_state 	= "name-green"
		screen_loc	= "1:2,14:-3"

		layer		= EFFECTS_LAYER+10
		mouse_opacity	= 1

		Click()
			..()
			var/mob/player/client/C = usr
			C.color = "#00FF00"

			src.icon_state = "name-green!"
			spawn(3)
				src.icon_state = "name-green"

			C.save_account()
			C.generate_icon()

	NameRed
		icon 		= 'icons/_Menu.dmi'
		icon_state 	= "name-red"
		screen_loc	= "1:3,14:-3"

		layer		= EFFECTS_LAYER+10
		mouse_opacity	= 1

		Click()
			..()
			var/mob/player/client/C = usr
			C.color = "#FF3333"

			src.icon_state = "name-red!"
			spawn(3)
				src.icon_state = "name-red"

			C.save_account()
			C.generate_icon()

	NameBlue
		icon 		= 'icons/_Menu.dmi'
		icon_state 	= "name-blue"
		screen_loc	= "2:4,14:-3"

		layer		= EFFECTS_LAYER+10
		mouse_opacity	= 1

		Click()
			..()
			var/mob/player/client/C = usr
			C.color = "#1C86EE"

			src.icon_state = "name-blue!"
			spawn(3)
				src.icon_state = "name-blue"

			C.save_account()
			C.generate_icon()

	NamePurple
		icon 		= 'icons/_Menu.dmi'
		icon_state 	= "name-purple"
		screen_loc	= "2:5,14:-3"

		layer		= EFFECTS_LAYER+10
		mouse_opacity	= 1

		Click()
			..()
			var/mob/player/client/C = usr
			C.color = "#FF00FF"

			src.icon_state = "name-purple!"
			spawn(3)
				src.icon_state = "name-purple"

			C.save_account()
			C.generate_icon()

	ToggleChat
		icon 		= 'icons/_Menu.dmi'
		icon_state 	= "chat-add-on"
		screen_loc	= "3:6,14:-3"

		layer		= EFFECTS_LAYER+10
		mouse_opacity	= 1

		Click()
			..()

			if(usr.chat_on)
				src.icon_state = "chat-add-off"
				usr.client.chat.hide()
				usr.client.screen -= chat
				usr.chat_on = 0
				usr.chat_buttons(1)

			else
				src.icon_state = "chat-add-on"
				usr.client.chat.show()
				usr.client.screen += chat
				usr.chat_on = 1
				usr.chat_buttons(0)

	MenuBG
		icon 		= '_Menu.dmi'
		icon_state	= "bg"
		screen_loc	= "NORTHWEST to SOUTHEAST"

		layer 		= EFFECTS_LAYER+100
		mouse_opacity	= 2

	TitleMenuBG
		icon 		= '_Menu.dmi'
		icon_state	= "bg"
		screen_loc	= "map_title:1,1 to 30,20"

		layer 		= EFFECTS_LAYER+100
		mouse_opacity	= 2

	Loadscreen
		icon 		= 'loadscreen.dmi'

		layer 		= EFFECTS_LAYER-1

	Respawn
		icon 		= 'Respawn.dmi'
		screen_loc	= "13,12"

		layer 		= EFFECTS_LAYER+50


		// <---------------------Procs-------------------->

mob/
	player/client
		proc
			remove_hurt()
				for(var/ScreenFX/hurt/H in src.client.screen)
					del H

	new_client
		var {

			tmp
				connected = 0

		}

		proc
			interface_reset()
				winset(src, "main_splitter","left=title_window;right=")
				winset(src, "main_window","macro=new")

			connect_server()
				if(!src.connected)
					src.connected = 1
					src.client.screen -= title_screen

					winset(src, "main_splitter","left=map_window;right=")
					winset(src, "main_window","macro=macro")

			login_server()
				src.connected = 1
				src.client.screen -= title_screen

				winset(src, "log_reg_window.log_reg_child", "left=\"log_pane\"")
				winset(src, "main_splitter","left=log_reg_window;right=")

	verb
		close_news()
			set hidden = 1
			winshow(usr, "menuchild", 0)