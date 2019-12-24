--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local startMatstruckMarker=createMarker(2291,2773.8,9.8,"cylinder",1.2,200,0,0,120)


local deliverMatstruckGroveMarker=createMarker(2490.8,-1669,12.1,"cylinder",6,200,0,0,120)
local deliverMatstruckGroveBlip=createBlip(2490.8,-1669,12.1,19,2,255,0,0,255,0,99999.0,root)
local deliverMatstruckBallasMarker=createMarker(2245.6,-1434,23.5,"cylinder",6,200,0,0,120)
local deliverMatstruckBallasBlip=createBlip(2245.6,-1434,23.5,19,2,255,0,0,255,0,99999.0,root)
local deliverMatstruckVagosMarker=createMarker(2872.1,-2148.2,4.1,"cylinder",6,200,0,0,120)
local deliverMatstruckVagosBlip=createBlip(2872.1,-2148.2,4.1,19,2,255,0,0,255,0,99999.0,root)


setElementVisibleTo(deliverMatstruckGroveMarker,root,false)
setElementVisibleTo(deliverMatstruckGroveBlip,root,false)
setElementVisibleTo(deliverMatstruckBallasMarker,root,false)
setElementVisibleTo(deliverMatstruckBallasBlip,root,false)
setElementVisibleTo(deliverMatstruckVagosMarker,root,false)
setElementVisibleTo(deliverMatstruckVagosBlip,root,false)


local drogentruck=false
local drogentruckRobber=nil
local drogentruckFraktion=nil
local drogentruckTimer=nil

function openMatstruckUI_Func(player)
	if(player and getElementType(player)=="player")then
		if(player:getDimension()==0 and player:getInterior()==0)then
			if(isLoggedin(player))then
				if(getPedOccupiedVehicle(player)~=true)then
					if(isEVIL(player))then
						triggerClientEvent(player,"open:matstruckpanel",player)
					else
						triggerClientEvent(player,"draw:infobox",root,"error","Du bist in keiner Gang!")
					end
				end
			end
		end
	end
end
addEventHandler("onMarkerHit",startMatstruckMarker,openMatstruckUI_Func)

addEvent("start:matstruck",true)
addEventHandler("start:matstruck",root,function(player)
	if(aktionlaeuft==false)then
		if(isEVIL(player))then
			if(not matstruck)then
				local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","factiondepots","Faction",tonumber(syncGetElementData(player,"Faction"))),-1)
				if(result and result[1])then
					if(tonumber(result[1]["Money"])>=tonumber(8000))then
						loadMatstruck(player)
						handler:exec("UPDATE ?? SET ??=? WHERE ??=?","factiondepots","Money",tonumber(result[1]["Money"])-8000,"Faction",tonumber(syncGetElementData(player,"Faction")))
					else
						triggerClientEvent(player,"draw:infobox",root,"error","Soviel Geld ist nicht in der Kasse! ($8000)")
					end
				end
			else
				triggerClientEvent(player,"draw:infobox",root,"error","Es läuft derzeit noch ein Matstruck!")
			end
		end
	else
		triggerClientEvent(player,"draw:infobox",root,"error","Es läuft bereits eine Aktion!")
	end
end)


function loadMatstruck(player)
	sendMSGForFaction("#008cff[DEPARTMENT] #c80000Ein Matstruck wurde beladen!",1,200,200,0)
	sendMSGForFaction("#008cff[DEPARTMENT] #c80000Ein Matstruck wurde beladen!",2,200,200,0)
	sendMSGForFaction("#008cff[Aktion] #c80000Ein Matstruck wurde beladen!",3,200,200,0)
	sendMSGForFaction("#008cff[Aktion] #c80000Ein Matstruck wurde beladen!",4,200,200,0)
	sendMSGForFaction("#008cff[Aktion] #c80000Ein Matstruck wurde beladen!",5,200,200,0)
	outputLog(getPlayerName(player).." hat den Matstruck beladen!","Fraktion")
	matstruck=createVehicle(578,2296.6,2770.6,11.4,0,0,270,"MT")
	matstruck:setColor(0,0,0,0,0,0)
	matstruck:setHealth(2500)
	setElementData(matstruck,"actionvehicle",true)
	setElementData(matstruck,"Fuel",100)
	
	--drogentruckBLIP=createBlipAttachedTo(drogentruck,50,2,255,255,255,_,1000)
	
	DRUGSBOX=createObject(2932,0,0,0)
	attachElements(DRUGSBOX,matstruck,0,-1.5,1.2)
	setElementCollisionsEnabled(DRUGSBOX,false)
	DRUGSBOX:setDoubleSided(true)
	addEventHandler("onVehicleEnter",matstruck,vehicleEnterMatstruck)
	addEventHandler("onVehicleExit",matstruck,vehicleExitMatstruck)
	addEventHandler("onVehicleExplode",matstruck,vehicleDestroyedMatsTruck)
	drogentruckFraktion=tonumber(syncGetElementData(player,"Faction"))
	
	aktionlaeuft=true
	
	--[[if(isGROVE(player))then
		setElementVisibleTo(deliverMatstruckGroveMarker,player,true)
		setElementVisibleTo(deliverMatstruckGroveBlip,player,true)
	end
	if(isBALLAS(player))then
		setElementVisibleTo(deliverMatstruckBallasMarker,player,true)
		setElementVisibleTo(deliverMatstruckBallasBlip,player,true)
	end
	if(isVAGOS(player))then
		setElementVisibleTo(deliverMatstruckVagosMarker,player,true)
		setElementVisibleTo(deliverMatstruckVagosBlip,player,true)
	end]]
	
	drogentruckTimer=setTimer(
		function()
			if(isElement(matstruck))then
				matstruck:destroy()
			end
			if(isElement(DRUGSBOX))then
				DRUGSBOX:destroy()
			end
			if(isElement(drogentruckBLIP))then
				drogentruckBLIP:destroy()
			end
			sendMSGForFaction("#008cff[DEPARTMENT] #c80000Der Matstruck wurde wegen der Zeit zerstört!",1,200,200,0)
			sendMSGForFaction("#008cff[DEPARTMENT] #c80000Der Matstruck wurde wegen der Zeit zerstört!",2,200,200,0)
			sendMSGForFaction("#008cff[Aktion] #c80000Der Matstruck wurde wegen der Zeit zerstört!",3,200,200,0)
			sendMSGForFaction("#008cff[Aktion] #c80000Der Matstruck wurde wegen der Zeit zerstört!",4,200,200,0)
			sendMSGForFaction("#008cff[Aktion] #c80000Der Matstruck wurde wegen der Zeit zerstört!",5,200,200,0)
			outputLog("Der Matstruck wurde wegen der Zeit zerstört!","Fraktion")
			setElementData(matstruck,"actionvehicle",false)
			aktionlaeuft=false
			setTimer(function()matstruck=false end,60*60*1000,1)
			setTimer(function()aktionlaeuft=false end,aktionpuffer,1)
			if(isGROVE(player))then
				setElementVisibleTo(deliverMatstruckGroveMarker,player,false)
				setElementVisibleTo(deliverMatstruckGroveBlip,player,false)
			end
			if(isBALLAS(player))then
				setElementVisibleTo(deliverMatstruckBallasMarker,player,false)
				setElementVisibleTo(deliverMatstruckBallasBlip,player,false)
			end
			if(isVAGOS(player))then
				setElementVisibleTo(deliverMatstruckVagosMarker,player,false)
				setElementVisibleTo(deliverMatstruckVagosBlip,player,false)
			end
		end,
	timeTillMatstruckDisappears,1)
end

function vehicleDestroyedMatsTruck()
	sendMSGForFaction("#008cff[DEPARTMENT] #c80000Der Matstruck wurde zerstört!",1,200,200,0)
	sendMSGForFaction("#008cff[DEPARTMENT] #c80000Der Matstruck wurde zerstört!",2,200,200,0)
	sendMSGForFaction("#008cff[Aktion] #c80000Der Matstruck wurde zerstört!",3,200,200,0)
	sendMSGForFaction("#008cff[Aktion] #c80000Der Matstruck wurde zerstört!",4,200,200,0)
	sendMSGForFaction("#008cff[Aktion] #c80000Der Matstruck wurde zerstört!",5,200,200,0)
	outputLog("Der Matstruck wurde zerstört!","Fraktion")
	setElementData(matstruck,"actionvehicle",false)
	aktionlaeuft=false
	setTimer(function()aktionlaeuft=false end,aktionpuffer,1)
	setTimer(function()matstruck=false end,60*60*1000,1)
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
	setElementVisibleTo(deliverMatstruckGroveMarker,root,false)
	setElementVisibleTo(deliverMatstruckGroveBlip,root,false)
	setElementVisibleTo(deliverMatstruckBallasMarker,root,false)
	setElementVisibleTo(deliverMatstruckBallasBlip,root,false)
	setElementVisibleTo(deliverMatstruckVagosMarker,root,false)
	setElementVisibleTo(deliverMatstruckVagosBlip,root,false)
	drogentruckFraktion=nil
end

function vehicleEnterMatstruck(player,seat)
	if seat~=0 then return false end
	if(isGROVE(player))then
		setElementVisibleTo(deliverMatstruckGroveMarker,player,true)
		setElementVisibleTo(deliverMatstruckGroveBlip,player,true)
		setElementVisibleTo(deliverMatstruckBallasMarker,player,false)
		setElementVisibleTo(deliverMatstruckBallasBlip,player,false)
		setElementVisibleTo(deliverMatstruckVagosMarker,player,false)
		setElementVisibleTo(deliverMatstruckVagosBlip,player,false)
	end
	if(isBALLAS(player))then
		setElementVisibleTo(deliverMatstruckBallasMarker,player,true)
		setElementVisibleTo(deliverMatstruckBallasBlip,player,true)
		setElementVisibleTo(deliverMatstruckGroveMarker,player,false)
		setElementVisibleTo(deliverMatstruckGroveBlip,player,false)
		setElementVisibleTo(deliverMatstruckVagosMarker,player,false)
		setElementVisibleTo(deliverMatstruckVagosBlip,player,false)
	end
	if(isVAGOS(player))then
		setElementVisibleTo(deliverMatstruckBallasMarker,player,false)
		setElementVisibleTo(deliverMatstruckBallasBlip,player,false)
		setElementVisibleTo(deliverMatstruckGroveMarker,player,false)
		setElementVisibleTo(deliverMatstruckGroveBlip,player,false)
		setElementVisibleTo(deliverMatstruckVagosMarker,player,true)
		setElementVisibleTo(deliverMatstruckVagosBlip,player,true)
	end
end
function vehicleExitMatstruck(player,seat)
	if seat~=0 then return false end
	if(isGROVE(player))then
		setElementVisibleTo(deliverMatstruckGroveMarker,player,false)
		setElementVisibleTo(deliverMatstruckGroveBlip,player,false)
		setElementVisibleTo(deliverMatstruckBallasMarker,player,false)
		setElementVisibleTo(deliverMatstruckBallasBlip,player,false)
		setElementVisibleTo(deliverMatstruckVagosMarker,player,false)
		setElementVisibleTo(deliverMatstruckVagosBlip,player,false)
	end
	if(isBALLAS(player))then
		setElementVisibleTo(deliverMatstruckBallasMarker,player,false)
		setElementVisibleTo(deliverMatstruckBallasBlip,player,false)
		setElementVisibleTo(deliverMatstruckGroveMarker,player,false)
		setElementVisibleTo(deliverMatstruckGroveBlip,player,false)
		setElementVisibleTo(deliverMatstruckVagosMarker,player,false)
		setElementVisibleTo(deliverMatstruckVagosBlip,player,false)
	end
	if(isVAGOS(player))then
		setElementVisibleTo(deliverMatstruckBallasMarker,player,false)
		setElementVisibleTo(deliverMatstruckBallasBlip,player,false)
		setElementVisibleTo(deliverMatstruckGroveMarker,player,false)
		setElementVisibleTo(deliverMatstruckGroveBlip,player,false)
		setElementVisibleTo(deliverMatstruckVagosMarker,player,false)
		setElementVisibleTo(deliverMatstruckVagosBlip,player,false)
	end
end

function matstruckSuccessfull(player)
	sendMSGForFaction("#008cff[DEPARTMENT] #c80000Der Matstruck wurde erfolgreich entladen!",1,200,200,0)
	sendMSGForFaction("#008cff[DEPARTMENT] #c80000Der Matstruck wurde erfolgreich entladen!",2,200,200,0)
	sendMSGForFaction("#008cff[Aktion] #c80000Der Matstruck wurde erfolgreich entladen!",3,200,200,0)
	sendMSGForFaction("#008cff[Aktion] #c80000Der Matstruck wurde erfolgreich entladen!",4,200,200,0)
	sendMSGForFaction("#008cff[Aktion] #c80000Der Matstruck wurde erfolgreich entladen!",5,200,200,0)
	outputLog("Der Matstruck wurde erfolgreich entladen!","Fraktion")
	setElementData(matstruck,"actionvehicle",false)
	if(isElement(matstruck))then
		matstruck:destroy()
	end
	if(isElement(DRUGSBOX))then
		DRUGSBOX:destroy()
	end
	if(isElement(drogentruckBLIP))then
		drogentruckBLIP:destroy()
	end
	aktionlaeuft=false
	setTimer(function()matstruck=false end,60*60*1000,1)
	setTimer(function()aktionlaeuft=false end,aktionpuffer,1)
	setElementVisibleTo(deliverMatstruckGroveMarker,player,false)
	setElementVisibleTo(deliverMatstruckGroveBlip,player,false)
	setElementVisibleTo(deliverMatstruckBallasMarker,player,false)
	setElementVisibleTo(deliverMatstruckBallasBlip,player,false)
	setElementVisibleTo(deliverMatstruckVagosMarker,player,false)
	setElementVisibleTo(deliverMatstruckVagosBlip,player,false)
	if isTimer(drogentruckTimer)then
		killTimer(drogentruckTimer)
		drogentruckTimer=nil
	end
	local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","factiondepots","Faction",tonumber(syncGetElementData(player,"Faction"))),-1)
	if(result and result[1])then
		local rdm=math.random(1100,2800)
		handler:exec("UPDATE ?? SET ??=? WHERE ??=?","factiondepots","Mats",tonumber(result[1]["Mats"])+rdm,"Faction",tonumber(syncGetElementData(player,"Faction")))
		outputChatBox("Du hast x"..rdm.." Mats für deine Fraktion gefahren!",player,255,255,255)
	end
	setElementData(player,"seatbelt",false)
	triggerClientEvent(player,"stop:seatbeltsound",player)
end

addEventHandler("onMarkerHit",deliverMatstruckGroveMarker,function(player)
	if(isElement(player)and getElementType(player)=="player")then
		if(isEVIL(player))then
			if(getPedOccupiedVehicleSeat(player)==0)then
				local veh=getPedOccupiedVehicle(player)
				if(veh==matstruck)then
					if(getElementHealth(veh)>=250)then
						matstruckSuccessfull(player) 
					end
				end
			end
		end
	end
end)
addEventHandler("onMarkerHit",deliverMatstruckBallasMarker,function(player)
	if(isElement(player)and getElementType(player)=="player")then
		if(isEVIL(player))then
			if(getPedOccupiedVehicleSeat(player)==0)then
				local veh=getPedOccupiedVehicle(player)
				if(veh==matstruck)then
					if(getElementHealth(veh)>=250)then
						matstruckSuccessfull(player) 
					end
				end
			end
		end
	end
end)
addEventHandler("onMarkerHit",deliverMatstruckVagosMarker,function(player)
	if(isElement(player)and getElementType(player)=="player")then
		if(isEVIL(player))then
			if(getPedOccupiedVehicleSeat(player)==0)then
				local veh=getPedOccupiedVehicle(player)
				if(veh==matstruck)then
					if(getElementHealth(veh)>=250)then
						matstruckSuccessfull(player) 
					end
				end
			end
		end
	end
end)