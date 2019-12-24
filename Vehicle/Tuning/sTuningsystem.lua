--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo) & Xendom       ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

setGarageOpen(7,true)
setGarageOpen(10,true)
setGarageOpen(15,true)
setGarageOpen(18,true)
setGarageOpen(33,true)

addEventHandler("onResourceStart",resourceRoot,function()
	for i,v in ipairs(Tuningsystem["Marker"])do
		Tuningsystem[i]=createMarker(v[1],v[2],v[3],"cylinder",3,255,0,0,150)
		setElementData(Tuningsystem[i],"TuningID",i)
		
		addEventHandler("onMarkerHit",Tuningsystem[i],function(player)
			if(getElementDimension(player)==getElementDimension(source))then
				if(getElementType(player)=="vehicle")then
					local player=getVehicleOccupant(player,0)
					local veh=getPedOccupiedVehicle(player)
					if(getVehicleOccupant(veh,0)~=false and getVehicleOccupant(veh,1)==false and getVehicleOccupant(veh,2)==false and getVehicleOccupant(veh,3)==false)then
						if(getElementData(veh,"Owner")and getElementData(veh,"Slot"))then
							local state=false
							for i=1,3 do
								if(getVehicleOccupant(veh,i)==true)then
									state=true
									break
								end
							end
							if(state==false)then
								local dim=math.random(10000,50000)
								setElementPosition(veh,614.5,-124.1,997.7)
								setElementRotation(veh,0,0,90)
								setElementInterior(veh,3)
								setElementInterior(player,3)
								setElementDimension(player,dim)
								setElementDimension(veh,dim)
								triggerClientEvent(player,"open:tuningpanel",player)
								setElementData(player,"InTuninggarage",true)
								setElementData(player,"TuningID",getElementData(source,"TuningID"))
							end
						end
					end
				end
			end
		end)
	end
end)

addEvent("spawn:tuninggarage",true)
addEventHandler("spawn:tuninggarage",root,function()
	setTimer(function(client)
		local ID=getElementData(client,"TuningID")
		setElementData(client,"InTuninggarage",false)
		local tbl=Tuningsystem["Spawn"][ID]
		local veh=getPedOccupiedVehicle(client)
		setElementPosition(veh,tbl[1],tbl[2],tbl[3])
		setElementRotation(veh,0,0,tbl[4])
		setElementInterior(veh,0)
		setElementInterior(client,0)
		setElementDimension(veh,0)
		setElementDimension(client,0)
		setCameraTarget(client)
		loadVehicleTunings(veh)
	end,100,1,client)
end)

addEvent("addremoveshow:tuningpart",true)
addEventHandler("addremoveshow:tuningpart",root,function(typ,typ2,price,part)
	local price=tonumber(price)
	local veh=getPedOccupiedVehicle(client)
	local owner=getElementData(veh,"Owner")
	local slot=getElementData(veh,"Slot")
	if(typ)and(typ2)then
		if(typ=="normal")then
			if(typ2=="add")then
				if(tonumber(syncGetElementData(client,"Money"))>=price)then
					if(part)then
						veh:addUpgrade(part)
						saveVehicleTunings(veh)
						syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-price)
						triggerClientEvent(client,"draw:infobox",root,"success","Tuningpart erfolgreich gekauft!")
					end
				else
					triggerClientEvent(client,"draw:infobox",root,"error","Du hast nicht genug Bargeld! ($"..price..")")
				end
			elseif(typ2=="remove")then
				if(part)then
					removeVehicleUpgrade(veh,part)
					saveVehicleTunings(veh)
					triggerClientEvent(client,"draw:infobox",root,"success","Tuningpart erfolgreich gelöscht!")
				end
			elseif(typ2=="show")then
				if(part)then
					veh:addUpgrade(part)
				end
			end
		end
	end
end)

function saveVehicleTunings(veh)
	local tunings=""
	for i=0,16 do
		local upgrade=getVehicleUpgradeOnSlot(veh,i)
		if(upgrade)then
			tunings=tunings..upgrade.."|"
		else
			tunings=tunings.."0|"
		end
	end
	dbExec(handler,"UPDATE ?? SET ??=? WHERE ??=? AND ??=?","uservehicles","Tunings",tunings,"Owner",getElementData(veh,"Owner"),"Slot",getElementData(veh,"Slot"))
end

function loadVehicleTunings(veh)
	for i=0,16 do
		local upgrade=getVehicleUpgradeOnSlot(veh,i)
		if(upgrade)then
			removeVehicleUpgrade(veh,upgrade)
		end
	end
	
	local result=dbPoll(dbQuery(handler,"SELECT ?? FROM ?? WHERE ??=? AND ??=?","Tunings","uservehicles","Owner",getElementData(veh,"Owner"),"Slot",getElementData(veh,"Slot")),-1)
	if(result and result[1])then
		local tunings=result[1]["Tunings"]
		for i=1,17 do
			local tstring=gettok(tunings,i,string.byte("|"))
			if(tstring and #tstring>=1 and tstring~=0)then
				veh:addUpgrade(tstring)
			end
		end
	end
	
	local colors=getVVdata("uservehicles","Owner",getElementData(veh,"Owner"),"Slot",getElementData(veh,"Slot"),"Color")
	local r=tonumber(gettok(colors,1,string.byte("|")))
	local g=tonumber(gettok(colors,2,string.byte("|")))
	local b=tonumber(gettok(colors,3,string.byte("|")))
	veh:setColor(r,g,b,r,g,b)
	veh:setHeadLightColor(r,g,b)
end
addEvent("load:vehicletunings",true)
addEventHandler("load:vehicletunings",root,loadVehicleTunings)



addEvent("set:vehiclecolor",true)
addEventHandler("set:vehiclecolor",root,function(r,g,b)
	if(tonumber(syncGetElementData(client,"Money"))>=1500)then
		local veh=getPedOccupiedVehicle(client)
		veh:setColor(r,g,b,r,g,b)
		veh:setHeadLightColor(r,g,b)
		local Color=r.."|"..g.."|"..b
		dbExec(handler,"UPDATE ?? SET ??=? WHERE ??=? AND ??=?","uservehicles","Color",Color,"Owner",getElementData(veh,"Owner"),"Slot",getElementData(veh,"Slot"))
		syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-1500)
	end
end)