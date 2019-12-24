--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local faggiorollerTable={}

function rentScooter()
	if(tonumber(syncGetElementData(client,"Money"))>=settings.vehicle.rentPrice)then
		syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-settings.vehicle.rentPrice)
		local x,y,z=getElementPosition(client)
		local rdm=math.random(10000,999999)
		
		if(faggiorollerTable[client]~=nil)then
			faggiorollerTable[client]:destroy()
			faggiorollerTable[client]=nil
		end
		
		if(getDistanceBetweenPoints3D(1743.1,-1864.1,13.6,x,y,z)<=10)then--Newbie spawn
			faggiorollerTable[client]=createVehicle(462,1748.2,-1862,13.6,0,0,0,rdm)
			faggiorollerTable[client]:setColor(0,80,200,0,80,200)
			setVehicleHandling(faggiorollerTable[client],"maxVelocity",45.0)
			
			setElementData(faggiorollerTable[client],"Owner",getPlayerName(client))
			setElementData(faggiorollerTable[client],"Totalloss",0)
			setElementData(faggiorollerTable[client],"Fuel",100)
			
			warpPedIntoVehicle(client,faggiorollerTable[client])
			triggerClientEvent("load:vehiclePaintjob",faggiorollerTable[client],"0",faggiorollerTable[client])
			
			triggerClientEvent(client,"draw:infobox",root,"info","Roller erfolgreich gemietet!")
			triggerEvent("set:task",client,client,"Scooter")
		elseif(getDistanceBetweenPoints3D(1184.8,-1304.5,14.2,x,y,z)<=10)then--Hospital
			faggiorollerTable[client]=createVehicle(462,1184.8,-1305.8,13.6,0,0,270,rdm)
			faggiorollerTable[client]:setColor(0,80,200,0,80,200)
			setVehicleHandling(faggiorollerTable[client],"maxVelocity",45.0)
			
			setElementData(faggiorollerTable[client],"Owner",getPlayerName(client))
			setElementData(faggiorollerTable[client],"Totalloss",0)
			setElementData(faggiorollerTable[client],"Fuel",100)
			
			warpPedIntoVehicle(client,faggiorollerTable[client])
			triggerClientEvent("load:vehiclePaintjob",faggiorollerTable[client],"0",faggiorollerTable[client])
			
			triggerClientEvent(client,"draw:infobox",root,"info","Roller erfolgreich gemietet!")
			triggerEvent("set:task",client,client,"Scooter")
		elseif(getDistanceBetweenPoints3D(1461.2,-1715.9,14.1,x,y,z)<=10)then--Stadthalle
			faggiorollerTable[client]=createVehicle(462,1462.4,-1716.8,14.1,0,0,180,rdm)
			faggiorollerTable[client]:setColor(0,80,200,0,80,200)
			setVehicleHandling(faggiorollerTable[client],"maxVelocity",45.0)
			
			setElementData(faggiorollerTable[client],"Owner",getPlayerName(client))
			setElementData(faggiorollerTable[client],"Totalloss",0)
			setElementData(faggiorollerTable[client],"Fuel",100)
			
			warpPedIntoVehicle(client,faggiorollerTable[client])
			triggerClientEvent("load:vehiclePaintjob",faggiorollerTable[client],"0",faggiorollerTable[client])
			
			triggerClientEvent(client,"draw:infobox",root,"info","Roller erfolgreich gemietet!")
			triggerEvent("set:task",client,client,"Scooter")
		elseif(getDistanceBetweenPoints3D(1809.3,-1566.9,13.5,x,y,z)<=10)then--Knast
			faggiorollerTable[client]=createVehicle(462,1810.8,-1566.9,13.1,0,0,216,rdm)
			faggiorollerTable[client]:setColor(0,80,200,0,80,200)
			setVehicleHandling(faggiorollerTable[client],"maxVelocity",45.0)
			
			setElementData(faggiorollerTable[client],"Owner",getPlayerName(client))
			setElementData(faggiorollerTable[client],"Totalloss",0)
			setElementData(faggiorollerTable[client],"Fuel",100)
			
			warpPedIntoVehicle(client,faggiorollerTable[client])
			triggerClientEvent("load:vehiclePaintjob",faggiorollerTable[client],"0",faggiorollerTable[client])
			
			triggerClientEvent(client,"draw:infobox",root,"info","Roller erfolgreich gemietet!")
			triggerEvent("set:task",client,client,"Scooter")
		end
		
		removeEventHandler("onPlayerQuit",client,destroyScooter)
		addEventHandler("onPlayerQuit",client,destroyScooter)
	else
		triggerClientEvent(client,"draw:infobox",root,"error","Du hast nicht genug Bargeld! ($"..settings.vehicle.rentPrice..")")
	end
end
addEvent("rent:vehicle",true)
addEventHandler("rent:vehicle",root,rentScooter)

function destroyScooter(player)
	if(player and isElement(player)and getElementType(player)=="player")or(source and isElement(source)and getElementType(source)=="player")then
		if(source and isElement(source)and getElementType(source)=="player")then
			if(faggiorollerTable[source])then
				faggiorollerTable[source]:destroy()
				faggiorollerTable[source]=nil
			end
		end
	end
end