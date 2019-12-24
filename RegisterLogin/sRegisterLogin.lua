--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local registerloginTable={
	["christmas"]={
		"Adventstate1","Adventstate2","Adventstate3","Adventstate4","Adventstate5","Adventstate6","Adventstate7","Adventstate8","Adventstate9","Adventstate10","Adventstate11","Adventstate12","Adventstate13","Adventstate14","Adventstate15","Adventstate16","Adventstate17","Adventstate18","Adventstate19","Adventstate20","Adventstate21","Adventstate22","Adventstate23","Adventstate24"
	},
	["inventory"]={
		"Apfel","Burger","Pizza","Zuckerstange","Cola","Ausweis","ChestWood","ChestIron","TicketBronze","TicketSilver","TicketGold","Repairkit","Kokain","Weed","Mats","Hanfsamen","Apfelsamen","Zigarette","Mobilephone","Fahrzeugschlüssel","Weste","Spitzhacke","Mondstein","Geschenk","Fishingrod","Fishinghook","Köder","Forelle","Benzinkanister","Barrikade","Brechstange","Tablet"
	},
	["userdata"]={
		"BirthDate","Gender","AdminLvL","Faction","Factionrank","Company","Companyrank","Money","Bankmoney","Jobmoney","Armor","Health","Job","Hunger","SpawnX","SpawnY","SpawnZ","SpawnROT","SpawnINT","SpawnDIM","SkinID","Playtime","Weeklytime","Mutedtime","Jailtime","Vehicleslots","Housekey","Task","Bankpin","Telenr","Wanteds","IntroCompleted","CarLicense","BikeLicense","CarLicensePoints","BikeLicensePoints","GunLicense","Note"
	},
	["userlevel"]={
		"Joblevel","Jobexp"
	},
	["usersettings"]={
		"PhoneModel","PhoneBackground","PhoneState","Autologin","Radar","Snowshader","Blurshader","Hitglocke","PhoneRightone"
	},
	["userstats"]={
		"Kills","Deaths","GangwarRounds","GangwarWins","GangwarLoses","GangwarKills","GangwarDeaths","GangwarDamageGemacht","GangwarDamageBekommen"
	},
	["notallowedcaracter"]={"!","_","§","$","%","&","/","@","(",")",".","'","=","?","´","`","#","*","#","°","^","<",">","{","}",";",":","|","[","]","none"},
}

function Register_Func(username,password,email,gender,bmonth,bday,byear)
    local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","userdata","Serial",getPlayerSerial(client)),-1)
    if(not result or not result[1])then
        local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","userdata","Username",username),-1)
        if(not result or not result[1])then
			local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","userdata","Email",email),-1)
			if(not result or not result[1])then
				local time=getRealTime()
				local year=time.year+1900
				local month=time.month+1
				local day=time.monthday
				local hour=time.hour
				local minute=time.minute
				
				if(day<10)then
					day="0"..day
				end
				if(month<10)then
					month="0"..month
				end
				if(year<10)then
					year="0"..year
				end
				if(bday<10)then
					bday="0"..bday
				end
				if(bmonth<10)then
					bmonth="0"..bmonth
				end
				if(byear<10)then
					byear="0"..byear
				end
				
				for _,v in ipairs(registerloginTable["notallowedcaracter"])do
					if(string.find(username,v,1,true))then
						if(string.lower(username,v,1,true))then
							triggerClientEvent(client,"draw:infobox",root,"error","Es sind keine Sonderzeichen erlaubt!")
							return false
						end
					end
				end
				
				setPlayerName(client,username)
				setPlayerName(client,username)
				setPlayerName(client,username)
				
				local LakeHash=md5(hash("sha512",password))
				local pname=getPlayerName(client)
				local pserial=getPlayerSerial(client)
				
				local IDcounter=dbPoll(dbQuery(handler,"SELECT ?? FROM ?? WHERE UID=UID","UID","globalcounter"),-1)[1]["UID"]
				handler:exec("UPDATE ?? SET ??=?","globalcounter","UID",IDcounter+1)
				playerUID[pname]=IDcounter
				local BirthDate=tostring(bday.."."..bmonth.."."..byear)
				local RegisterDate=tostring(day.."."..month.."."..year..", "..hour..":"..minute)
				
				handler:exec("INSERT INTO christmas (UID,Username) VALUES (?,?)",IDcounter,pname)
				handler:exec("INSERT INTO inventory (UID,Username,Apfel,Burger,Pizza,Zuckerstange,Cola,Ausweis,ChestWood,ChestIron,TicketBronze,TicketSilver,TicketGold,Repairkit,Kokain,Weed,Mats,Hanfsamen,Apfelsamen,Zigarette,Mobilephone,Fahrzeugschlüssel,Weste,Spitzhacke,Mondstein,Geschenk,Fishingrod,Fishinghook,Köder,Forelle,Benzinkanister,Barrikade,Brechstange,Tablet) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",IDcounter,pname,'0','5','5','0','5','0','0','0','1','0','0','0','0','0','0','0','0','0','0','1','0','0','0','0','0','0','0','0','0','0','0','0')
				handler:exec("INSERT INTO userdata (UID,Username,Serial,Password,Email,RegisterDate,LastLoginDate,BirthDate,Gender,AdminLvL,Faction,Factionrank,Company,Companyrank,Money,Bankmoney,Jobmoney,Armor,Health,Job,Hunger,SpawnX,SpawnY,SpawnZ,SpawnROT,SpawnINT,SpawnDIM,SkinID,Playtime,Weeklytime,Mutedtime,Jailtime,Vehicleslots,Housekey,Task,Bankpin,Telenr,Wanteds,IntroCompleted,CarLicense,BikeLicense,CarLicensePoints,BikeLicensePoints,GunLicense,Note) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",IDcounter,pname,pserial,LakeHash,email,RegisterDate,RegisterDate,BirthDate,gender,'0','0','0','0','0','5000','10000','0','0','100','none','100','1769.9','-1867.3','13.6','0','0','0','0','0','0','0','0','2','0','1','0','0','0','0','0','0','0','0','0','0')
				handler:exec("INSERT INTO userlevel (UID,Username,Joblevel,Jobexp) VALUES (?,?,?,?)",IDcounter,pname,'0','0')
				handler:exec("INSERT INTO usersettings (UID,Username,PhoneModel,PhoneBackground,PhoneState,Autologin,Radar,Snowshader,Blurshader,Hitglocke,PhoneRightone) VALUES (?,?,?,?,?,?,?,?,?,?,?)",IDcounter,pname,'1','1','0','1','1','1','2','1','1')
				handler:exec("INSERT INTO userstats (UID,Username,Kills,Deaths,GangwarRounds,GangwarWins,GangwarLoses,GangwarKills,GangwarDeaths,GangwarDamageGemacht,GangwarDamageBekommen) VALUES (?,?,?,?,?,?,?,?,?,?,?)",IDcounter,pname,'0','0','0','0','0','0','0','0','0')
				
				--//Other
				setElementFrozen(client,false)
				RegisterLogin_setDatas(client)
				triggerClientEvent(client,"open:skinselector",client)
			else
				triggerClientEvent(client,"draw:infobox",root,"error","Diese E-Mail ist bereits vergeben!")
			end
        else
			triggerClientEvent(client,"draw:infobox",root,"error","Dieser Benutzername ist bereits vergeben!")
		end
	else
		triggerClientEvent(client,"draw:infobox",root,"error","Es ist nur 1 Account pro Serial gestattet! (Alter name: ".. result[1]["Username"] ..")")
    end
end
addEvent("account:register",true)
addEventHandler("account:register",root,Register_Func)

function Login_Func(username,password)
	local LakeHash=md5(hash("sha512",password))
	local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=? AND ??=?","userdata","Username",username,"Password",LakeHash),-1)
	if(result and result[1])then
	setPlayerName(client,username)
		local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","userdata","UID",playerUID[getPlayerName(client)]),-1)
		if(result and result[1])then
			RegisterLogin_setDatas(client)
			triggerClientEvent(client,"destroy:login",client)
		end
	else
		triggerClientEvent(client,"draw:infobox",root,"error","Die Benutzername/Passwort Kombination ist falsch!")
	end
end
addEvent("account:login",true)
addEventHandler("account:login",root,Login_Func)

function checkAccount()
	local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","userdata","Serial",getPlayerSerial(client)),-1)
	if(#result>=1)then
		triggerClientEvent(client,"open:registerlogin",client,"Login")
	else
		triggerClientEvent(client,"open:registerlogin",client,"Register")
	end
end
addEvent("check:account",true)
addEventHandler("check:account",root,checkAccount)

function RegisterLogin_setDatas(player)
	local pname=getPlayerName(player)
	local time=getRealTime()
	local year=time.year+1900
	local month=time.month+1
	local day=time.monthday
	local hour=time.hour
	local minute=time.minute
	
	if(hour<10)then
		hour="0"..hour
	end
	if(minute<10)then
		minute="0"..minute
	end
	if(month<10)then
		month="0"..month
	end
	if(day<10)then
		day="0"..day
	end
	
	local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","userdata","UID",playerUID[pname]),-1)
	if(result and result[1])then
		setCameraTarget(player,player)
		
		for i=1,#registerloginTable["christmas"] do
			syncSetElementData(player,registerloginTable["christmas"][i],getData("christmas","UID",playerUID[pname],registerloginTable["christmas"][i]))
		end
		
		for i=1,#registerloginTable["userdata"] do
			syncSetElementData(player,registerloginTable["userdata"][i],getData("userdata","UID",playerUID[pname],registerloginTable["userdata"][i]))
		end
		
		for i=1,#registerloginTable["userlevel"] do
			syncSetElementData(player,registerloginTable["userlevel"][i],getData("userlevel","UID",playerUID[pname],registerloginTable["userlevel"][i]))
		end
		
		for i=1,#registerloginTable["usersettings"] do
			syncSetElementData(player,registerloginTable["usersettings"][i],getData("usersettings","UID",playerUID[pname],registerloginTable["usersettings"][i]))
		end
		
		for i=1,#registerloginTable["userstats"] do
			syncSetElementData(player,registerloginTable["userstats"][i],getData("userstats","UID",playerUID[pname],registerloginTable["userstats"][i]))
		end
		
		for i=1,#registerloginTable["inventory"] do
			syncSetElementData(player,registerloginTable["inventory"][i],getData("inventory","UID",playerUID[pname],registerloginTable["inventory"][i]))
		end
		
		local resulthouse=dbPoll(dbQuery(handler,"SELECT ?? FROM ?? WHERE ??=?","ID","houses","Owner",pname),-1)
		local Housekey=resulthouse[1] and resulthouse[1]["ID"] or false
		local key=getData("userdata","Username",pname,"Housekey")
		if(Housekey)then
			syncSetElementData(player,"Housekey",Housekey)
		elseif(key<=0)then
			syncSetElementData(player,"Housekey",key)
		else
			syncSetElementData(player,"Housekey",0)
		end
		
		if(isElement(houses["pickup"][getPlayerName(player)]))then
			local x,y,z=getElementPosition(houses["pickup"][getPlayerName(player)])
			houseBlip=createBlip(x,y,z,31,2,255,0,0,255,0,99999,player)
		end
		if(syncGetElementData(player,"Snowshader")==2)then
			triggerClientEvent("switchGoundSnow",player,true)
		else
			triggerClientEvent("switchGoundSnow",player,false)
		end
		if(settings.general.christmas==false)then
			if(syncGetElementData(player,"Snowshader")==2)then
				syncSetElementData(player,"Snowshader",1)
				triggerClientEvent("switchGoundSnow",player,false)
			end
		end
		if(syncGetElementData(player,"Blurshader")==1)then
			setPlayerBlurLevel(player,0)
		elseif(syncGetElementData(player,"Blurshader")==2)then
			setPlayerBlurLevel(player,36)
		end
		
		setElementData(player,"seatbelt",false)
		setElementData(player,"fishingstate",false)
		setElementData(player,"tazer",false)
		setElementData(player,"inRocket",false)
		setElementData(player,"inReport",false)
		setElementData(player,"onTheMoon",false)
		setElementData(player,"tied",false)
		setElementData(player,"inpruefung",false)
		setElementData(player,"infahrpruefung",false)
		setElementData(player,"tied",false)
		setElementData(player,"plantstate",false)
		setElementData(player,"AFK",false)
		syncSetElementData(player,"CopDuty",false)
		syncSetElementData(player,"MechTowDuty",false)
		syncSetElementData(player,"DrivingschoolDuty",false)
		syncSetElementData(player,"RescueDuty",false)
		setElementData(player,"ElementClicked",false)
		setElementData(player,"adminduty",false)
		setElementData(player,"InTuninggarage",false)
		setElementData(player,"InPTuninggarage",false)
		setElementData(player,"ImBusjob",false)
		setElementData(player,"Loggedin",1)
		setElementData(player,"call",false)
		setElementData(player,"callswith","none")
		toggleAllControls(player,true)
		RegisterLogin_spawn(player)
		jailCheck(player)
		startPaydayPlayerTimer(player)
		startHungerPlayerTimer(player)
		loadVehicles(getPlayerName(player))
		refreshWeather(player)
		loadGangtagTextures(player)
		checkOfflineMSG(player)
		updateFactionBlip(player)
		setPedStat(player,22,500)
		setPedStat(player,69,900)
		setPedStat(player,70,999)
		setPedStat(player,71,999)
		setPedStat(player,72,999)
		setPedStat(player,73,999)
		setPedStat(player,74,999)
		setPedStat(player,75,999)
		setPedStat(player,76,999)
		setPedStat(player,77,999)
		setPedStat(player,78,999)
		setPedStat(player,79,999)
		setPedStat(player,160,999)
		setPedStat(player,229,999)
		setPedStat(player,230,999)
		--[[if(syncGetElementData(player,"Gender")=="Male")then
			setPedWalkingStyle(player,118)
		elseif(syncGetElementData(player,"Gender")=="Female")then
			setPedWalkingStyle(player,129)
		end]]
		
		setPedArmor(player,getData("userdata","Username",pname,"Armor"))
		setElementHealth(player,getData("userdata","Username",pname,"Health"))
		if(tonumber(syncGetElementData(player,"Faction"))~=0)then
			loadFactionVehicles(tonumber(syncGetElementData(player,"Faction")))
		end
		if(tonumber(syncGetElementData(player,"Company"))~=0)then
			loadCompanyVehicles(tonumber(syncGetElementData(player,"Company")))
		end
		
		if(tonumber(syncGetElementData(player,"Task"))==1)then
			outputChatBox("WARNUNG: Folge dem Aufgabensystem, bevor du was anderes machst!",player,255,0,0)
			outputChatBox("WARNUNG: Folge dem Aufgabensystem, bevor du was anderes machst!",player,255,0,0)
			outputChatBox("WARNUNG: Folge dem Aufgabensystem, bevor du was anderes machst!",player,255,0,0)
		end
		
		local result=dbPoll(dbQuery(handler,"SELECT ?? FROM ?? WHERE ??=?","Weapons","userlogout","UID",playerUID[pname]),-1)
		if(result and result[1])then
			local weapons=result[1]["Weapons"]
			dbExec(handler,"DELETE FROM ?? WHERE ??=?","userlogout","UID",playerUID[pname])
			for i=1,12 do
				local wstring=gettok(weapons,i,string.byte("|"))
				if(wstring and #wstring>=3)then
					local weapon=tonumber(gettok(wstring,1,string.byte(",")))
					local ammo=tonumber(gettok(wstring,2,string.byte(",")))
					giveWeapon(player,weapon,ammo)
				end
			end
		end
		
		--bindKey(player,"b","down","chatbox","OOC")
		bindKey(player,"y","down","chatbox","Teamchat")
		bindKey(player,"1","down",changeTazerToDeagle_changeDeagleToTazer)
		if(not isKeyBound(player,",","down",lockVehicle))then
			bindKey(player,",","down",lockVehicle)
		end
		if(not isKeyBound(player,".","down",parkVehicle))then
			bindKey(player,".","down",parkVehicle)
		end
		if(not isKeyBound(player,"f","down",removePlant))then
			bindKey(player,"f","down",removePlant)
		end
		
		handler:exec("UPDATE ?? SET ??=? WHERE ??=?","userdata","LastloginDate",day.."."..month.."."..year..", "..hour..":"..minute,"Username",pname)
		
		triggerClientEvent(player,"draw:infobox",root,"success","Du hast dich erfolgreich eingeloggt!")
	end
end

function RegisterLogin_spawn(player)
	local pname=getPlayerName(player)
	local faction=tonumber(syncGetElementData(player,"Faction"))
	local company=tonumber(syncGetElementData(player,"Company"))
	if(faction~=0 and faction>=1)then
		local x,y,z,rot,int,dim=globalTables["Faction"][faction]["Spawn"][1],globalTables["Faction"][faction]["Spawn"][2],globalTables["Faction"][faction]["Spawn"][3],globalTables["Faction"][faction]["Spawn"][4],globalTables["Faction"][faction]["Spawn"][5],globalTables["Faction"][faction]["Spawn"][6]
		spawnPlayer(player,x,y,z,rot,getData("userdata","Username",pname,"SkinID"),int,dim)
		setElementHealth(player,getData("userdata","Username",pname,"Health"))
		setPedArmor(player,getData("userdata","Username",pname,"Armor"))
	elseif(company~=0 and company>=1)then
		local x,y,z,rot,int,dim=globalTables["Company"][company]["Spawn"][1],globalTables["Company"][company]["Spawn"][2],globalTables["Company"][company]["Spawn"][3],globalTables["Company"][company]["Spawn"][4],globalTables["Company"][company]["Spawn"][5],globalTables["Company"][company]["Spawn"][6]
		spawnPlayer(player,x,y,z,rot,getData("userdata","Username",pname,"SkinID"),int,dim)
		setElementHealth(player,getData("userdata","Username",pname,"Health"))
		setPedArmor(player,getData("userdata","Username",pname,"Armor"))
	else
		spawnPlayer(player,getData("userdata","Username",pname,"SpawnX"),getData("userdata","Username",pname,"SpawnY"),getData("userdata","Username",pname,"SpawnZ"),getData("userdata","Username",pname,"SpawnROT"),getData("userdata","Username",pname,"SkinID"),getData("userdata","Username",pname,"SpawnINT"),getData("userdata","Username",pname,"SpawnDIM"))
		setElementHealth(player,getData("userdata","Username",pname,"Health"))
		setPedArmor(player,getData("userdata","Username",pname,"Armor"))
	end
	setElementFrozen(player,false)
	jailCheck(player)
end

function RegisterLogin_saveDatas(player)
	if(isLoggedin(player))then
		local pname=getPlayerName(player)
		
		--//Christmas
		for i=1,#registerloginTable["christmas"] do
			handler:exec("UPDATE ?? SET ??=? WHERE ??=?","christmas",registerloginTable["christmas"][i],syncGetElementData(player,registerloginTable["christmas"][i]),"UID",playerUID[pname])
		end
		
		--//Userdata
		for i=1,#registerloginTable["userdata"] do
			handler:exec("UPDATE ?? SET ??=? WHERE ??=?","userdata",registerloginTable["userdata"][i],syncGetElementData(player,registerloginTable["userdata"][i]),"UID",playerUID[pname])
		end
		
		handler:exec("UPDATE userdata SET ??=?,??=? WHERE ??=?","Armor",getPedArmor(player),"Health",getElementHealth(player),"UID",playerUID[pname])
		
		--//Userlevel
		for i=1,#registerloginTable["userlevel"] do
			handler:exec("UPDATE ?? SET ??=? WHERE ??=?","userlevel",registerloginTable["userlevel"][i],syncGetElementData(player,registerloginTable["userlevel"][i]),"UID",playerUID[pname])
		end
		
		--//Usersettings
		for i=1,#registerloginTable["usersettings"] do
			handler:exec("UPDATE ?? SET ??=? WHERE ??=?","usersettings",registerloginTable["usersettings"][i],syncGetElementData(player,registerloginTable["usersettings"][i]),"UID",playerUID[pname])
		end
		
		--//Userstats
		for i=1,#registerloginTable["userstats"] do
			handler:exec("UPDATE ?? SET ??=? WHERE ??=?","userstats",registerloginTable["userstats"][i],syncGetElementData(player,registerloginTable["userstats"][i]),"UID",playerUID[pname])
		end
		
		--//Userinventory
		for i=1,#registerloginTable["inventory"] do
			handler:exec("UPDATE ?? SET ??=? WHERE ??=?","inventory",registerloginTable["inventory"][i],syncGetElementData(player,registerloginTable["inventory"][i]),"UID",playerUID[pname])
		end
		
		local x,y,z=getElementPosition(player)
		local rx,ry,rz=getElementRotation(player)
		local int=getElementInterior(player)
		local dim=getElementDimension(player)
		if(tonumber(syncGetElementData(player,"Faction"))==0 and tonumber(syncGetElementData(player,"Company"))==0 and tonumber(syncGetElementData(player,"Jailtime"))==0 and getElementData(player,"InTuninggarage")==false and getElementData(player,"InPTuninggarage")==false and getElementData(player,"onTheMoon")==false and getElementData(player,"inReport")==false)then
			if(not isPedDead(player))then
				if(x)and(y)and(z)and(rz)and(int)and(dim)then
					handler:exec("UPDATE ?? SET ??=?,??=?,??=?,??=?,??=?,??=? WHERE ??=?","userdata","SpawnX",x,"SpawnY",y,"SpawnZ",z,"SpawnROT",rz,"SpawnINT",int,"SpawnDIM",dim,"UID",playerUID[pname])
				end
			end
		end
		
	end
end

addEvent("check:autologin",true)
addEventHandler("check:autologin",root,function()
	local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","userdata","Serial",getPlayerSerial(client)),-1)
	if(result and result[1])then
		if(getData("userdata","Username",getPlayerName(client),"Serial")==getPlayerSerial(client))then
			if(getData("usersettings","Username",getPlayerName(client),"Autologin")==2)then
				RegisterLogin_setDatas(client)
				triggerClientEvent(client,"destroy:login",client)
				setElementFrozen(client,false)
			end
		end
	end
end)

addEventHandler("onPlayerJoin",root,function()
	
	setElementData(source,"Loggedin",0)
end)

addEventHandler("onPlayerQuit",root,function()
	local pname=getPlayerName(source)
	if(isLoggedin(source))then
		RegisterLogin_saveDatas(source)
		if(getElementData(source,"callswith"))then
			if(getElementData(source,"callswith")~="none")then
				local caller=getPlayerFromName(getElementData(source,"callswith"))
				if(caller)then
					setElementData(caller,"callswith","none")
					setElementData(caller,"call",false)
					setElementData(caller,"calls","none")
					setElementData(caller,"callswith","none")
					setElementData(caller,"calledby","none")
					outputChatBox("*Crack* - The line is dead!",caller,200,0,0)
				end
				setElementData(source,"callswith","none")
				setElementData(source,"call",false)
				setElementData(source,"calls","none")
				setElementData(source,"callswith","none")
				setElementData(source,"calledby","none")
			end
		end
		
		local curWeaponsForSave="|"
		for i=1,11 do
			if(i~=10)then
				local weapon=getPedWeapon(source,i)
				local ammo=getPedTotalAmmo(source,i)
				if(weapon and ammo)then
					if(weapon>=1 and ammo>=1)then
						if(#curWeaponsForSave<=40)then
							curWeaponsForSave=curWeaponsForSave..weapon..","..ammo.."|"
						end
					end
				end
			end
		end
		if(#curWeaponsForSave>=5)then
			handler:exec("INSERT INTO ?? (UID,Weapons) VALUES (?,?)","userlogout",playerUID[pname],curWeaponsForSave)
		end
		
	end
end)




addEvent("get:changelogs",true)
addEventHandler("get:changelogs",root,function()
	local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? ORDER BY SortID","changelogs"),-1)
	if(#result>=1)then
		local tbl={}
		for _,v in pairs(result)do
			table.insert(tbl,{v["Version"],v["Changes"]})
		end
		triggerClientEvent(client,"show:changelogs",client,tbl)
	end
end)