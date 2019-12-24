--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

function saveUserdata_Func(player)
local onlineplayercount=0
	if(isLoggedin(player))then
		if(tonumber(syncGetElementData(player,"AdminLvL"))>=4)then
			for _,v in ipairs(getElementsByType("player"))do
				RegisterLogin_saveDatas(v)
				onlineplayercount=onlineplayercount+1
			end
			triggerClientEvent(player,"draw:infobox",root,"info","Spielerdaten gespeichert! ("..onlineplayercount.." Spieler)")
		end
	end
end
addCommandHandler("sud",saveUserdata_Func)

function sendMSGForAdmins(text,r,g,b)
	if(not r and g and b)then
		r,g,b=255,255,255
	end
	for _,v in ipairs(getElementsByType("player"))do
		if isLoggedin(v)then
			if(getAdminLevel(v)>=1)then
				outputChatBox(text,v,r,g,b)
			end
		end
	end
end

function giveAdminlevel(player,cmd,kplayer,amount)
	if(isLoggedin(player))then
		if(tonumber(syncGetElementData(player,"AdminLvL"))>=5)then
			local target=getPlayerFromName(kplayer)
			if(amount)then
				if(target)then
					if(#amount<=5)then
						if(not isElement(target))then
							triggerClientEvent(player,"draw:infobox",root,"warning","Der Spieler ist offline!")
							return false
						end
						syncSetElementData(target,"AdminLvL",tonumber(amount))
						outputLog(getPlayerName(player).." hat das Adminlevel von "..getPlayerName(target).." auf "..tonumber(amount).." gesetzt","Adminsystem")
					end
				end
			end
		end
	end
end
addCommandHandler("giveadminlevel",giveAdminlevel)

function mutePlayer_Func(player,cmd,kplayer,time,...)
	if(isLoggedin(player))then
		if(tonumber(syncGetElementData(player,"AdminLvL"))>=1)then
			local reason={...}
			local reason=table.concat(reason," ")
			local target=getPlayerFromName(kplayer)
			if(#time>=1)then
				if(#reason>=3)then
					if(not isElement(target))then
						triggerClientEvent(player,"draw:infobox",root,"warning","Der Spieler ist offline!")
						return false
					end
					
					outputChatBox("[ADMIN]: "..getPlayerName(target).." wurde von "..getPlayerName(player).." gemuted! Grund: "..reason.." Zeit: "..time.."(Minuten)",root,255,0,0)
					outputLog(getPlayerName(target).." wurde von "..getPlayerName(player).." gemuted! Grund: "..reason.." Zeit: "..time.."(Minuten)","Adminsystem")
					if(tonumber(syncGetElementData(target,"Mutedtime"))>30000)then
						syncSetElementData(target,"Mutedtime",30000)
					else
						syncSetElementData(target,"Mutedtime",tonumber(syncGetElementData(target,"Mutedtime"))+time)
					end
				else
					triggerClientEvent(player,"draw:infobox",root,"error","Gebe einen Grund mit mehr als 3 Zeichen an!")
				end
			end
		end
	end
end
addCommandHandler("rmute",mutePlayer_Func)
function unMutePlayer_Func(player,cmd,kplayer)
	if(isLoggedin(player))then
		if(tonumber(syncGetElementData(player,"AdminLvL"))>=1)then
			local target=getPlayerFromName(kplayer)
			if(not isElement(target))then
				triggerClientEvent(player,"draw:infobox",root,"warning","Der Spieler ist offline!")
				return false
			end
			if(tonumber(syncGetElementData(target,"Mutedtime"))>=1)then
				outputChatBox("[ADMIN]: "..getPlayerName(target).." wurde von "..getPlayerName(player).." entmuted!",root,255,0,0)
				outputLog(getPlayerName(target).." wurde von "..getPlayerName(player).." entmuted!","Adminsystem")
				syncSetElementData(target,"Mutedtime",tonumber(0))
				triggerClientEvent(player,"draw:infobox",root,"success","Der Spieler ist nun nichtmehr gemuted!")
			else
				triggerClientEvent(player,"draw:infobox",root,"error","Der Spieler ist nicht gemuted!")
			end
		end
	end
end
addCommandHandler("runmute",unMutePlayer_Func)

function clearchat_Func(player)
	if(isLoggedin(player))then
		if(tonumber(syncGetElementData(player,"AdminLvL"))>=1)then
			for i=1,250 do
				outputChatBox(" ")
			end
			clearChatBox(root)
		end
	end
end
addCommandHandler("cc",clearchat_Func)
addCommandHandler("clearchat",clearchat_Func)

function adminList(player)
	if(isLoggedin(player))then
		for i,v in pairs(getElementsByType("player"))do
			if(isLoggedin(v))then
				if(tonumber(syncGetElementData(v,"AdminLvL"))>=1)then
					outputChatBox(getPlayerName(v)..", "..settings.admin.colorToHASH[syncGetElementData(v,"AdminLvL")]..""..settings.admin.levelnames[syncGetElementData(v,"AdminLvL")],player,255,255,255,true)
				end
			end
		end
	end
end
addCommandHandler("admins",adminList)
addCommandHandler("team",adminList)

local function rBan_Func(player,cmd,kplayer,...)
	if(tonumber(syncGetElementData(player,"AdminLvL"))>=3 and(not client or client==player))then
		if(kplayer)then
			local reason=table.concat({...}, " ")
			local target=getPlayerFromName(kplayer)
			if(#reason>=3)then
				if(not target)then
					if(kplayer)then
						local serial=dbPoll(dbQuery(handler,"SELECT ?? FROM ?? WHERE ??=?","Serial","userdata","Username",kplayer),-1)[1]["Serial"]
						outputChatBox("Der Spieler wurde gebannt! (offline)!",player,200,0,0)
						dbExec(handler,"INSERT INTO ?? (??,??,??,??) VALUES (?,?,?,?)","userbans","Username","Admin","Reason","Serial",kplayer,getPlayerName(player),reason,serial)
						outputLog(getPlayerName(target).." wurde von "..getPlayerName(player).." Permanent gebannt! (Grund: "..tostring(reason)..") (offline)","Adminsystem")
					else
						triggerClientEvent(player,"draw:infobox",root,"warning","Der Spieler ist offline!")
					end
				else
					local serial=getPlayerSerial(target)
					outputChatBox("[ADMIN]: "..getPlayerName(target).." wurde von "..getPlayerName(player).." Permanent gebannt! (Grund: "..tostring(reason)..")",root,255,0,0)
					dbExec(handler,"INSERT INTO ?? (??,??,??,??) VALUES (?,?,?,?)","userbans","Username","Admin","Reason","Serial",kplayer,getPlayerName(player),reason,serial)
					kickPlayer(target,player,tostring(reason).." (banned!)")
					outputLog(getPlayerName(target).." wurde von "..getPlayerName(player).." Permanent gebannt! (Grund: "..tostring(reason)..")","Adminsystem")
				end
			else
				triggerClientEvent(player,"draw:infobox",root,"error","Gebe einen Grund mit mehr als 3 Zeichen an!")
			end
		end
	end
end
addCommandHandler("rban",rBan_Func)
local function UnbanDB_Func(qh,player,kplayer) 
	local result=dbPoll(qh,0)
	if(result and result[1])then
		local name=result[1]["Username"]
		dbExec(handler,"DELETE FROM userbans WHERE Username LIKE ?",name)
		outputChatBox("[ADMIN]: "..getPlayerName(player).." hat "..kplayer.." entbannt!",root,200,0,0)
		outputLog(getPlayerName(player).." hat "..kplayer.." entbannt!","Adminsystem")
	end
end
function Unban_Func(player,cmd,kplayer)
	if(isLoggedin(player))then
		if(tonumber(syncGetElementData(player,"AdminLvL"))>=4)then
			dbQuery(UnbanDB_Func,{player,kplayer},handler,"SELECT ?? FROM ?? WHERE ??=?","Username","userbans","Username",kplayer)
		end
	end
end
addCommandHandler("unban",Unban_Func)
local function tBan_Func(player,cmd,kplayer,btime,...)
	if(tonumber(syncGetElementData(player,"AdminLvL"))>=2 and(not client or client==player))then
		if(kplayer and btime and tonumber(btime)~=nil)then
			if tonumber(btime)>=1 and tonumber(btime)<=10 then
				local reason=table.concat({...}," ")
				if(reason)then
					if(#reason>=3)then
						local target=getPlayerFromName(kplayer)
						if(not isElement(target))then
							local success=timebanPlayer(kplayer,tonumber(btime),getPlayerName(player),reason)			
							if(success==false)then
							end
							return
						end
						local name=getPlayerName(target)
						local savename=name
						local success=timebanPlayer(savename,tonumber(btime),getPlayerName(player),reason)
						if(success==false)then
						else
							outputChatBox(kplayer.." wurde von "..getPlayerName(player).." Temporär gebannt! Grund: "..tostring(reason).." Zeit: "..btime,root,255,0,0)
							outputLog(kplayer.." wurde von "..getPlayerName(player).." Temporär gebannt! Grund: "..tostring(reason).." Zeit: "..btime,"Adminsystem")
						end
					else
						triggerClientEvent(player,"draw:infobox",root,"error","Gebe einen Grund mit mehr als 3 Zeichen an!")
					end
				end
			end
		else
			notificationShow(player,"error","Use: /tban NAME TIME REASON")
		end
	else
		notificationShow(player,"error","You are not a Supporter!")
	end
end
addCommandHandler("tban",tBan_Func)

local function rKick_Func(player,cmd,kplayer,...)
	if(isLoggedin(player))then
		if(tonumber(syncGetElementData(player,"AdminLvL"))>=2 and(not client or client==player))then
			if(kplayer)then
				local reason={...}
				local reason=table.concat(reason," ")
				local target=getPlayerFromName(kplayer)
				if(#reason>=3)then
					if(not isElement(target))then
						triggerClientEvent(player,"draw:infobox",root,"warning","Der Spieler ist offline!")
						return
					end
					if(getAdminLevel(player)>getAdminLevel(target))then
						outputChatBox(getPlayerName(target).." wurde von "..getPlayerName(player).." gekickt! Grund: "..reason,root,255,0,0)
						outputLog(getPlayerName(target).." wurde von "..getPlayerName(player).." gekickt! Grund: "..reason,"Adminsystem")
						takeAllWeapons(target)
						kickPlayer(target,player,tostring(reason))
					end
				else
					triggerClientEvent(player,"draw:infobox",root,"error","Gebe einen Grund mit mehr als 3 Zeichen an!")
				end
			end
		end
	end
end
addCommandHandler("rkick",rKick_Func)

local function gotoXYZ_Func(player,cmd,x,y,z)
	if(tonumber(syncGetElementData(player,"AdminLvL"))>=5)then
		setElementPosition(player,tonumber(x),tonumber(y),tonumber(z))
	end
end
addCommandHandler("xyz",gotoXYZ_Func)


addEvent("set:faction_company",true)
addEventHandler("set:faction_company",root,function(target,typ,typ2)
	if(target)then
	local target=getPlayerFromName(target)
		if(tonumber(syncGetElementData(client,"AdminLvL"))>=3)then
			if(typ2)then
				if(typ=="Faction")then
					syncSetElementData(target,"Faction",typ2)
					updateFactionBlip(target)
					outputLog(getPlayerName(client).." hat "..getPlayerName(target).." zum Leader der Fraktion "..typ2.." ernannt!","Adminsystem")
					if(tonumber(syncGetElementData(target,"Faction"))~=0)then
						loadFactionVehicles(tonumber(syncGetElementData(target,"Faction")))
					end
					if(tonumber(typ2)==0)then
						syncSetElementData(target,"Factionrank",0)
					else
						syncSetElementData(target,"Factionrank",5)
					end
				elseif(typ=="Company")then
					syncSetElementData(target,"Company",typ2)
					outputLog(getPlayerName(client).." hat "..getPlayerName(target).." zum Leader des Unternehmen "..typ2.." ernannt!","Adminsystem")
					if(tonumber(syncGetElementData(target,"Company"))~=0)then
						loadCompanyVehicles(tonumber(syncGetElementData(target,"Company")))
					end
					if(tonumber(typ2)==0)then
						syncSetElementData(target,"Companyrank",0)
					else
						syncSetElementData(target,"Companyrank",5)
					end
				end
			end
		end
	end
end)


function gotoPrivateCar(player,cmd,target,slot)
	if(target)then
		local target=getPlayerFromName(target)
		if(tonumber(syncGetElementData(player,"AdminLvL"))>=3)then
			if(slot and #slot>=1)then
				if(Vehicles[getPlayerName(target)..slot])then
					local x,y,z=getElementPosition(Vehicles[getPlayerName(target)..slot])
					local dim=getElementDimension(Vehicles[getPlayerName(target)..slot])
					local int=getElementInterior(Vehicles[getPlayerName(target)..slot])
					
					setElementPosition(player,x,y,z+3)
					setElementDimension(player,dim)
					setElementInterior(player,int)
				end
			end
		end
	end
end
addCommandHandler("gotocar",gotoPrivateCar)
function getPrivateCar(player,cmd,target,slot)
	if(target)then
		local target=getPlayerFromName(target)
		if(tonumber(syncGetElementData(player,"AdminLvL"))>=3)then
			if(slot and #slot>=1)then
				if(Vehicles[getPlayerName(target)..slot])then
					local x,y,z=getElementPosition(player)
					local dim=getElementDimension(player)
					local int=getElementInterior(player)
					
					setElementPosition(Vehicles[getPlayerName(target)..slot],x,y,z+3)
					setElementDimension(Vehicles[getPlayerName(target)..slot],dim)
					setElementInterior(Vehicles[getPlayerName(target)..slot],int)
				end
			end
		end
	end
end
addCommandHandler("getcar",getPrivateCar)

function gotoPlayer(player,cmd,kplayer)
	if(isLoggedin(player))then
		if(tonumber(syncGetElementData(player,"AdminLvL"))>=1)then
			local target=getPlayerFromName(kplayer)
			if(target)then
				if(isElement(target))then
					local x,y,z=getElementPosition(target)
					if(getPedOccupiedVehicleSeat(player)==0)then
						setElementInterior(getPedOccupiedVehicle(player),getElementInterior(target))
						setElementDimension(getPedOccupiedVehicle(player),getElementDimension(target))
						setElementDimension(player,getElementDimension(target))
						setElementPosition(getPedOccupiedVehicle(player),x+3,y+3,z)
					else
						removePedFromVehicle(player)
						setElementPosition(player,x,y+1,z)
						setElementInterior(player,getElementInterior(target))
						setElementDimension(player,getElementDimension(target))
					end
					sendMSGForAdmins("[ADMIN] "..getPlayerName(player).." hat sich zu "..getPlayerName(target).." teleportiert!",0,120,255)
				else
					triggerClientEvent(player,"draw:infobox",root,"warning","Der Spieler ist offline!")
				end
			end
		end
	end
end
addCommandHandler("goto",gotoPlayer)
function getherePlayer(player,cmd,kplayer)
	if(isLoggedin(player))then
		if(tonumber(syncGetElementData(player,"AdminLvL"))>=1)then
			local target=getPlayerFromName(kplayer)
			if(target)then
				if(isElement(target))then
					local x,y,z=getElementPosition(player)
					if(getPedOccupiedVehicleSeat(target)==0)then
						setElementInterior(target,getElementInterior(player))
						setElementInterior(getPedOccupiedVehicle(target),getElementInterior(player))
						setElementDimension(target,getElementDimension(player))
						setElementDimension(getPedOccupiedVehicle(target),getElementDimension(player))
						setElementPosition(getPedOccupiedVehicle(target),x+3,y+3,z)
					else
						removePedFromVehicle(target)
						setElementPosition(target,x,y+1,z)
						setElementInterior(target,getElementInterior(player))
						setElementDimension(target,getElementDimension(player))
					end
					sendMSGForAdmins("[ADMIN] "..getPlayerName(player).." hat "..getPlayerName(target).." zu sich teleportiert!",0,120,255)
				else
					triggerClientEvent(player,"draw:infobox",root,"warning","Der Spieler ist offline!")
				end
			end
		end
	end
end
addCommandHandler("gethere",getherePlayer)





addEvent("get:logs",true)
addEventHandler("get:logs",root,function(logs)
	if(logs)then
		if(fileExists("LOGS/"..logs..".log"))then
			local file=fileOpen("LOGS/"..logs..".log")
			local text=fileRead(file,99999999999)
			
			triggerClientEvent(client,"set:logs:text",client,text)
			fileClose(file)
		else
			triggerClientEvent(client,"set:logs:text",client,"Keine Logs gefunden.")
		end
	end
end)






--//Aduty
local admindutymarker={}
local admindutyskin=260
local admindutyarray={skinTable={},vehicleTable={}}

aduty={}

function adutyFunc(player)
	if(isLoggedin(player))then
		if(not isPedDead(player))then
			if(getAdminLevel(player)>=1)then
				if not admindutyarray.skinTable[player] then
					local x,y,z=getElementPosition(player)
					local rx,ry,rz=getElementRotation(player)
					admindutyarray.skinTable[player]=getElementModel(player)
					setElementModel(player,admindutyskin)
					admindutymarker[player]=createMarker(x,y,z,"arrow",0.3,200,0,0,160)
					attachElements(admindutymarker[player],player,0,0,1.3)
					setElementDoubleSided(admindutymarker[player],true)
					
					admindutyarray.vehicleTable[player]=createVehicle(411,x,y,z,rx,ry,rz,"ACAR")
					setVehicleDamageProof(admindutyarray.vehicleTable[player],true)
					setVehicleColor(admindutyarray.vehicleTable[player],255,255,0)
					warpPedIntoVehicle(player,admindutyarray.vehicleTable[player])
					setElementData(admindutyarray.vehicleTable[player],"Owner",getPlayerName(player))
					setElementData(admindutyarray.vehicleTable[player],"Fuel",100)
					setElementData(admindutyarray.vehicleTable[player],"Totalloss",0)
					setElementData(admindutyarray.vehicleTable[player],"engine",false)
					setElementData(admindutyarray.vehicleTable[player],"Sportmotor",3)
					setVehicleEngineState(admindutyarray.vehicleTable[player],false)
					giveVehicleSpecialUpgrade(admindutyarray.vehicleTable[player])
					addEventHandler("onVehicleExplode",admindutyarray.vehicleTable[player],function()aduty:destroyAcar()end)
					addEventHandler("onVehicleStartEnter",admindutyarray.vehicleTable[player],function()aduty:stopEnterAcar()end)
					
					removeEventHandler("onPlayerQuit",player,function()aduty:deconstructor()end)
					removeEventHandler("onPlayerWasted",player,function()aduty:deconstructor()end)
					removeEventHandler("onPlayerWeaponSwitch",player,dontHoldWeapon)
					addEventHandler("onPlayerQuit",player,function()aduty:deconstructor()end)
					addEventHandler("onPlayerWasted",player,function()aduty:deconstructor()end)
					addEventHandler("onPlayerWeaponSwitch",player,dontHoldWeapon)
					setElementData(player,"adminduty",true)
					sendMSGForAdmins(getPlayerName(player).." hat den Support-Dienst Modus betreten!",150,150,0)
					outputLog("[ADUTY]: "..getPlayerName(player).." hat den Support-Dienst Modus betreten!","Adminsystem")
				else
					admindutymarker[player]:destroy()
					setElementModel(player,admindutyarray.skinTable[player])
					admindutyarray.skinTable[player]=nil
					
					if admindutyarray.vehicleTable[player] and isElement(admindutyarray.vehicleTable[player])then
						admindutyarray.vehicleTable[player]:destroy()
						admindutyarray.vehicleTable[player]=nil
					end
					
					removeEventHandler("onPlayerQuit",player,function()aduty:deconstructor()end)
					removeEventHandler("onPlayerWasted",player,function()aduty:deconstructor()end)
					removeEventHandler("onPlayerWeaponSwitch",player,dontHoldWeapon)
					setElementData(player,"adminduty",false)
					sendMSGForAdmins(getPlayerName(player).." hat den Support-Dienst Modus verlassen!",150,150,0)
					outputLog("[ADUTY]: "..getPlayerName(player).." hat den Support-Dienst Modus verlassen!","Adminsystem")
				end
			end
		end
	end
end
addCommandHandler("aduty",adutyFunc)
addCommandHandler("amode",adutyFunc)
addCommandHandler("adminduty",adutyFunc)
addCommandHandler("supportmode",adutyFunc)


function aduty:deconstructor()
	if admindutyarray.skinTable[source] then
		admindutyarray.skinTable[source]=nil
	end
	if isElement(admindutymarker[source])then
		admindutymarker[source]:destroy()
	end
	if admindutyarray.vehicleTable[source] and isElement(admindutyarray.vehicleTable[source])then
		admindutyarray.vehicleTable[source]:destroy()
		admindutyarray.vehicleTable[source]=nil
	end
end

function aduty:destroyAcar()
	for i,v in pairs(admindutyarray.vehicleTable)do
		if v==source then
			admindutyarray.vehicleTable[i]=nil
		end
	end
end

function aduty:stopEnterAcar(player,_,_,door)
	if door==0 and player~=aduty:getAcarPlayer(source)then
		cancelEvent()
	end
end

function aduty:getAcarPlayer(vehicle)
	for i,v in pairs(admindutyarray.vehicleTable)do
		if v==vehicle then
			return i
		end
	end
	return false
end