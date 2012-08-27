mob
	var
		Username
		Password
		ID
mob/new_client
	verb
		switch_login_reg() // <--- Used to toggle between the login and register panes.
			set hidden = 1
			var/log_reg = winget(src, "log_reg_window.log_reg_child","left")

			if(log_reg == "log_pane") // <--- They're on the login screen.
				winset(src, null, "log_pane.error.text=\"\"")
				winset(src, null, "log_reg_window.log_reg_child.left=\"reg_pane\"")

			else // <--- They're on the register screen.
				winset(src, null, "reg_pane.error.text=\"\"")
				winset(src, null, "log_reg_window.log_reg_child.left=\"log_pane\"")

		register_to_server()
			set hidden = 1
			var/user = winget(src, "reg_pane.UsernameIn", "text")
			var/pass = winget(src, "reg_pane.PasswordIn", "text")
			if(!user || !length(user))
				winset(src,null,"reg_pane.error.text=\"No username entered.\"");return
			if(!pass || !length(pass))
				winset(src,null,"reg_pane.error.text=\"No password entered.\"");return
			if(user in global.accounts)
				winset(src,null,"reg_pane.error.text=\"This username in use!\"");return
			else global.accounts += user
			global.accountspass += pass
			global.accountsid += (length(global.accountsid) + 1)
			Save_Account_Database()
			src.Username = user
			src.Password = pass
			src.ID = length(global.accountsid)
			src.connected = 1
			src.client.screen -= title_screen
			winset(src, "main_splitter","left=map_window;right=")
			winset(src, "main_window","macro=macro")
			src.load_account()

		login_to_server()
			set hidden = 1
			var/user = winget(src, "log_pane.UsernameIn", "text")
			var/pass = winget(src, "log_pane.PasswordIn", "text")
			if(!user || !length(user))
				winset(src,null,"log_pane.error.text=\"No username entered.\"");return
			if(!pass || !length(pass))
				winset(src,null,"log_pane.error.text=\"No password entered.\"");return
			var/counter = 0
			var/found = 0

			if(global.accounts.Find(user))
				for(var/check = 0 to length(global.accounts))
					counter++
					if(user == global.accounts[counter])
						found = 1
						break

			if(!found)
				winset(src,null,"log_pane.error.text=\"Username not found.\"");return
			if(!(pass == global.accountspass[counter]))
				winset(src,null,"log_pane.error.text=\"Wrong Password.\"");return
			src.Username = global.accounts[counter]
			src.Password = global.accountspass[counter]
			src.ID = global.accountsid[counter]
			if(src.ID in global.idbanlist)
				alert("This account is banned from the game.")
				del src
			src.connected = 1
			src.client.screen -= title_screen
			winset(src, "main_splitter","left=map_window;right=")
			winset(src, "main_window","macro=macro")
			src.load_account()

var
	list/accounts = list("Kumorii")
	list/accountspass = list("password")
	list/accountsid = list(1)
	list/idbanlist = list()
	list/idmutelist = list()

proc
	Save_Account_Database()
		if(fexists("Account_Database.sav"))	fdel("Account_Database.sav")
		var/savefile/F=new("Account_Database.sav")
		F["accounts"] << global.accounts
		F["accountspass"] << global.accountspass
		F["accountsid"] << global.accountsid
		F["idbanlist"] << global.idbanlist
		F["idmutelist"] << global.idmutelist

	Load_Account_Database()
		if(fexists("Account_Database.sav"))
			var/savefile/S=new("Account_Database.sav")
			S["accounts"] >> global.accounts
			S["accountspass"] >> global.accountspass
			S["accountsid"] >> global.accountsid
			S["idbanlist"] >> global.idbanlist
			S["idmutelist"] >> global.idmutelist


gm
	parent_type = /obj
	verb
		Ban_ID()
			var/IDGrab = input("Type a valid ID to ban")as num
			if(!(IDGrab in global.accountsid))	return
			idbanlist += IDGrab
			world << "ID - [IDGrab] Has been banned, the details of the account are the following:"
			world << "	-Username: [global.accounts[(IDGrab)]]"
			world << "	-Password: [global.accountspass[(IDGrab)]]"
			Save_Account_Database()

		Mute_ID()
			var/IDGrab = input("Type a valid ID to mute")as num
			if(!(IDGrab in global.accountsid))	return
			if(IDGrab in global.idmutelist)
				idmutelist -= IDGrab;
				world << "ID - [IDGrab] Has been unmuted."
			else
				idmutelist += IDGrab
				world << "ID - [IDGrab] Has been muted."
			Save_Account_Database()

		Check_ID_Information()
			var/IDGrab = input("Type a valid ID to Check it's information")as num
			if(!(IDGrab in global.accountsid))	return
			world << "Checking ID - [IDGrab], the details of the account are the following:"
			var/Account = global.accounts[(IDGrab)]
			var/AccountPass = global.accountspass[(IDGrab)]
			world << "	-Username: [Account]"
			world << "	-Password: [AccountPass]"

		Admin_ID_Password_Change()
			var/IDGrab = input("Type a valid ID to Check it's information")as num
			if(!(IDGrab in global.accountsid))	return
			var/CurrentPass = input("What is the ID's current password? - This is for the owner to varify it belongs to them.")
			if(!(CurrentPass == global.accountspass[(IDGrab)]))	return
			var/NewPass = input("Password Varified! Please input the accounts new password.")
			global.accountspass[(IDGrab)] = NewPass
			alert("Password changed.")
			Save_Account_Database()

