

mob/player/client
	verb
		headpage(var/t as text)
			set hidden = 1
			switch(t)
				if("1")
					winset(src, null, "custompane.headchild.left=\"headpane1\"")
				if("2")
					winset(src, null, "custompane.headchild.left=\"headpane2\"")
				if("3")
					winset(src, null, "custompane.headchild.left=\"headpane3\"")

		vanitypage(var/t as text)
			set hidden = 1
			switch(t)
				if("1")
					winset(src, null, "custompane.vanitychild.left=\"vanitypane1\"")
				if("2")
					winset(src, null, "custompane.vanitychild.left=\"vanitypane2\"")

		changei(var/t as text)
			set hidden = 1
			switch(t)

		//SKIN
				if("skin_white")
					src.skintone = 'icons/_BaseW.dmi'
					src.save_account()
					src.generate_icon()
				if("skin_tan")
					src.skintone = 'icons/_BaseT.dmi'
					src.save_account()
					src.generate_icon()
				if("skin_dark")
					src.skintone = 'icons/_BaseD.dmi'
					src.save_account()
					src.generate_icon()
				if("skin_black")
					src.skintone = 'icons/_BaseB.dmi'
					src.save_account()
					src.generate_icon()
		//HEAD
				if("head1")
					src.hairstyle = "style1"
					src.save_account()
					src.generate_icon()
				if("head2")
					src.hairstyle = "style2"
					src.save_account()
					src.generate_icon()
				if("head3")
					src.hairstyle = "style3"
					src.save_account()
					src.generate_icon()
				if("head4")
					src.hairstyle = "hat2"
					src.save_account()
					src.generate_icon()
				if("head5")
					src.hairstyle = "style4"
					src.save_account()
					src.generate_icon()
				if("head6")
					src.hairstyle = "cameo1"
					src.save_account()
					src.generate_icon()
				if("head7")
					src.hairstyle = "hat1"
					src.save_account()
					src.generate_icon()
				if("head8")
					src.hairstyle = "style5"
					src.save_account()
					src.generate_icon()
				if("head9")
					src.hairstyle = "style6"
					src.save_account()
					src.generate_icon()
				if("head10")
					src.hairstyle = "hat3"
					src.save_account()
					src.generate_icon()
				if("head11")
					src.hairstyle = "hat4"
					src.save_account()
					src.generate_icon()
		//VANITY
				if("vanity1")
					src.vanity = ""
					src.save_account()
					src.generate_icon()
				if("vanity2")
					src.vanity = "vanity1"
					src.save_account()
					src.generate_icon()
				if("vanity3")
					src.vanity = "vanity2"
					src.save_account()
					src.generate_icon()
				if("vanity4")
					src.vanity = "vanity3"
					src.save_account()
					src.generate_icon()
				if("vanity5")
					src.vanity = "vanity4"
					src.save_account()
					src.generate_icon()
				if("vanity6")
					src.vanity = "vanity5"
					src.save_account()
					src.generate_icon()
