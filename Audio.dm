/*******************************************
*** AUDIO.DM REWRITEN BY KUMO ON 8/21/12 ***
*******************************************/



		// <------------ Music definitions --------->


var {

	CURRENT_MUSIC 				= null // <--- The music track that is currently playing.


		// <--------- Atmospheric --------->

	SOUND_WIND 				= sound('audio/sound/wind[edit].ogg',1, volume = 60, channel = 50)

		// <--------- Weapons --------->

	SOUND_GRENADE 				= sound('audio/sound/grenade.ogg',0, volume = 60, channel = 10)
	SOUND_GUNFIRE1 			= sound('audio/sound/gun1.ogg',0, volume = 60, channel = 12)
	SOUND_GUNFIRE2 			= sound('audio/sound/gun2.ogg',0, volume = 60, channel = 12)
	SOUND_SHOTGUN 				= sound('audio/sound/shotgun1.ogg',0, volume = 90, channel = 13)
	SOUND_CROSSBOW 			= sound('audio/sound/crossbow1.ogg',0, volume = 90, channel = 14)

		// <--------- Enemy sounds --------->

	SOUND_ZGROWL1 				= sound('audio/sound/growl1.ogg',0, volume = 60)
	SOUND_ZGROWL2 				= sound('audio/sound/growl2.ogg',0, volume = 60)

		// <--------- Interface --------->

	SOUND_CLICK				= sound('audio/sound/click.ogg',0, volume = 100)

		// <--------- Announcement --------->

	SOUND_WAVE_BEGINING 		= sound('audio/sound/voice_wave_begin.ogg',0, volume = 60)
	SOUND_WAVE_COMPLETE 		= sound('audio/sound/voice_wave_complete.ogg',0, volume = 62)
	SOUND_ACHIEVEMENT_U 		= sound('audio/sound/voice_au.ogg',0, volume = 60)
	SOUND_ALL_PLAYERS_DEAD 		= sound('audio/sound/voice_all_players_dead.ogg',0, volume = 60)

		// <--------- Music --------->

	MUSIC_WAIT 				= sound('audio/music/wait.ogg',1,volume = 30, channel = 3)


	MUSIC_SIMPLY_NO_CHANCE 		= sound('audio/music/simply_no_chance[loop].ogg',1,volume = 30, channel = 3)
	MUSIC_NO_WHERE_TO_RUN 		= sound('audio/music/no_where_to_run[loop].ogg',1,volume = 30, channel = 3)
	MUSIC_FIVE 				= sound('audio/music/five.ogg',1,volume = 30, channel = 3)
	MUSIC_TWO 				= sound('audio/music/two.ogg',1,volume = 30, channel = 3)
	MUSIC_THREE 				= sound('audio/music/three.ogg',1,volume = 30, channel = 3)

				// <--- Lists --->

	list {

		s_gun			= list (SOUND_GUNFIRE1, SOUND_GUNFIRE2) // <--- The list that the gun "pop" is chosen from.
		s_growl			= list (SOUND_ZGROWL1, SOUND_ZGROWL2) // <--- The list that the zombie's "growl" is chosen from.

		MUSIC_SOUNDTRACK 	= list (MUSIC_SIMPLY_NO_CHANCE, MUSIC_NO_WHERE_TO_RUN, MUSIC_FIVE, MUSIC_TWO, MUSIC_THREE)
	}
}

		// <--------- Proc(s) --------->

proc
	Cycle_Music() // <--- Proc that decides what mucis track will be played for the duration of the match.
		CURRENT_MUSIC = pick(MUSIC_SOUNDTRACK)