/******************************************
*** AREA.DM REWRITEN BY KUMO ON 8/21/12 ***
******************************************/


// <--------- Variables --------->


var {

	time_of_day = null

	area {

		outside_area = null
	}

	list {

		de_dark_images = list("0" = image('icons/de_dark_alpha.dmi',,"0",60),\
						"1" = image('icons/de_dark_alpha.dmi',,"1",60),\
						"2" = image('icons/de_dark_alpha.dmi',,"2",60),\
						"3" = image('icons/de_dark_alpha.dmi',,"3",60),\
						"6" = image('icons/de_dark_alpha.dmi',,"6",60))
	}
}


		// <--------- Procs and such --------->


proc
	DE_Weather()
		var {

			area/outside/A = outside_area
		}

		if(A)

			time_of_day = pick("Dawn", "Day", "Dusk", "Night")

			var {

				DAYLIGHT = 0
			}

			switch(time_of_day) {

				if("Dawn")
					DAYLIGHT = 1
				if("Day")
					DAYLIGHT = 3
				if("DUSK")
					DAYLIGHT = 2
				if("Night")
					DAYLIGHT = 0
			}

			A.de_luminosity = DAYLIGHT
			A.de_LightLevel()


		// <--------- Other stuff --------->


area {
	mouse_opacity = 0

	outside
		var {
			tmp {

				de_luminosity = 0

				image {

					de_darkimage
				}
			}
		}

		proc

			de_LightLevel(level = src.de_luminosity as num)

				src.overlays.Remove(src.de_darkimage)
				src.de_darkimage = de_dark_images["[level]"]
				src.overlays.Add(src.de_darkimage)

		New()
			..()
			if(!outside_area && src.type == /area/outside) {

				outside_area = src
				src.de_LightLevel()
			}
}