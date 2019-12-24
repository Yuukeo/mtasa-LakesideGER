--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local startKokaintruckMarker=createMarker(-522.6,-493.5,24.5,"cylinder",1.2,200,0,0,120)

local deliverKokaintruckMarker=createMarker(1080.8,-341.3,72.9,"cylinder",6,200,0,0,120)
local deliverKokaintruckBlip=createBlip(1080.8,-341.3,72.9,19,2,255,0,0,255,0,99999.0,root)
setElementVisibleTo(deliverKokaintruckMarker,root,false)
setElementVisibleTo(deliverKokaintruckBlip,root,false)

local kokaintruck=false
local kokaintruckFraktion=nil
local kokaintruckTimer=nil

function openKokaintruckUI_Func(player)
	if(player and getElementType(player)=="player")then
		if(player:getDimension()==0 and player:getInterior()==0)then
			if(isLoggedin(player))then
				if(getPedOccupiedVehicle(player)~=true)then
					if(isEVIL(player))then
						triggerClientEvent(player,"open:kokaintruckpanel",player)
					else
						triggerClientEvent(player,"draw:infobox",root,"error","Du bist in keiner Gang!")
					end
				end
			end
		end
	end
end
addEventHandler("onMarkerHit",startKokaintruckMarker,openKokaintruckUI_Func)

addEvent("start:kokaintruck",true)
addEventHandler("start:kokaintruck",root,function(player)
	if(aktionlaeuft==false)then
		if(isEVIL(player))then
			if(not kokaintruck)then
				local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","factiondepots","Faction",tonumber(syncGetElementData(player,"Faction"))),-1)
				if(result and result[1])then
					if(tonumber(result[1]["Money"])>=tonumber(5000))then
						loadKokainTruck(player)
						handler:exec("UPDATE ?? SET ??=? WHERE ??=?","factiondepots","Money",tonumber(result[1]["Money"])-5000,"Faction",tonumber(syncGetElementData(player,"Faction")))
					else
						triggerClientEvent(player,"draw:infobox",root,"error","Soviel Geld ist nicht in der Kasse! ($5000)")
					end
				end
			else
				triggerClientEvent(player,"draw:infobox",root,"error","Es läuft derzeit noch ein Kokaintruck!")
			end
		end
	else
		triggerClientEvent(player,"draw:infobox",root,"error","Es läuft bereits eine Aktion!")
	end
end)


function loadKokainTruck(player)
	sendMSGForFaction("#008cff[DEPARTMENT] #c80000Ein Kokaintruck wurde beladen!",1,200,200,0)
	sendMSGForFaction("#008cff[DEPARTMENT] #c80000Ein Kokaintruck wurde beladen!",2,200,200,0)
	sendMSGForFaction("#008cff[Aktion] #c80000Ein Kokaintruck wurde beladen!",3,200,200,0)
	sendMSGForFaction("#008cff[Aktion] #c80000Ein Kokaintruck wurde beladen!",4,200,200,0)
	sendMSGForFaction("#008cff[Aktion] #c80000Ein Kokaintruck wurde beladen!",5,200,200,0)
	outputLog(getPlayerName(player).." hat den Kokaintruck beladen!","Fraktion")
	kokaintruck=createVehicle(578,-520,-499,26.2,0,0,0,"KT")
	kokaintruck:setColor(0,0,0,0,0,0)
	kokaintruck:setHealth(2500)
	setElementData(kokaintruck,"actionvehicle",true)
	setElementData(kokaintruck,"Fuel",100)
	
	--kokaintruckBLIP=createBlipAttachedTo(kokaintruck,50,2,255,255,255,_,1000)
	
	KOKAINBOX=createObject(2935,0,0,0)
	attachElements(KOKAINBOX,kokaintruck,0,-1.5,1.2)
	setElementCollisionsEnabled(KOKAINBOX,false)
	KOKAINBOX:setDoubleSided(true)
	addEventHandler("onVehicleExplode",kokaintruck,vehicleDestroyedKokainTruck)
	kokaintruckFraktion=tonumber(syncGetElementData(player,"Faction"))
	
	aktionlaeuft=true
	
	setElementVisibleTo(deliverKokaintruckMarker,root,true)
	setElementVisibleTo(deliverKokaintruckBlip,root,true)
	
	kokaintruckTimer=setTimer(
		function()
			if(isElement(kokaintruck))then
				kokaintruck:destroy()
			end
			if(isElement(KOKAINBOX))then
				KOKAINBOX:destroy()
			end
			if(isElement(kokaintruckBLIP))then
				kokaintruckBLIP:destroy()
			end
			sendMSGForFaction("#008cff[DEPARTMENT] #c80000Der Kokaintruck wurde wegen der Zeit zerstört!",1,200,200,0)
			sendMSGForFaction("#008cff[DEPARTMENT] #c80000Der Kokaintruck wurde wegen der Zeit zerstört!",2,200,200,0)
			sendMSGForFaction("#008cff[Aktion] #c80000Der Kokaintruck wurde wegen der Zeit zerstört!",3,200,200,0)
			sendMSGForFaction("#008cff[Aktion] #c80000Der Kokaintruck wurde wegen der Zeit zerstört!",4,200,200,0)
			sendMSGForFaction("#008cff[Aktion] #c80000Der Kokaintruck wurde wegen der Zeit zerstört!",5,200,200,0)
			outputLog("Der Kokaintruck wurde wegen der Zeit zerstört!","Fraktion")
			aktionlaeuft=false
			setTimer(function()kokaintruck=false end,60*60*1000,1)
			setTimer(function()aktionlaeuft=false end,aktionpuffer,1)
			setElementVisibleTo(deliverKokaintruckMarker,root,false)
			setElementVisibleTo(deliverKokaintruckBlip,root,false)
		end,
	timeTillDrogentruckDisappears,1)
end

function vehicleDestroyedKokainTruck()
	sendMSGForFaction("#008cff[DEPARTMENT] #c80000Der Kokaintruck wurde zerstört!",1,200,200,0)
	sendMSGForFaction("#008cff[DEPARTMENT] #c80000Der Kokaintruck wurde zerstört!",2,200,200,0)
	sendMSGForFaction("#008cff[Aktion] #c80000Der Kokaintruck wurde zerstört!",3,200,200,0)
	sendMSGForFaction("#008cff[Aktion] #c80000Der Kokaintruck wurde zerstört!",4,200,200,0)
	sendMSGForFaction("#008cff[Aktion] #c80000Der Kokaintruck wurde zerstört!",5,200,200,0)
	outputLog("Der Kokaintruck wurde zerstört!","Fraktion")
	setElementData(kokaintruck,"actionvehicle",false)
	aktionlaeuft=false
	setTimer(function()aktionlaeuft=false end,aktionpuffer,1)
	setTimer(function()kokaintruck=false end,60*60*1000,1)
	if(isElement(KOKAINBOX))then
		KOKAINBOX:destroy()
	end
	if(isElement(kokaintruckBLIP))then
		kokaintruckBLIP:destroy()
	end
	if isTimer(kokaintruckTimer)then
		killTimer(kokaintruckTimer)
		kokaintruckTimer=nil
	end
	setElementVisibleTo(deliverKokaintruckMarker,root,false)
	setElementVisibleTo(deliverKokaintruckBlip,root,false)
	kokaintruckFraktion=nil
end

function kokaintruckSuccessfull(player)
	sendMSGForFaction("#008cff[DEPARTMENT] #c80000Der Kokaintruck wurde erfolgreich entladen!",1,200,200,0)
	sendMSGForFaction("#008cff[DEPARTMENT] #c80000Der Kokaintruck wurde erfolgreich entladen!",2,200,200,0)
	sendMSGForFaction("#008cff[Aktion] #c80000Der Kokaintruck wurde erfolgreich entladen!",3,200,200,0)
	sendMSGForFaction("#008cff[Aktion] #c80000Der Kokaintruck wurde erfolgreich entladen!",4,200,200,0)
	sendMSGForFaction("#008cff[Aktion] #c80000Der Kokaintruck wurde erfolgreich entladen!",5,200,200,0)
	outputLog("Der Kokaintruck wurde erfolgreich entladen!","Fraktion")
	setElementData(kokaintruck,"actionvehicle",false)
	if(isElement(kokaintruck))then
		kokaintruck:destroy()
	end
	if(isElement(KOKAINBOX))then
		KOKAINBOX:destroy()
	end
	if(isElement(kokaintruckBLIP))then
		kokaintruckBLIP:destroy()
	end
	aktionlaeuft=false
	setTimer(function()kokaintruck=false end,60*60*1000,1)
	setTimer(function()aktionlaeuft=false end,aktionpuffer,1)
	setElementVisibleTo(deliverKokaintruckMarker,root,false)
	setElementVisibleTo(deliverKokaintruckBlip,root,false)
	if isTimer(kokaintruckTimer)then
		killTimer(kokaintruckTimer)
		kokaintruckTimer=nil
	end
	local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","factiondepots","Faction",tonumber(syncGetElementData(player,"Faction"))),-1)
	if(result and result[1])then
		local rdm=math.random(300,750)
		handler:exec("UPDATE ?? SET ??=? WHERE ??=?","factiondepots","Kokain",tonumber(result[1]["Kokain"])+rdm,"Faction",tonumber(syncGetElementData(player,"Faction")))
		outputChatBox("Du hast x"..rdm.." Kokain für deine Fraktion gefahren!",player,255,255,255)
	end
	setElementData(player,"seatbelt",false)
	triggerClientEvent(player,"stop:seatbeltsound",player)
end

addEventHandler("onMarkerHit",deliverKokaintruckMarker,function(player)
	if(isElement(player)and getElementType(player)=="player")then
		if(isEVIL(player))then
			if(getPedOccupiedVehicleSeat(player)==0)then
				local veh=getPedOccupiedVehicle(player)
				if(veh==kokaintruck)then
					if(getElementHealth(veh)>=250)then
						kokaintruckSuccessfull(player) 
					end
				end
			end
		end
	end
end)