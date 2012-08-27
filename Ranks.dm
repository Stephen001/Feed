/*Ranks and shit.

¡ = 1
¢ = 2
£ = 3
¤ = 4
¥ = 5
¦ = 6
© = 7
« = 8
¬ = 9
® = 10
° = 11
± = 12
µ = 13
¶ = 14
» = 15
 */

mob/player/client
	var
		rank = 1
		rank_emblem = "¡"
		exp = 0
		maxexp = 50
	proc
		rank_up()
			if(src.rank == 15)
				src.exp = src.maxexp/2

			else if(src.exp >= src.maxexp)
				src.exp = 0
				src.maxexp += 150*(src.rank+5)
				src.get_new_rank()
				world_chat("[rank_emblem][src] ranked up!")

		get_new_rank()
			switch(src.rank)
				if(1)
					src.rank = 2
					src.rank_emblem = "¢"
					return
				if(2)
					src.rank = 3
					src.rank_emblem = "£"
					return
				if(3)
					src.rank = 4
					src.rank_emblem = "¤"
					return
				if(4)
					src.rank = 5
					src.rank_emblem = "¥"
					return
				if(5)
					src.rank = 6
					src.rank_emblem = "¦"
					return
				if(6)
					src.rank = 7
					src.rank_emblem = "©"
					return
				if(7)
					src.rank = 8
					src.rank_emblem = "«"
					return
				if(8)
					src.rank = 9
					src.rank_emblem = "¬"
					return
				if(9)
					src.rank = 10
					src.rank_emblem = "®"
					return
				if(10)
					src.rank = 11
					src.rank_emblem = "°"
					return
				if(11)
					src.rank = 12
					src.rank_emblem = "±"
					return
				if(12)
					src.rank = 13
					src.rank_emblem = "µ"
					return
				if(13)
					src.rank = 14
					src.rank_emblem = "¶"
					return
				if(14)
					src.rank = 15
					src.rank_emblem = "»"
					return