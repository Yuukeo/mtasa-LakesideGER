--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

addEvent("buy:gangvehicle",true)
addEventHandler("buy:gangvehicle",root,function(vehid,price)
	local Owner=tonumber(syncGetElementData(client,"Faction"))
	
	if(isEVIL(client))then
		local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","factiondepots","Faction",Owner),-1)
		if(result or result[1])then
			if(tonumber(result[1]["Money"])>=tonumber(price))then
				local rdmPlate=math.random(1000,9999)
				local IDcounter=dbPoll(dbQuery(handler,"SELECT ?? FROM ?? WHERE FVID=FVID","FVID","globalcounter"),-1)[1]["FVID"]
				handler:exec("UPDATE ?? SET ??=?","globalcounter","FVID",IDcounter+1)
				local SpawnX,SpawnY,SpawnZ,RotX,RotY,RotZ=-59.7,-1582.4,2.6,0,0,0
				
				FactionVehicles[Owner..IDcounter]=createVehicle(vehid,SpawnX,SpawnY,SpawnZ,RotX,RotY,RotZ,rdmPlate)
				
				setElementData(FactionVehicles[Owner..IDcounter],"ID",IDcounter)
				setElementData(FactionVehicles[Owner..IDcounter],"Owner",Owner)
				setElementHealth(FactionVehicles[Owner..IDcounter],1000)
				setElementData(FactionVehicles[Owner..IDcounter],"Fuel",100)
				setElementData(FactionVehicles[Owner..IDcounter],"Plate",rdmPlate)
				setVehicleOverrideLights(FactionVehicles[Owner..IDcounter],1)
				
				setVehicleLocked(FactionVehicles[Owner..IDcounter],true)
				if(getElementData(FactionVehicles[Owner..IDcounter],"Owner")==3)then
					setVehicleColor(FactionVehicles[Owner..IDcounter],settings.faction.ranknames.color[3][1],settings.faction.ranknames.color[3][2],settings.faction.ranknames.color[3][3],settings.faction.ranknames.color[3][1],settings.faction.ranknames.color[3][2],settings.faction.ranknames.color[3][3])
				elseif(getElementData(FactionVehicles[Owner..IDcounter],"Owner")==4)then
					setVehicleColor(FactionVehicles[Owner..IDcounter],settings.faction.ranknames.color[4][1],settings.faction.ranknames.color[4][2],settings.faction.ranknames.color[4][3],settings.faction.ranknames.color[4][1],settings.faction.ranknames.color[4][2],settings.faction.ranknames.color[4][3])
				elseif(getElementData(FactionVehicles[Owner..IDcounter],"Owner")==5)then
					setVehicleColor(FactionVehicles[Owner..IDcounter],settings.faction.ranknames.color[5][1],settings.faction.ranknames.color[5][2],settings.faction.ranknames.color[5][3],settings.faction.ranknames.color[5][1],settings.faction.ranknames.color[5][2],settings.faction.ranknames.color[5][3])
				end
				setElementDimension(FactionVehicles[Owner..IDcounter],0)
				
				warpPedIntoVehicle(client,FactionVehicles[Owner..IDcounter])
				
				triggerClientEvent(client,"draw:infobox",root,"success","Du hast das Gang-Fahrzeug erfolgreich gekauft!")
				handler:exec("INSERT INTO factionvehicles (ID,Owner,VehID,SpawnX,SpawnY,SpawnZ,RotX,RotY,RotZ,Fuel,Plate) VALUES (?,?,?,?,?,?,?,?,?,?,?)",IDcounter,Owner,vehid,SpawnX,SpawnY,SpawnZ,RotX,RotY,RotZ,'100',rdmPlate)
				handler:exec("UPDATE ?? SET ??=? WHERE ??=?","factiondepots","Money",tonumber(result[1]["Money"])-price,"Faction",Owner)
				
				loadFactionVehicles(Owner)
			else
				triggerClientEvent(client,"draw:infobox",root,"error","Es ist nicht genug Geld in der Kasse! ($"..price..")")
			end
		end
	end
end)



addEvent("get:gangbuyablevehicles",true)
addEventHandler("get:gangbuyablevehicles",root,function()
	local result=dbPoll(dbQuery(handler,"SELECT * FROM ??","gangdealercars"),-1)
	if(#result>=1)then
		local tbl={}
		for _,v in pairs(result)do
			table.insert(tbl,{v["ID"],getVehicleNameFromModel(v["VehID"]),v["Price"]})
		end
		triggerClientEvent(client,"show:gangbuyablevehicles",client,tbl)
	end
end)