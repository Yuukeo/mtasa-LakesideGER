--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local ptuningmarker=createMarker(1851.5,-1856.5,12.6,"cylinder",3,255,255,255,140)

setGarageOpen(3,true)

local allowed=true
function enterPTuningshop(elem)
	if(elem)then
		if(getVehicleOccupant(elem,0)~=false and getVehicleOccupant(elem,1)==false and getVehicleOccupant(elem,2)==false and getVehicleOccupant(elem,3)==false)then
			local player=getVehicleOccupant(elem)
			if(player)then
				if(allowed==true)then
					if(getElementData(elem,"Owner")==getPlayerName(player)and getElementData(elem,"Slot"))then
						local rdmDIM=math.random(1000,6000)
						setElementVelocity(elem,0,0,0)
						setElementPosition(elem,614.5,-124.1,997.7)
						setElementRotation(elem,0,0,90)
						setElementInterior(elem,3)
						setElementInterior(player,3)
						setElementDimension(player,rdmDIM)
						setElementDimension(elem,rdmDIM)
						setElementFrozen(elem,true)
						setElementData(elem,"Previewdoors",1)
						setElementData(player,"InPTuninggarage",true)
						triggerClientEvent(player,"show:ptuningUI",player)
					else
						triggerClientEvent(player,"draw:infobox",root,"error","Du kannst nur Privatfahrzeuge tunen!")
					end
				else
					triggerClientEvent(player,"draw:infobox",root,"error","Kommt noch...")
				end
			end
		end
	end
end
addEventHandler("onMarkerHit",ptuningmarker,enterPTuningshop)

function leavePTuningshop(player)
	local veh=getPedOccupiedVehicle(player)
	if(veh)then
		setCameraTarget(player,player)
		setElementPosition(veh,1841.3332519531,-1871.7397460938,13.389747619629)
		setElementDimension(player,0)
		setElementDimension(veh,0)
		setElementInterior(player,0)
		setElementInterior(veh,0)
		setElementFrozen(veh,false)
		setElementData(player,"InPTuninggarage",false)
		if(getElementData(veh,"Fluegeldoors")==1)then
			setElementData(veh,"Previewdoors",1)
		else
			setElementData(veh,"Previewdoors",0)
		end
		triggerClientEvent("load:vehiclePaintjob",veh,tostring(getElementData(veh,"Paintjob")),veh)
		triggerClientEvent("load:vehicleLight",veh,tostring(getElementData(veh,"Lights")),veh)
	end
end
addEvent("leave:ptuning",true)
addEventHandler("leave:ptuning",root,leavePTuningshop)

--//Paintjob
function lookPaintjob(player,veh,typ)
	local veh=getPedOccupiedVehicle(player)
	if(veh)then
		local vehslot=getElementData(veh,"Slot")
		local vehowner=getElementData(veh,"Owner")
		if(vehslot)then
			if(vehowner==getPlayerName(player))then
				if(typ)then
					triggerClientEvent("load:vehiclePaintjob",veh,typ,veh)
				end
			end
		end
	end
end
addEvent("show:ptuningPaintjob",true)
addEventHandler("show:ptuningPaintjob",root,lookPaintjob)
function buyPaintjob(player,veh,typ,price)
	local price=tonumber(price)
	local veh=getPedOccupiedVehicle(player)
	local money=tonumber(syncGetElementData(player,"Money"))
	if(veh)then
		local vehslot=getElementData(veh,"Slot")
		local vehowner=getElementData(veh,"Owner")
		if(vehslot)then
			if(vehowner==getPlayerName(player))then
				if(money>=price)then
					if(typ)then
						if(getElementData(veh,"Paintjob")~=typ)then
							syncSetElementData(player,"Money",tonumber(syncGetElementData(player,"Money"))-price)
							setElementData(veh,"Paintjob",typ)
							handler:exec("UPDATE ?? SET ??=? WHERE ??=? AND ??=?","uservehicles","Paintjob",typ,"Owner",vehowner,"Slot",vehslot)
							triggerClientEvent("load:vehiclePaintjob",veh,typ,veh)
							triggerClientEvent(player,"draw:infobox",root,"success","Speziallackierung erfolgreich eingebaut!")
						else
							triggerClientEvent(player,"draw:infobox",root,"error","Dein Fahrzeug hat diese Lackierung bereits!")
						end
					end
				else
					triggerClientEvent(player,"draw:infobox",root,"error","Du hast nicht genug Bargeld! ($"..price..")")
				end
			end
		end
	end
end
addEvent("buy:ptuningPaintjob",true)
addEventHandler("buy:ptuningPaintjob",root,buyPaintjob)
function sellPaintjob(player,veh)
	local veh=getPedOccupiedVehicle(player)
	if(veh)then
		local vehslot=getElementData(veh,"Slot")
		local vehowner=getElementData(veh,"Owner")
		if(vehslot)then
			if(vehowner==getPlayerName(player))then
				if(getElementData(veh,"Paintjob")~="0")then
					setElementData(veh,"Paintjob","0")
					handler:exec("UPDATE ?? SET ??=? WHERE ??=? AND ??=?","uservehicles","Paintjob","0","Owner",vehowner,"Slot",vehslot)
					triggerClientEvent("load:vehiclePaintjob",veh,"0",veh)
					triggerClientEvent(player,"draw:infobox",root,"success","Speziallackierung erfolgreich ausgebaut!")
				else
					triggerClientEvent(player,"draw:infobox",root,"error","Dein Fahrzeug beseitzt keine Speziallackierung!")
				end
			end
		end
	end
end
addEvent("sell:ptuningPaintjob",true)
addEventHandler("sell:ptuningPaintjob",root,sellPaintjob)
--//Lights
function lookLights(player,veh,typ)
	local veh=getPedOccupiedVehicle(player)
	if(veh)then
		local vehslot=getElementData(veh,"Slot")
		local vehowner=getElementData(veh,"Owner")
		if(vehslot)then
			if(vehowner==getPlayerName(player))then
				if(typ)then
					triggerClientEvent("load:vehicleLight",veh,typ,veh)
				end
			end
		end
	end
end
addEvent("show:ptuningLight",true)
addEventHandler("show:ptuningLight",root,lookLights)
function buyLights(player,veh,typ,price)
	local price=tonumber(price)
	local veh=getPedOccupiedVehicle(player)
	local money=tonumber(syncGetElementData(player,"Money"))
	if(veh)then
		local vehslot=getElementData(veh,"Slot")
		local vehowner=getElementData(veh,"Owner")
		if(vehslot)then
			if(vehowner==getPlayerName(player))then
				if(money>=price)then
					if(typ)then
						if(getElementData(veh,"Lights")~=typ)then
							syncSetElementData(player,"Money",tonumber(syncGetElementData(player,"Money"))-price)
							setElementData(veh,"Lights",typ)
							handler:exec("UPDATE ?? SET ??=? WHERE ??=? AND ??=?","uservehicles","Lights",typ,"Owner",vehowner,"Slot",vehslot)
							triggerClientEvent("load:vehicleLight",veh,typ,veh)
							triggerClientEvent(player,"draw:infobox",root,"success","Speziallichter erfolgreich eingebaut!")
						else
							triggerClientEvent(player,"draw:infobox",root,"error","Dein Fahrzeug hat diese Lackierung bereits!")
						end
					end
				else
					triggerClientEvent(player,"draw:infobox",root,"error","Du hast nicht genug Bargeld! ($"..price..")")
				end
			end
		end
	end
end
addEvent("buy:ptuningLight",true)
addEventHandler("buy:ptuningLight",root,buyLights)
function sellLights(player,veh)
	local veh=getPedOccupiedVehicle(player)
	if(veh)then
		local vehslot=getElementData(veh,"Slot")
		local vehowner=getElementData(veh,"Owner")
		if(vehslot)then
			if(vehowner==getPlayerName(player))then
				if(getElementData(veh,"Lights")~="0")then
					setElementData(veh,"Lights","0")
					handler:exec("UPDATE ?? SET ??=? WHERE ??=? AND ??=?","uservehicles","Lights","0","Owner",vehowner,"Slot",vehslot)
					triggerClientEvent("load:vehicleLight",veh,"0",veh)
					triggerClientEvent(player,"draw:infobox",root,"success","Speziallichter erfolgreich ausgebaut!")
				else
					triggerClientEvent(player,"draw:infobox",root,"error","Dein Fahrzeug beseitzt keine Speziallichter!")
				end
			end
		end
	end
end
addEvent("sell:ptuningLight",true)
addEventHandler("sell:ptuningLight",root,sellLights)

function buyFluegeldoors(player,veh)
	local veh=getPedOccupiedVehicle(player)
	local money=tonumber(syncGetElementData(player,"Money"))
	if(veh)then
		local vehslot=getElementData(veh,"Slot")
		local vehowner=getElementData(veh,"Owner")
		if(vehslot)then
			if(vehowner==getPlayerName(player))then
				if(money>=80000)then
					if(getElementData(veh,"Fluegeldoors")~=1)then
						syncSetElementData(player,"Money",tonumber(syncGetElementData(player,"Money"))-80000)
						setElementData(veh,"Fluegeldoors",1)
						handler:exec("UPDATE ?? SET ??=? WHERE ??=? AND ??=?","uservehicles","Fluegeldoors",1,"Owner",vehowner,"Slot",vehslot)
						triggerClientEvent(player,"draw:infobox",root,"success","Flügeltüren erfolgreich eingebaut!")
					else
						triggerClientEvent(player,"draw:infobox",root,"error","Dein Fahrzeug hat bereits Flügeltüren!")
					end
				else
					triggerClientEvent(player,"draw:infobox",root,"error","Du hast nicht genug Bargeld! ($80.000)")
				end
			end
		end
	end
end
addEvent("buy:ptuningdoors",true)
addEventHandler("buy:ptuningdoors",root,buyFluegeldoors)
function sellFluegeldoors(player,veh)
	local veh=getPedOccupiedVehicle(player)
	if(veh)then
		local vehslot=getElementData(veh,"Slot")
		local vehowner=getElementData(veh,"Owner")
		if(vehslot)then
			if(vehowner==getPlayerName(player))then
				if(getElementData(veh,"Fluegeldoors")~=0)then
					syncSetElementData(player,"Money",tonumber(syncGetElementData(player,"Money"))+40000)
					setElementData(veh,"Fluegeldoors",0)
					handler:exec("UPDATE ?? SET ??=? WHERE ??=? AND ??=?","uservehicles","Fluegeldoors",0,"Owner",vehowner,"Slot",vehslot)
					triggerClientEvent("load:vehicleLight",veh,"0",veh)
					triggerClientEvent(player,"draw:infobox",root,"success","Flügeltüren erfolgreich ausgebaut!")
				else
					triggerClientEvent(player,"draw:infobox",root,"error","Dein Fahrzeug beseitzt keine Flügeltüren!")
				end
			end
		end
	end
end
addEvent("sell:ptuningdoors",true)
addEventHandler("sell:ptuningdoors",root,sellFluegeldoors)










function loadPaintjobAfterLogin(player)
	local result=dbPoll(dbQuery(handler,"SELECT * FROM ??","uservehicles"),-1)
	if(result and result[1])then
		for i=1,#result do
			local dsatz=result[i]
			local owner=dsatz["Owner"]
			if(owner)then
				triggerClientEvent(player,"load:vehiclePaintjob",player,dsatz["Paintjob"],Vehicles[dsatz["Owner"]..dsatz["Slot"]])
				triggerClientEvent(player,"load:vehicleLight",player,dsatz["Lights"],Vehicles[dsatz["Owner"]..dsatz["Slot"]])
			end
		end
	end
end
addEvent("load:vehiclePaintjobAfterLogin",true)
addEventHandler("load:vehiclePaintjobAfterLogin",root,loadPaintjobAfterLogin)