--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local startDrugtruckMarker=createMarker(161.9,-25.7,0.5,"cylinder",1.2,200,0,0,120)

local deliverDrugtruckMarker=createMarker(-1096,-1621,75,"cylinder",6,200,0,0,120)
local deliverDrugtruckBlip=createBlip(-1096,-1621,75,19,2,255,0,0,255,0,99999.0,root)
setElementVisibleTo(deliverDrugtruckMarker,root,false)
setElementVisibleTo(deliverDrugtruckBlip,root,false)

local drogentruck=false
local drogentruckRobber=nil
local drogentruckFraktion=nil
local drogentruckTimer=nil

function openDrugtruckUI_Func(player)
	if(player and getElementType(player)=="player")then
		if(player:getDimension()==0 and player:getInterior()==0)then
			if(isLoggedin(player))then
				if(getPedOccupiedVehicle(player)~=true)then
					if(isEVIL(player))then
						triggerClientEvent(player,"open:drugtruckpanel",player)
					else
						triggerClientEvent(player,"draw:infobox",root,"error","Du bist in keiner Gang!")
					end
				end
			end
		end
	end
end
addEventHandler("onMarkerHit",startDrugtruckMarker,openDrugtruckUI_Func)

addEvent("start:weedtruck",true)
addEventHandler("start:weedtruck",root,function(player)
	if(aktionlaeuft==false)then
		if(isEVIL(player))then
			if(not drogentruck)then
				local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","factiondepots","Faction",tonumber(syncGetElementData(player,"Faction"))),-1)
				if(result and result[1])then
					if(tonumber(result[1]["Money"])>=tonumber(7500))then
						loadDrogenTruck(player)
						handler:exec("UPDATE ?? SET ??=? WHERE ??=?","factiondepots","Money",tonumber(result[1]["Money"])-7500,"Faction",tonumber(syncGetElementData(player,"Faction")))
					else
						triggerClientEvent(player,"draw:infobox",root,"error","Soviel Geld ist nicht in der Kasse! ($7500)")
					end
				end
			else
				triggerClientEvent(player,"draw:infobox",root,"error","Es läuft derzeit noch ein Weedtruck!")
			end
		end
	else
		triggerClientEvent(player,"draw:infobox",root,"error","Es läuft bereits eine Aktion!")
	end
end)


function loadDrogenTruck(player)
	sendMSGForFaction("#008cff[DEPARTMENT] #c80000Ein Weedtruck wurde beladen!",1,200,200,0)
	sendMSGForFaction("#008cff[DEPARTMENT] #c80000Ein Weedtruck wurde beladen!",2,200,200,0)
	sendMSGForFaction("#008cff[Aktion] #c80000Ein Weedtruck wurde beladen!",3,200,200,0)
	sendMSGForFaction("#008cff[Aktion] #c80000Ein Weedtruck wurde beladen!",4,200,200,0)
	sendMSGForFaction("#008cff[Aktion] #c80000Ein Weedtruck wurde beladen!",5,200,200,0)
	outputLog(getPlayerName(player).." hat den Weedtruck beladen!","Fraktion")
	drogentruck=createVehicle(578,162.8,-22.1,2.3,0,0,270,"WT")
	drogentruck:setColor(0,0,0,0,0,0)
	drogentruck:setHealth(2500)
	setElementData(drogentruck,"actionvehicle",true)
	setElementData(drogentruck,"Fuel",100)
	
	--drogentruckBLIP=createBlipAttachedTo(drogentruck,50,2,255,255,255,_,1000)
	
	DRUGSBOX=createObject(2934,0,0,0)
	attachElements(DRUGSBOX,drogentruck,0,-1.5,1.2)
	setElementCollisionsEnabled(DRUGSBOX,false)
	DRUGSBOX:setDoubleSided(true)
	addEventHandler("onVehicleExplode",drogentruck,vehicleDestroyedDrogenTruck)
	drogentruckFraktion=tonumber(syncGetElementData(player,"Faction"))
	
	weedtruckNPCcar=createVehicle(405,-1100,-1632,76.1,0,0,90,"...")
	weedtruckNPCcar:setFrozen(true)
	weedtruckNPCped=createPed(28,-1097.9,-1630.6,76.4,-90)
	weedtruckNPCped:setFrozen(true)
	setElementData(weedtruckNPCped,"dontdamagePED",true)
	aktionlaeuft=true
	
	setElementVisibleTo(deliverDrugtruckMarker,root,true)
	setElementVisibleTo(deliverDrugtruckBlip,root,true)
	
	drogentruckTimer=setTimer(
		function()
			if(isElement(drogentruck))then
				drogentruck:destroy()
			end
			if(isElement(DRUGSBOX))then
				DRUGSBOX:destroy()
			end
			if(isElement(drogentruckBLIP))then
				drogentruckBLIP:destroy()
			end
			if(isElement(weedtruckNPCcar))then
				weedtruckNPCcar:destroy()
			end
			if(isElement(weedtruckNPCped))then
				weedtruckNPCped:destroy()
			end
			sendMSGForFaction("#008cff[DEPARTMENT] #c80000Der Weedtruck wurde wegen der Zeit zerstört!",1,200,200,0)
			sendMSGForFaction("#008cff[DEPARTMENT] #c80000Der Weedtruck wurde wegen der Zeit zerstört!",2,200,200,0)
			sendMSGForFaction("#008cff[Aktion] #c80000Der Weedtruck wurde wegen der Zeit zerstört!",3,200,200,0)
			sendMSGForFaction("#008cff[Aktion] #c80000Der Weedtruck wurde wegen der Zeit zerstört!",4,200,200,0)
			sendMSGForFaction("#008cff[Aktion] #c80000Der Weedtruck wurde wegen der Zeit zerstört!",5,200,200,0)
			outputLog("Der Weedtruck wurde wegen der Zeit zerstört!","Fraktion")
			aktionlaeuft=false
			setTimer(function()drogentruck=false end,60*60*1000,1)
			setTimer(function()aktionlaeuft=false end,aktionpuffer,1)
			setElementVisibleTo(deliverDrugtruckMarker,root,false)
			setElementVisibleTo(deliverDrugtruckBlip,root,false)
		end,
	timeTillDrogentruckDisappears,1)
end

function vehicleDestroyedDrogenTruck()
	sendMSGForFaction("#008cff[DEPARTMENT] #c80000Der Weedtruck wurde zerstört!",1,200,200,0)
	sendMSGForFaction("#008cff[DEPARTMENT] #c80000Der Weedtruck wurde zerstört!",2,200,200,0)
	sendMSGForFaction("#008cff[Aktion] #c80000Der Weedtruck wurde zerstört!",3,200,200,0)
	sendMSGForFaction("#008cff[Aktion] #c80000Der Weedtruck wurde zerstört!",4,200,200,0)
	sendMSGForFaction("#008cff[Aktion] #c80000Der Weedtruck wurde zerstört!",5,200,200,0)
	outputLog("Der Weedtruck wurde zerstört!","Fraktion")
	setElementData(drogentruck,"actionvehicle",false)
	aktionlaeuft=false
	setTimer(function()aktionlaeuft=false end,aktionpuffer,1)
	setTimer(function()drogentruck=false end,60*60*1000,1)
	if(isElement(DRUGSBOX))then
		DRUGSBOX:destroy()
	end
	if(isElement(drogentruckBLIP))then
		drogentruckBLIP:destroy()
	end
	if(isElement(weedtruckNPCcar))then
		weedtruckNPCcar:destroy()
	end
	if(isElement(weedtruckNPCped))then
		weedtruckNPCped:destroy()
	end
	if isTimer(drogentruckTimer)then
		killTimer(drogentruckTimer)
		drogentruckTimer=nil
	end
	setElementVisibleTo(deliverDrugtruckMarker,root,false)
	setElementVisibleTo(deliverDrugtruckBlip,root,false)
	drogentruckFraktion=nil
end

function drogentruckSuccessfull(player)
	sendMSGForFaction("#008cff[DEPARTMENT] #c80000Der Weedtruck wurde erfolgreich entladen!",1,200,200,0)
	sendMSGForFaction("#008cff[DEPARTMENT] #c80000Der Weedtruck wurde erfolgreich entladen!",2,200,200,0)
	sendMSGForFaction("#008cff[Aktion] #c80000Der Weedtruck wurde erfolgreich entladen!",3,200,200,0)
	sendMSGForFaction("#008cff[Aktion] #c80000Der Weedtruck wurde erfolgreich entladen!",4,200,200,0)
	sendMSGForFaction("#008cff[Aktion] #c80000Der Weedtruck wurde erfolgreich entladen!",5,200,200,0)
	outputLog("Der Weedtruck wurde erfolgreich entladen!","Fraktion")
	setElementData(drogentruck,"actionvehicle",false)
	if(isElement(drogentruck))then
		drogentruck:destroy()
	end
	if(isElement(DRUGSBOX))then
		DRUGSBOX:destroy()
	end
	if(isElement(drogentruckBLIP))then
		drogentruckBLIP:destroy()
	end
	if(isElement(weedtruckNPCcar))then
		weedtruckNPCcar:destroy()
	end
	if(isElement(weedtruckNPCped))then
		weedtruckNPCped:destroy()
	end
	aktionlaeuft=false
	setTimer(function()drogentruck=false end,60*60*1000,1)
	setTimer(function()aktionlaeuft=false end,aktionpuffer,1)
	setElementVisibleTo(deliverDrugtruckMarker,root,false)
	setElementVisibleTo(deliverDrugtruckBlip,root,false)
	if isTimer(drogentruckTimer)then
		killTimer(drogentruckTimer)
		drogentruckTimer=nil
	end
	local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","factiondepots","Faction",tonumber(syncGetElementData(player,"Faction"))),-1)
	if(result and result[1])then
		local rdm=math.random(650,1200)
		handler:exec("UPDATE ?? SET ??=? WHERE ??=?","factiondepots","Weed",tonumber(result[1]["Weed"])+rdm,"Faction",tonumber(syncGetElementData(player,"Faction")))
		outputChatBox("Du hast x"..rdm.." Weed für deine Fraktion gefahren!",player,255,255,255)
	end
	setElementData(player,"seatbelt",false)
	triggerClientEvent(player,"stop:seatbeltsound",player)
end

addEventHandler("onMarkerHit",deliverDrugtruckMarker,function(player)
	if(isElement(player)and getElementType(player)=="player")then
		if(isEVIL(player))then
			if(getPedOccupiedVehicleSeat(player)==0)then
				local veh=getPedOccupiedVehicle(player)
				if(veh==drogentruck)then
					if(getElementHealth(veh)>=250)then
						drogentruckSuccessfull(player) 
					end
				end
			end
		end
	end
end)