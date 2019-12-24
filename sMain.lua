--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local function setInfosAtStart()
    setGameType(settings.general.servername.." v."..settings.general.scriptversion.."")
	setMapName(settings.general.servername.." v."..settings.general.scriptversion.."")
	setServerPassword("ttt")
	
	for _,v in pairs(getElementsByType("player"))do
		if(isLoggedin(v))then
			setElementData(v,"ElementClicked",false)
			setElementData(v,"Loggedin",0)
		end
	end
	setFPSLimit(64)
	setGlitchEnabled("fastsprint",false)
end
addEventHandler("onResourceStart",resourceRoot,setInfosAtStart)
setTimer(setInfosAtStart,1000,1)

function dontHoldWeapon()
	source:setWeaponSlot(0)
end

function changeServerSlots(player,cmd,amount)
	if(isLoggedin(player))then
		if(tonumber(syncGetElementData(player,"AdminLvL"))>=5)then
			setMaxPlayers(tonumber(amount))
			setServerConfigSetting("maxplayers",amount,true)
		end
	end
end
addCommandHandler("setslots",changeServerSlots)

function executeAdminServerCMD_func(cmd,arguments)
	executeCommandHandler(cmd,client,arguments)
end
addEvent("executeAdminServerCMD",true)
addEventHandler("executeAdminServerCMD",root,executeAdminServerCMD_func)

addEventHandler("onPlayerChangeNick",root,function()
	cancelEvent()
end)

--//Loadingscreen
function fadeElementInterior(player,x,y,z,rot,int,dim,frozen)
	if(player and isElement(player)and getElementType(player)=="player")then
		if(getElementData(player,"intchange")==false)then
			setElementData(player,"intchange",true)
			triggerClientEvent(player,"draw:loadingscreen",player)
			
			if(frozen==true)then
				player:setFrozen(true)
				setTimer(setElementFrozen,3200,1,player,false)
			end
			
			setTimer(function()
				if(x)and(y)and(z)and(int)and(dim)and(rot)then
					player:setPosition(x,y,z)
					player:setInterior(int)
					player:setDimension(dim)
					player:setRotation(0,0,rot)
					setElementData(player,"intchange",false)
					hasPlayerPizza(player)
				end
			end,3000,1)
		end
	end
end

function timebanPlayer(pname,time,admin,reason)
	local player=getPlayerFromName(pname)
	
	if(pname)then
		local sec=getTBanSecTime(time)
		local serial=dbPoll(dbQuery(handler,"SELECT ?? FROM ?? WHERE ??=?","Serial","userdata","Username",pname),-1)[1]["Serial"]
		
		handler:exec("INSERT INTO ?? (??,??,??,??,??) VALUES (?,?,?,?,?)","userbans","Username","Admin","Reason","Serial","Time",pname,admin,reason,serial,sec)
		outputChatBox("[ADMIN]: Spieler "..pname.." wurde von "..admin.." für "..time.." gebannt! (Grund: "..tostring(reason)..")",root,255,0,0)
		
		if(isElement(player))then
			kickPlayer(player,"Du wurdest für "..time.." Stunden von "..admin.." gebannt! (Grund: "..reason..")")
		end
		return true
	end
	return false
end

function giveVehicleSpecialUpgrade(veh)
	local vehmodel=getElementModel(veh)
	local thisveh=getOriginalHandling(vehmodel)
	
	local sportmotor=getElementData(veh,"Sportmotor")
	if(sportmotor and sportmotor>=1)then
		setVehicleHandling(veh,"maxVelocity",thisveh["maxVelocity"]+30/3*sportmotor)
		setVehicleHandling(veh,"engineAcceleration",thisveh["engineAcceleration"]/thisveh["maxVelocity"]*(thisveh["maxVelocity"]+100/3*sportmotor))
		setVehicleHandling(veh,"engineInertia",thisveh["engineInertia"]/thisveh["maxVelocity"]*(thisveh["maxVelocity"]+100/3*sportmotor))
	end
	
	local lowering=getElementData(veh,"Lowering")
	if(lowering and lowering>=1)then
		setVehicleHandling(veh,"suspensionLowerLimit",thisveh["suspensionLowerLimit"]+0.05*lowering)
	end
end


local rdmpw=math.random(100000,999999)
setTimer(function()
	local time=getRealTime()
	local hour=time.hour
	local minute=time.minute
	local weekday=time.weekday+1
	
	if(hour==06 and minute==01)then
		outputChatBox("INFO: Server wurde erfolgreich neugestartet!",root,0,200,0)
		if(weekday==07)then
			handler:exec("UPDATE ?? SET ??=?","factiontags","Owner",0)
			handler:exec("UPDATE ?? SET ??=?","userdata","Weeklytime",0)
		end
	elseif(hour==06 and minute==00)then
		--handler:exec("TRUNCATE TABLE DAILYREWARD")
		if(settings.general.christmas==false)then
			handler:exec("UPDATE ?? SET ??=? WHERE ??=?","usersettings","Snowshader",1,"Snowshader",2)
		end
		for _,v in pairs(getElementsByType("player"))do
			if(isLoggedin(v))then
				RegisterLogin_saveDatas(v)
				setElementData(v,"ElementClicked",false)
				setElementData(v,"Loggedin",0)
				setElementData(v,"team",nil)
				local rdm=math.random(1000,9999)
				setPlayerName(v,"Lakeside:RP_User_"..rdm)
			end
		end
		getThisResource():restart()
		setServerPassword("")
	elseif(hour==05 and minute==59)then
		outputChatBox("WARNUNG: Serverrestart in 1 Minute!",root,200,0,0)
	elseif(hour==05 and minute==58)then
		setServerPassword(rdmpw)
		outputChatBox("WARNUNG: Serverrestart in 2 Minuten!",root,200,0,0)
	elseif(hour==05 and minute==57)then
		outputChatBox("WARNUNG: Serverrestart in 3 Minuten!",root,200,0,0)
	elseif(hour==05 and minute==56)then
		outputChatBox("WARNUNG: Serverrestart in 4 Minuten!",root,200,0,0)
	elseif(hour==05 and minute==55)then
		outputChatBox("WARNUNG: Serverrestart in 5 Minuten!",root,200,0,0)
	elseif(hour==05 and minute==50)then
		outputChatBox("WARNUNG: Serverrestart in 10 Minuten!",root,200,0,0)
	elseif(hour==05 and minute==45)then
		outputChatBox("WARNUNG: Serverrestart in 15 Minuten!",root,200,0,0)
	end
	updateServerTime()
end,55*1000,0)

function updateServerTime()
	local time=getRealTime()
	local hour=time.hour
	local minute=time.minute
	
	setTime(hour,minute)
end
addEventHandler("onResourceStart",resourceRoot,updateServerTime)

local FactionBlips={}
function updateFactionBlip(player)
	local faction=tonumber(syncGetElementData(player,"Faction"))
	if(isElement(FactionBlips[player]))then
		FactionBlips[player]:destroy()
	end
	
	if(isGROVE(player))then
		FactionBlips[player]=createBlip(2495.4,-1689.6,14.5,32,2,255,255,255,255,0,350,player)
	end
	if(isBALLAS(player))then
		FactionBlips[player]=createBlip(2248.7,-1401.3,24,32,2,255,255,255,255,0,350,player)
	end
	if(isVAGOS(player))then
		FactionBlips[player]=createBlip(2887.7,-2144.6,4.3,32,2,255,255,255,255,0,350,player)
	end
end



aktionlaeuft=false

aktionpuffer=5*60*1000
timeTillDrogentruckDisappears=20*60*1000
timeTillAservatentruckDisappears=20*60*1000
timeTillMatstruckDisappears=20*60*1000