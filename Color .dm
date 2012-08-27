/*******************************************
*** COLOR.DM REWRITEN BY KUMO ON 8/21/12 ***
*******************************************/

		// <--------- Variables --------->

var {

	list {

		colors		= list ("Blue" = "#1C86EE", "Red" = "#FF3333", "Green" = "#00FF00", "Purple" = "#FF00FF", "Orange" = "#FFB90F")
		color_check	= new/list()
	}
}

mob/player/client
	var {
		tmp {

			color = null
		}
	}

		// <--------- Procs --------->

proc
	color_gen_checker()
		for(var/C in colors)
			color_check += colors[C]

	hex2rgb(hex)
		var {

			red 		= (hex_loc(copytext(hex, 2, 3))*16)+hex_loc(copytext(hex, 3, 4))
			green	= (hex_loc(copytext(hex, 4, 5))*16)+hex_loc(copytext(hex, 5, 6))
			blue		= (hex_loc(copytext(hex, 6, 7))*16)+hex_loc(copytext(hex, 7, 8))
		}

		return list ("r" = text2num(red), "g" = text2num(green), "b" = text2num(blue))

	hex_loc(char)
		var {
			list {

				hex_vals		= list ("0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f")
			}
		}

		return hex_vals.Find(lowertext(char))-1

