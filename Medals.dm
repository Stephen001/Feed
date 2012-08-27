
mob/proc
	medal_check(var/text/T)
		if(!world.GetMedal("Oops!", src))
			world_chat("[src.key] unlocked the 'Oops!' medal!")
			src << SOUND_ACHIEVEMENT_U
			world.SetMedal("Oops!", src)