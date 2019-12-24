--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local startAservatentruckMarker=createMarker(1581.7,-1674.4,4.9,"cylinder",1.2,200,0,0,120)

local deliverDrugtruckMarker=createMarker(143.9,1914.4,17.7,"cylinder",6,200,0,0,120)
local deliverAservatentruckBlip=createBlip(143.9,1914.4,17.7,19,2,255,0,0,255,0,99999.0,root)
setElementVisibleTo(deliverDrugtruckMarker,root,false)
setElementVisibleTo(deliverAservatentruckBlip,root,false)

local aservatentruck=false
local aservatentruckTimer=nil

function openAservatentrucktruckUI_Func(player)
	if(player and getElementType(player)=="player")then
		if(player:getDimension()==0 and player:getInterior()==0)then
			if(isLoggedin(player))then
				if(getPedOccupiedVehicle(player)~=true)then
					if(isSTATE(player))then
						local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","factiondepots","Faction",tonumber(syncGetElementData(player,"Faction"))),-1)
						if(result and result[1])then
							triggerClientEvent(player,"open:aservatentruckpanel",player,result[1]["Weed"],result[1]["Mats"])
						end
					else
						triggerClientEvent(player,"draw:infobox",root,"error","Du bist in kein Staatsfraktionist!")
					end
				end
			end
		end
	end
end
addEventHandler("onMarkerHit",startAservatentruckMarker,openAservatentrucktruckUI_Func)

addEvent("start:aservatentruck",true)
addEventHandler("start:aservatentruck",root,function(player,typ)
	if(aktionlaeuft==false)then
		if(isSTATE(player))then
			if(syncGetElementData(player,"CopDuty")==true)then
				if(not aservatentruck)then
					local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","factiondepots","Faction",tonumber(syncGetElementData(player,"Faction"))),-1)
					if(result and result[1])then
						if(typ)then
							if(typ=="Weed")then
								if(tonumber(result[1]["Weed"])>=tonumber(2500))then
									loadAservatentruck(player,"Weed")
									handler:exec("UPDATE ?? SET ??=? WHERE ??=?","factiondepots","Weed",tonumber(result[1]["Weed"])-2500,"Faction",1)
								else
									triggerClientEvent(player,"draw:infobox",root,"error","Es ist nicht genug Illegales im Lager!")
								end
							elseif(typ=="Mats")then
								if(tonumber(result[1]["Mats"])>=tonumber(2500))then
									loadAservatentruck(player,"Mats")
									handler:exec("UPDATE ?? SET ??=? WHERE ??=?","factiondepots","Mats",tonumber(result[1]["Mats"])-2500,"Faction",1)
								else
									triggerClientEvent(player,"draw:infobox",root,"error","Es ist nicht genug Illegales im Lager!")
								end
							elseif(typ=="Kokain")then
								if(tonumber(result[1]["Kokain"])>=tonumber(2500))then
									loadAservatentruck(player,"Kokain")
									handler:exec("UPDATE ?? SET ??=? WHERE ??=?","factiondepots","Kokain",tonumber(result[1]["Kokain"])-2500,"Faction",1)
								else
									triggerClientEvent(player,"draw:infobox",root,"error","Es ist nicht genug Illegales im Lager!")
								end
							end
						end
					end
				else
					triggerClientEvent(player,"draw:infobox",root,"error","Es läuft derzeit noch ein Aservatentruck!")
				end
			else
				triggerClientEvent(player,"draw:infobox",root,"error","Du bist nicht im Dienst!")
			end
		else
			triggerClientEvent(player,"draw:infobox",root,"error","Du bist in kein Staatsfraktionist!")
		end
	else
		triggerClientEvent(player,"draw:infobox",root,"error","Es läuft bereits eine Aktion!")
	end
end)


function loadAservatentruck(player,typ)
	if(typ)then
		sendMSGForFaction("#008cff[DEPARTMENT] #c80000Ein Aservatentruck wurde beladen!",1,200,200,0)
		sendMSGForFaction("#008cff[DEPARTMENT] #c80000Ein Aservatentruck wurde beladen!",2,200,200,0)
		sendMSGForFaction("#008cff[Aktion] #c80000Ein Aservatentruck wurde beladen!",3,200,200,0)
		sendMSGForFaction("#008cff[Aktion] #c80000Ein Aservatentruck wurde beladen!",4,200,200,0)
		sendMSGForFaction("#008cff[Aktion] #c80000Ein Aservatentruck wurde beladen!",5,200,200,0)
		outputLog(getPlayerName(player).." hat den Aservatentruck beladen!","Fraktion")
		aservatentruck=createVehicle(498,1585.4,-1668.1,6,0,0,270,"AT")
		aservatentruck:setColor(0,0,0,0,0,0)
		aservatentruck:setHealth(2500)
		setElementData(aservatentruck,"actionvehicle",true)
		setElementData(aservatentruck,"Fuel",100)
		setElementData(aservatentruck,"Illegales",typ)
		
		--drogentruckBLIP=createBlipAttachedTo(drogentruck,50,2,255,255,255,_,1000)
		
		addEventHandler("onVehicleExplode",aservatentruck,vehicleDestroyedAservatentruck)
		
		aktionlaeuft=true
		
		setElementVisibleTo(deliverDrugtruckMarker,root,true)
		setElementVisibleTo(deliverAservatentruckBlip,root,true)
		
		aservatentruckTimer=setTimer(
			function()
				if(isElement(aservatentruck))then
					aservatentruck:destroy()
				end
				if(isElement(DRUGSBOX))then
					DRUGSBOX:destroy()
				end
				if(isElement(drogentruckBLIP))then
					drogentruckBLIP:destroy()
				end
				sendMSGForFaction("#008cff[DEPARTMENT] #c80000Der Aservatentruck wurde wegen der Zeit zerstört!",1,200,200,0)
				sendMSGForFaction("#008cff[DEPARTMENT] #c80000Der Aservatentruck wurde wegen der Zeit zerstört!",2,200,200,0)
				sendMSGForFaction("#008cff[Aktion] #c80000Der Aservatentruck wurde wegen der Zeit zerstört!",3,200,200,0)
				sendMSGForFaction("#008cff[Aktion] #c80000Der Aservatentruck wurde wegen der Zeit zerstört!",4,200,200,0)
				sendMSGForFaction("#008cff[Aktion] #c80000Der Aservatentruck wurde wegen der Zeit zerstört!",5,200,200,0)
				outputLog("Der Aservatentruck wurde wegen der Zeit zerstört!","Fraktion")
				setElementData(aservatentruck,"actionvehicle",false)
				aktionlaeuft=false
				setTimer(function()aservatentruck=false end,60*60*1000,1)
				setTimer(function()aktionlaeuft=false end,aktionpuffer,1)
				setElementVisibleTo(deliverDrugtruckMarker,root,false)
				setElementVisibleTo(deliverAservatentruckBlip,root,false)
			end,
		timeTillAservatentruckDisappears,1)
	end
end

function vehicleDestroyedAservatentruck()
	sendMSGForFaction("#008cff[DEPARTMENT] #c80000Der Aservatentruck wurde zerstört!",1,200,200,0)
	sendMSGForFaction("#008cff[DEPARTMENT] #c80000Der Aservatentruck wurde zerstört!",2,200,200,0)
	sendMSGForFaction("#008cff[Aktion] #c80000Der Aservatentruck wurde zerstört!",3,200,200,0)
	sendMSGForFaction("#008cff[Aktion] #c80000Der Aservatentruck wurde zerstört!",4,200,200,0)
	sendMSGForFaction("#008cff[Aktion] #c80000Der Aservatentruck wurde zerstört!",5,200,200,0)
	outputLog("Der Aservatentruck wurde zerstört!","Fraktion")
	setElementData(aservatentruck,"actionvehicle",false)
	aktionlaeuft=false
	setTimer(function()aktionlaeuft=false end,aktionpuffer,1)
	setTimer(function()aservatentruck=false end,60*60*1000,1)
	if(isElement(DRUGSBOX))then
		DRUGSBOX:destroy()
	end
	if(isElement(drogentruckBLIP))then
		drogentruckBLIP:destroy()
	end
	if isTimer(aservatentruckTimer)then
		killTimer(aservatentruckTimer)
		aservatentruckTimer=nil
	end
	setElementVisibleTo(deliverDrugtruckMarker,root,false)
	setElementVisibleTo(deliverAservatentruckBlip,root,false)
end

function aservatentruckSuccessfull(player)
	sendMSGForFaction("#008cff[DEPARTMENT] #c80000Der Aservatentruck wurde erfolgreich entladen!",1,200,200,0)
	sendMSGForFaction("#008cff[DEPARTMENT] #c80000Der Aservatentruck wurde erfolgreich entladen!",2,200,200,0)
	sendMSGForFaction("#008cff[Aktion] #c80000Der Aservatentruck wurde erfolgreich entladen!",3,200,200,0)
	sendMSGForFaction("#008cff[Aktion] #c80000Der Aservatentruck wurde erfolgreich entladen!",4,200,200,0)
	sendMSGForFaction("#008cff[Aktion] #c80000Der Aservatentruck wurde erfolgreich entladen!",5,200,200,0)
	outputLog("Der Aservatentruck wurde erfolgreich entladen!","Fraktion")
	setElementData(aservatentruck,"actionvehicle",false)
	
	if(isElement(aservatentruck))then
		aservatentruck:destroy()
	end
	if(isElement(DRUGSBOX))then
		DRUGSBOX:destroy()
	end
	if(isElement(drogentruckBLIP))then
		drogentruckBLIP:destroy()
	end
	aktionlaeuft=false
	setTimer(function()aservatentruck=false end,60*60*1000,1)
	setTimer(function()aktionlaeuft=false end,aktionpuffer,1)
	setElementVisibleTo(deliverDrugtruckMarker,root,false)
	setElementVisibleTo(deliverAservatentruckBlip,root,false)
	if isTimer(aservatentruckTimer)then
		killTimer(aservatentruckTimer)
		aservatentruckTimer=nil
	end
	local x,y,z=getElementPosition(player)
	local col=createColSphere(x,y,z,50)
	local players=getElementsWithinColShape(col,"player")
	for i=1,#players do
		if(isSTATE(players[i])and syncGetElementData(players[i],"CopDuty")==true)then
			syncSetElementData(players[i],"Money",tonumber(syncGetElementData(players[i],"Money"))+5000)
			outputChatBox(getPlayerName(players[i]).." hat $5000 bekommen",players[i],0,200,0)
		end
	end
	setElementData(player,"seatbelt",false)
	triggerClientEvent(player,"stop:seatbeltsound",player)
end
function aservatentruckNotSuccessfull(player)
	sendMSGForFaction("#008cff[DEPARTMENT] #c80000Der Aservatentruck wurde nicht erfolgreich entladen!",1,200,200,0)
	sendMSGForFaction("#008cff[DEPARTMENT] #c80000Der Aservatentruck wurde nicht erfolgreich entladen!",2,200,200,0)
	sendMSGForFaction("#008cff[Aktion] #c80000Der Aservatentruck wurde nicht erfolgreich entladen!",3,200,200,0)
	sendMSGForFaction("#008cff[Aktion] #c80000Der Aservatentruck wurde nicht erfolgreich entladen!",4,200,200,0)
	sendMSGForFaction("#008cff[Aktion] #c80000Der Aservatentruck wurde nicht erfolgreich entladen!",5,200,200,0)
	outputLog("Der Aservatentruck wurde erfolgreich nicht entladen!","Fraktion")
	setElementData(aservatentruck,"actionvehicle",false)
	
	if(isElement(aservatentruck))then
		aservatentruck:destroy()
	end
	if(isElement(DRUGSBOX))then
		DRUGSBOX:destroy()
	end
	if(isElement(drogentruckBLIP))then
		drogentruckBLIP:destroy()
	end
	aktionlaeuft=false
	setTimer(function()aservatentruck=false end,60*60*1000,1)
	setTimer(function()aktionlaeuft=false end,aktionpuffer,1)
	setElementVisibleTo(deliverDrugtruckMarker,root,false)
	setElementVisibleTo(deliverAservatentruckBlip,root,false)
	if isTimer(aservatentruckTimer)then
		killTimer(aservatentruckTimer)
		aservatentruckTimer=nil
	end
	local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","factiondepots","Faction",tonumber(syncGetElementData(player,"Faction"))),-1)
	if(result and result[1])then
		local rdm=math.random(1,3)
		if(rdm==1)then
			handler:exec("UPDATE ?? SET ??=? WHERE ??=?","factiondepots","Weed",tonumber(result[1]["Weed"])+2500,"Faction",tonumber(syncGetElementData(player,"Faction")))
			outputChatBox("Du hast den Aservatentruck geklaut und x2500 Weed für deine Fraktion gefahren!",player,255,255,255)
		elseif(rdm==2)then
			handler:exec("UPDATE ?? SET ??=? WHERE ??=?","factiondepots","Mats",tonumber(result[1]["Mats"])+2500,"Faction",tonumber(syncGetElementData(player,"Faction")))
			outputChatBox("Du hast den Aservatentruck geklaut und x2500 Mats für deine Fraktion gefahren!",player,255,255,255)
		elseif(rdm==3)then
			handler:exec("UPDATE ?? SET ??=? WHERE ??=?","factiondepots","Kokain",tonumber(result[1]["Kokain"])+2500,"Faction",tonumber(syncGetElementData(player,"Faction")))
			outputChatBox("Du hast den Aservatentruck geklaut und x2500 Kokain für deine Fraktion gefahren!",player,255,255,255)
		end
	end
	setElementData(player,"seatbelt",false)
	triggerClientEvent(player,"stop:seatbeltsound",player)
end

addEventHandler("onMarkerHit",deliverDrugtruckMarker,function(player)
	if(isElement(player)and getElementType(player)=="player")then
		if(isSTATE(player)and syncGetElementData(player,"CopDuty")==true)then
			if(getPedOccupiedVehicleSeat(player)==0)then
				local veh=getPedOccupiedVehicle(player)
				if(veh==aservatentruck)then
					if(getElementHealth(veh)>=250)then
						aservatentruckSuccessfull(player) 
					end
				end
			end
		end
	end
end)
addEventHandler("onMarkerHit",deliverDrugtruckMarker,function(player)
	if(isElement(player)and getElementType(player)=="player")then
		if(isEVIL(player))then
			if(getPedOccupiedVehicleSeat(player)==0)then
				local veh=getPedOccupiedVehicle(player)
				if(veh==aservatentruck)then
					if(getElementHealth(veh)>=250)then
						aservatentruckNotSuccessfull(player) 
					end
				end
			end
		end
	end
end)