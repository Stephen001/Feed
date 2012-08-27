
	// <--- On-screen chat developed by ExPixel.


#define true TRUE
#define false FALSE


proc
	/*
		broadcast_msg(msg, font, format)
			-	Broadcasts the specified message to the world
				in the chatbox.
			Args:
				msg: The message to broadcast.
				font: the font to use.
				format: if true, will wrap the text to fit the chatbox.
				box: Alert or world
	*/


	broadcast_msg( var/msg, var/font, var/format )
		for(var/client/C)
			if(C.alert) C.alert.addText( msg, font, format )

	world_chat(msg)
		for(var/client/C)
			if(C.chat) C.chat.addText( "[msg]", ChatFont, true )

	world_alert(msg)
		broadcast_msg( msg, FadeFont, true )



/////////////////////////////////////


ChatBox
	parent_type = /HUD
	var/client/user
	var/list/messages = list()
	var/width = 0
	var/height = 0
	var/padding = 0
	var/hidden = false
	layer = EFFECTS_LAYER
	New(var/client/_user, var/_width, var/_height, var/_padding, var/_layer)
		..(_user)
		if(_user)		user = _user
		if(_width)		width = _width
		if(_height)		height = _height
		if(_padding)	padding = _padding
		if(_layer)		layer = _layer
	proc
		addText(var/msg, var/TextFont/Font, var/format=false)
			var/TextObject/O = \
				TextWriter.WriteText(msg, Font,
									width - padding * 2,
									height,
									layer+1,
									format)
			var/pos_y = getNewYPos()
			if(messages.len > 0)
				if(pos_y + O.height > height)
					var/i = 1
					while(i <= messages.len)
						removeMessage(i)
						if(messages.len == 0) break
						pos_y = getNewYPos()
						if(pos_y + O.height > height) continue
						else break
						i++
			addMessage(O, pos_y)
		removeMessage(var/index)
			var/TextObject/O = messages[index]
			messages.Cut(index,index+1)
			var/H = O.height
			user.screen.Remove(O)
			for(var/TextObject/_O in messages)
				_O.changeScreenOY(H)
		addMessage(var/TextObject/msg, var/pos)
			msg.setScreenLoc(screen_x, screen_y, screen_x_offset+padding, screen_y_offset-pos)
			if(hidden)
				msg.invisibility = 101
			user.screen.Add(msg)
			messages.Add(msg)
		hide()
			hidden = true
			for(var/obj/O in messages)
				O.invisibility = 101
			src.invisibility = 101
		show()
			hidden = false
			for(var/obj/O in messages)
				O.invisibility = 0
			src.invisibility = 0

		getNewYPos()
			var/_y = 0
			for(var/TextObject/O in messages)
				var/h = O.height
				_y += h
			return _y


/////////////////////////////////////////////////








HUD
	parent_type = /obj
	layer = EFFECTS_LAYER
	var
		screen_x = 0//READ ONLY
		screen_y = 0//READ ONLY
		screen_x_offset = 0//READ ONLY
		screen_y_offset = 0//READ ONLY
		screen_map = null//READ ONLY
	New(var/client/new_client,  new_screen_x=null, new_screen_y=null, new_screen_x_offset=null, new_screen_y_offset=null,
								new_screen_map=null)
		..()
		if(new_screen_x != null) screen_x = new_screen_x
		if(new_screen_y != null) screen_y = new_screen_y
		if(new_screen_x_offset != null) screen_x_offset = new_screen_x_offset
		if(new_screen_y_offset != null) screen_y_offset = new_screen_y_offset
		if(new_screen_map != null) screen_map = new_screen_map

		if(new_client) new_client.screen.Add(src)
		if(screen_x && screen_y) setScreenLoc(screen_x, screen_y, screen_x_offset, screen_y_offset, screen_map)

	proc
		changeScreenX(var/change=0)
			setScreenLoc( screen_x+change )
		changeScreenY(var/change=0)
			setScreenLoc( null, screen_y+change )
		changeScreenOX(var/change=0)
			setScreenLoc( null, null, screen_x_offset+change )
		changeScreenOY(var/change=0)
			setScreenLoc( null, null, null, screen_y_offset+change )

		setScreenX(var/newX)
			setScreenLoc( newX )
		setScreenY(var/newY)
			setScreenLoc( null, newY )
		setScreenOX(var/newOX)
			setScreenLoc( null, null, newOX )
		setScreenOY(var/newOY)
			setScreenLoc( null, null, null, newOY )
		setScreenMap(var/new_map)
			setScreenLoc( null, null, null, null, screen_map)

		setScreenLoc(X=null, Y=null, OX=null, OY=null, ScreenMap=null)
			var/X1 = screen_x
			var/X2 = screen_x_offset
			var/Y1 = screen_y
			var/Y2 = screen_y_offset
			if(X != null)
				X1 = X
				screen_x = X1
			if(Y != null)
				Y1 = Y
				screen_y = Y1
			if(OX != null)
				X2 = OX
				screen_x_offset = X2
			if(OY != null)
				Y2 = OY
				screen_y_offset = Y2
			if(ScreenMap != null)
				screen_map = ScreenMap
			var/n_s_loc = "[X1]:[X2],[Y1]:[Y2]"
			if(screen_map && length(screen_map)) n_s_loc = "[screen_map]:"+n_s_loc
			screen_loc = n_s_loc
			screenLocChanged()

		screenLocChanged()
			return ..()


////////////////////////////////////



#define MONOSPACE 1
#define VARIABLEWIDTH 2

/*
STFont
	BlackFont
		icon = 'blackFont.dmi'
		width = 6
		height= 8
		ascent = 2
		descent = 5
		mode = MONOSPACE//VARIABLE_WIDTH
		/*
		letter_widths = list(\
		{""}=1,{"A"}=6,{"B"}=6,{"C"}=6,{"D"}=6,{"E"}=6,{"F"}=6,{"G"}=6,{"H"}=6,{"I"}=6,{"J"}=6,{"K"}=6,\
		{"L"}=6,{"M"}=6,{"N"}=6,{"O"}=6,{"P"}=6,{"Q"}=6,{"R"}=6,{"S"}=6,{"T"}=6,{"U"}=6,{"V"}=6,{"W"}=6,\
		{"X"}=6,{"Y"}=6,{"Z"}=6,{"a"}=6,{"b"}=6,{"c"}=6,{"d"}=6,{"e"}=6,{"f"}=5,{"g"}=6,{"h"}=4,{"i"}=2,\
		{"j"}=5,{"k"}=5,{"l"}=3,{"m"}=6,{"n"}=5,{"o"}=6,{"p"}=6,{"q"}=6,{"r"}=5,{"s"}=5,{"t"}=5,{"u"}=5,\
		{"v"}=6,{"w"}=6,{"x"}=6,{"y"}=6,{"z"}=6,{"0"}=6,{"1"}=4,{"2"}=6,{"3"}=6,{"4"}=6,{"5"}=6,{"6"}=6,\
		{"7"}=6,{"8"}=6,{"9"}=6,{"."}=3,{","}=3,{"!"}=2,{"/"}=6,{"""}=6,{"'"}=3,{"_"}=6,{"é"}=6,{":"}=3,\
		{"?"}=6,{"*"}=10,{"cursor"}=6,{"\["}=5,{"]"}=5)
		*/
	WhiteFont
		icon = 'whiteFont.dmi'
		width = 6
		height= 8
		ascent = 2
		descent = 5
		mode = MONOSPACE//VARIABLE_WIDTH
		/*
		letter_widths = list(\
		{""}=1,{"A"}=6,{"B"}=6,{"C"}=6,{"D"}=6,{"E"}=6,{"F"}=6,{"G"}=6,{"H"}=6,{"I"}=6,{"J"}=6,{"K"}=6,\
		{"L"}=6,{"M"}=6,{"N"}=6,{"O"}=6,{"P"}=6,{"Q"}=6,{"R"}=6,{"S"}=6,{"T"}=6,{"U"}=6,{"V"}=6,{"W"}=6,\
		{"X"}=6,{"Y"}=6,{"Z"}=6,{"a"}=6,{"b"}=6,{"c"}=6,{"d"}=6,{"e"}=6,{"f"}=5,{"g"}=6,{"h"}=4,{"i"}=2,\
		{"j"}=5,{"k"}=5,{"l"}=3,{"m"}=6,{"n"}=5,{"o"}=6,{"p"}=6,{"q"}=6,{"r"}=5,{"s"}=5,{"t"}=5,{"u"}=5,\
		{"v"}=6,{"w"}=6,{"x"}=6,{"y"}=6,{"z"}=6,{"0"}=6,{"1"}=4,{"2"}=6,{"3"}=6,{"4"}=6,{"5"}=6,{"6"}=6,\
		{"7"}=6,{"8"}=6,{"9"}=6,{"."}=3,{","}=3,{"!"}=2,{"/"}=6,{"""}=6,{"'"}=3,{"_"}=6,{"é"}=6,{":"}=3,\
		{"?"}=6,{"*"}=10,{"cursor"}=6,{"\["}=5,{"]"}=5)
		*/
*/

#define SPACE_CHAR " "
#define LINEBREAK_CHAR "\n"
#define TAB_CHAR "\t"


TextFont
	var/mode = MONOSPACE // The mode of the font.
	var/width // Width of the letters in MONOSPACE mode.
	var/list/lwidth
	var/height // Height of the letters in VARIABLEWIDTH and MONOSPACE mode.
	var/horizontal_offset // How far to the right the letter is.
	var/space_width = 3 // in pixels
	var/tab_width = 4 //number of spaces in a tab
	var/line_height_offset = 2// Distance between two lines in pixels.
	var/icon
	var/extra_pad = 1
	var/space_pad = 0
	var/list/cached_colors

	proc
		getLetterWidth(var/letter)
			if(letter == SPACE_CHAR) return space_width + space_pad
			if(mode == MONOSPACE) return width + extra_pad
			else
				return getVariableWidth(letter)
		getVariableWidth(var/letter)
			if(!lwidth.Find(letter))
				return width + extra_pad
			else
				return lwidth[letter] + extra_pad
		getColor(var/color)
			if(cached_colors == null)
				cached_colors = new/list()
				cached_colors += "null"
				cached_colors["null"] = icon(icon)
			if(!cached_colors.Find(color))
				var/icon/I = icon(cached_colors["null"])
				I.Blend(color, ICON_MULTIPLY)
				cached_colors.Add(color)
				cached_colors[color] = I
			return cached_colors[color]

TextFont
	Default
		icon = 'icons/_Font.dmi'
		mode = MONOSPACE
		width = 6
		height = 11
		horizontal_offset = 1
	Fade
		icon = 'icons/_Font(fade).dmi'
		mode = MONOSPACE
		width = 6
		height = 11
		horizontal_offset = 1
	Chat
		icon = 'icons/_Chat.dmi'
		height = 8
		width = 4
		horizontal_offset = 1
		mode = VARIABLEWIDTH
		lwidth = list(\
		{""}=1,{"A"}=4,{"B"}=4,{"C"}=4,{"D"}=4,{"E"}=4,{"F"}=4,{"G"}=4,{"H"}=4,{"I"}=3,{"J"}=4,{"K"}=4,\
		{"L"}=4,{"M"}=6,{"N"}=5,{"O"}=5,{"P"}=4,{"Q"}=4,{"R"}=4,{"S"}=4,{"T"}=5,{"U"}=4,{"V"}=5,{"W"}=7,\
		{"X"}=5,{"Y"}=5,{"Z"}=5,{"a"}=4,{"b"}=4,{"c"}=4,{"d"}=4,{"e"}=4,{"f"}=4,{"g"}=4,{"h"}=4,{"i"}=1,\
		{"j"}=2,{"k"}=4,{"l"}=1,{"m"}=7,{"n"}=4,{"o"}=4,{"p"}=4,{"q"}=4,{"r"}=4,{"s"}=4,{"t"}=3,{"u"}=4,\
		{"v"}=4,{"w"}=7,{"x"}=5,{"y"}=4,{"z"}=4,{"0"}=4,{"1"}=2,{"2"}=4,{"3"}=4,{"4"}=4,{"5"}=4,{"6"}=4,\
		{"7"}=4,{"8"}=4,{"9"}=4,{"."}=1,{"!"}=1,{"?"}=4,{","}=2,{"""}=3,{"("}=3,{")"}=3,{"*"}=5,{"+"}=5, \
		{"-"}=4,{"@"}=7,{"#"}=7,{"$"}=7,{"%"}=7,{"'"}=1,{"&"}=7,{"="}=5,{":"}=1,{";"}=2,{"|"}=1,{"/"}=7, \
		{"§"}=7,{"¡"}=6,{"¢"}=6,{"£"}=6,{"¤"}=2,{"¥"}=5,{"¦"}=5,{"©"}=5,{"«"}=6,{"¬"}=6,{"®"}=3,{"<"}=4, \
		{">"}=4,{"^"}=7,{"°"}=5,{"±"}=3,{"µ"}=5,{"¶"}=8,{"»"}=6)

TextObjectInfoHolder
	var
		Width
		Height
		Text
		obj/Overlay

TextObject
	parent_type = /HUD
	var/width
	var/height
	var/overlay_text
	proc
		Copy(var/TextObjectInfoHolder/T)
			src.width = T.Width
			src.height = T.Height
			src.overlay_text = T.Text
			src.overlays.Add(T.Overlay)

TemporaryTextHolder
	var
		current_x_pos = 0
		current_y_pos = 0
		highest_width_reached = 0
		highest_height_reached = 0
		max_width
		max_height
		TextFont/Font
		obj/overlay_object
		LAYER
		height_reached = 0
		first_line_break = TRUE
		obj/char
	proc
		AddLetter(var/letter="", var/SpecialIcon=null)
			var/current_letter_width = Font.getLetterWidth(letter)
			if(max_width != -1 && current_x_pos + current_letter_width > max_width)
				if(letter == SPACE_CHAR)
					current_x_pos += current_letter_width
					return TRUE
				if(!AddLineBreak()) return FALSE
			if(!char) char = new
			if(char.icon != SpecialIcon) char.icon = SpecialIcon//Font.icon
			if(char.icon_state != letter) char.icon_state = letter
			char.pixel_x = current_x_pos
			char.pixel_y = -1 * current_y_pos
			char.layer = LAYER
			current_x_pos += current_letter_width
			overlay_object.overlays.Add(char)
			return TRUE
		AddTab()
			var/TAB = Font.space_width * Font.tab_width
			if(max_width != -1 && current_x_pos + TAB > max_width)
				if(!AddLineBreak()) return FALSE
			current_x_pos += TAB
			return TRUE
		AddLineBreak()
			current_y_pos += Font.height + Font.line_height_offset
			if(current_x_pos > highest_width_reached) highest_width_reached = current_x_pos
			if(max_height != -1 && current_y_pos > max_height)
				current_y_pos -= Font.height + Font.line_height_offset
				if(first_line_break) {height_reached += Font.height + Font.line_height_offset; first_line_break = FALSE}
				return FALSE
			current_x_pos = 0
			height_reached += Font.height + Font.line_height_offset
			if(first_line_break) {height_reached += Font.height + Font.line_height_offset; first_line_break = FALSE}
			return TRUE
		ForceAddLetter(var/letter="")
			var/current_letter_width
			if(Font.mode == MONOSPACE) current_letter_width = Font.width
			else current_letter_width = Font.getLetterWidth(letter)
			var/obj/char = new
			char.icon = Font.icon
			char.icon_state = letter
			char.pixel_x = current_x_pos
			char.pixel_y = -1 * current_y_pos
			char.layer = LAYER
			current_x_pos += current_letter_width
			overlay_object.overlays.Add(char)
			return TRUE



left_overs
	var/more_text = ""

TextWriter
	var/list/cache
	var/current_color = "null"
	var/icon/current_icon
	proc
		WrapText(var/text, TextFont/Font, Width)
			var/result = ""
			var/f = TRUE
			for(var/t in dd_text2list(text, LINEBREAK_CHAR))
				result += WordWrap(t, Font, Width)
				if(!f) {result += LINEBREAK_CHAR}
				else f = FALSE
			return result
		WordWrap(var/text, TextFont/Font, Width)
			var/result = ""
			var/current_line_width = 0
			for(var/word in dd_text2list(text, SPACE_CHAR))
				var/word_width = GetWordSize(word + SPACE_CHAR, Font)
				if(Width > word_width && word_width + current_line_width >= Width)
					result += LINEBREAK_CHAR
					current_line_width = 0
				result += word + SPACE_CHAR
				current_line_width += word_width
			return result
		GetWordSize(var/word, var/TextFont/Font)
			var/f = findtext(word, "\[&")
			var/_s = 1
			while(f)
				var/e = findtext(word, "]", f)
				if(e)
		//			var/kw = copytext(word, f+2, f+2+5)
		//			world<<"Key Word: [kw]"
					word = copytext(word, 1, f)+copytext(word, e + 1)
				else
					_s = f + 8
				f = findtext(word, "\[&", _s)

			var/width = 0
			for(var/i=1; i<= length(word); i++)
				var/char = ascii2text(text2ascii(word, i))
				var/char_width = Font.getLetterWidth(char)
				width += char_width
			return width

		changeColor(var/text, var/start, var/TextFont/F)
			var/T = copytext(text, start+1)
			if(copytext(T, 1, 7) == "color=")
				var/end = findtext(T, "]")
				if(!end) return -1
				var/Col = copytext(T, 7, end)
				current_icon = F.getColor(Col)
				return end+1
			return -1

		WriteText(var/text, TextFont/font, var/maxWidth=-1, var/maxHeight=-1,
		var/text_layer = EFFECTS_LAYER+52, var/word_wrap = FALSE, var/left_overs/leftover)

			var/generated_id = "WriteText: %[word_wrap][text]%[font.mode]%[font.width]%[font.height]%[font.space_width]%[font.line_height_offset]%[text_layer]%[maxWidth]%[maxHeight]"

			if(!cache || !cache.Find(generated_id))
				current_color = "null"
				current_icon = font.getColor(current_color)
				var/TemporaryTextHolder/TEMP = new
				if(word_wrap)
					text = WrapText(text, font, maxWidth)
				//Initialize temporary holder.
				TEMP.overlay_object = new
				TEMP.max_width = maxWidth
				TEMP.max_height = maxHeight
				TEMP.Font = font
				TEMP.LAYER = text_layer
				//End temporary holder initialize.

				var/break_i = 1
				var/length = length(text)
				for(var/i=1; i<= length; i++)
					break_i = i
					var/currentCharacter = ascii2text(text2ascii(text, i))
					if(currentCharacter == "\[")
						if(i+1 < length)
							if(ascii2text(text2ascii(text, i+1)) == "&")
								var/n = changeColor(text, i+1, font)
								if(n != -1) {i += n; continue;}
					if(currentCharacter == TAB_CHAR)
						if(TEMP.AddTab()) continue
						else break
					if(currentCharacter == LINEBREAK_CHAR)
						if(TEMP.AddLineBreak()) continue
						else break
					if(!TEMP.AddLetter(currentCharacter, current_icon)) break
				if(leftover && break_i < length(text))
					if(!cache) cache = list()
					leftover.more_text = copytext(text, break_i)
					var/c_text = "LEFTOVER-[generated_id]"
					cache.Add( c_text )
					cache[c_text] = leftover.more_text

				if(TEMP.first_line_break) {TEMP.height_reached += font.height + font.line_height_offset; TEMP.first_line_break = FALSE}
				var/TextObjectInfoHolder/TOIH = new
				TOIH.Text = text
				TOIH.Height = TEMP.height_reached//TEMP.highest_height_reached + TEMP.Font.height
				TOIH.Width = TEMP.highest_width_reached
				TOIH.Overlay = TEMP.overlay_object
				if(!cache) cache = list()
				cache.Add(generated_id)
				cache[generated_id] = TOIH


			var/TextObject/ReturnObject = new
			ReturnObject.Copy(cache[generated_id])
			if(leftover)
				var/c_text = "LEFTOVER-[generated_id]"
				if(cache.Find(c_text)) leftover.more_text = cache[c_text]
			return ReturnObject

WordGroupHandler
	var/WordGroup/group
	var/TextFont/font
	var/current_size = 0
	var/x = 0
	var/y = 0
	proc
		feed(word)
			var/TextObject/Word = TextWriter.WriteText(word, font, -1, -1)
			return Word

WordWriter
	var/list/cache = list()
	proc
		getWordGroup(var/text, TextFont/font, var/maxWidth=-1, var/maxHeight=-1,
		var/text_layer = EFFECTS_LAYER, var/word_wrap = FALSE)

	proc
		//This recieves the word object and the word that it represents.
		//With this you can get some interesting things such as the link processing.
		processWord(var/obj/O, var/word)
			O = getLink(O)
			return O
		getLink(var/obj/O, var/word)
			if(copytext(word, 1, 8) == "http://")
				if(!cache.Find(word))
					var/ScreenTextLink/LINK = new/ScreenTextLink(O, word)
					cache.Add(word)
					cache[word] = LINK
				return cache[word]
			else
				return O

WordGroup
	var/list/words
	var/height
	var/width

	proc
		/*
		Will give all of the objects a screen loc
		based on the location provided and
		*/
		screen(var/x, var/y, var/xo, var/yo)
			for(var/HUD/h in words)
				h.setScreenX(x)
				h.setScreenY(y)
				h.setScreenOX(xo + h.pixel_x)
				h.setScreenOY(yo + h.pixel_y)



ScreenTextLink
	parent_type = /obj
	var/link
	New(var/obj/O, var/l)
		..()
		link = l
		overlays.Add(O)
	Click()
		..()
		usr << link(link)

var/TextWriter/TextWriter = new
var/TextFont/Default/DefaultFont = new
var/TextFont/Fade/FadeFont = new
var/TextFont/Chat/ChatFont = new

/////////////////

proc
	dd_text2list(text, separator)
		var/textlength      = lentext(text)
		var/separatorlength = lentext(separator)
		var/list/textList   = new /list()
		var/searchPosition  = 1
		var/findPosition    = 1
		var/buggyText
		while (1)															// Loop forever.
			findPosition = findtext(text, separator, searchPosition, 0)
			buggyText = copytext(text, searchPosition, findPosition)		// Everything from searchPosition to findPosition goes into a list element.
			textList += "[buggyText]"										// Working around weird problem where "text" != "text" after this copytext().

			searchPosition = findPosition + separatorlength					// Skip over separator.
			if (findPosition == 0)											// Didn't find anything at end of string so stop here.
				return textList
			else
				if (searchPosition > textlength)							// Found separator at very end of string.
					textList += ""											// So add empty element.
					return textList