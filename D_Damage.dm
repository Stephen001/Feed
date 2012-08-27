/**********************************************
*** D_DAMAGE.DM REWRITEN BY KUMO ON 8/22/12 ***
**********************************************/

proc
	D_damage(atom/A, var/text2show = null, var/icont = 1)
		if(A)
			var {

				turf/T
				icon/D	= 'icons/D_damager.dmi'
			}

			if(isturf(A))
				T = A

			else
				T = A.loc

			if(T)
				switch(icont)
					if(0)
						D = 'icons/D_damagey.dmi'
					if(1)
						D = 'icons/D_damagey.dmi'
					if(3)
						D = 'icons/D_damageg.dmi'

				for(var/i = 1, i <=length(text2show), i++)
					var/Effects/de_damage_text/O = garbage.Grab(/Effects/de_damage_text)
					if(O)
						O.loc 	= T
						O.icon 	= D

						O.pixel_x += (i * 8)
						O.icon_state = "[copytext(text2show, i, (i + 1))]"

						spawn()
							O.DE_EO()