--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

addEventHandler("onVehicleStartEnter",root,function(player)
	if(getPedOccupiedVehicleSeat(player)==0)then
		if(getElementData(source,"veh:jobbus")==true)then
			if(syncGetElementData(player,"Job")~="Busdriver")then
				cancelEvent(true)
				triggerClientEvent(player,"draw:infobox",root,"error","Du bist kein Busfahrer!")
			end
		elseif(getElementData(source,"veh:jobpizza")==true)then
			if(syncGetElementData(player,"Job")~="Pizzaboy")then
				cancelEvent(true)
				triggerClientEvent(player,"draw:infobox",root,"error","Du bist kein Pizzalieferant!")
			end
		elseif(getElementData(source,"veh:jobtaxi")==true)then
			if(syncGetElementData(player,"Job")~="Taxidriver")then
				cancelEvent(true)
				triggerClientEvent(player,"draw:infobox",root,"error","Du bist kein Taxifahrer!")
			end
		end
	end
end)

addEventHandler("onVehicleEnter",root,function(player)
	if(getElementData(source,"veh:jobbus")==true)then
		if(getPedOccupiedVehicleSeat(player)==0)then
			if(syncGetElementData(player,"Job")~="Busdriver")then
				removePedFromVehicle(player)
				triggerClientEvent(player,"draw:infobox",root,"error","Du bist kein Busfahrer!")
			else
				setElementFrozen(source,false)
				setElementData(player,"ImBusjob",true)
				triggerClientEvent(player,"createBusMarker",player,"create")
			end
		end
	end
	if(getElementData(source,"veh:jobpizza")==true)then
		if(getPedOccupiedVehicleSeat(player)==0)then
			if(syncGetElementData(player,"Job")~="Pizzaboy")then
				removePedFromVehicle(player)
				triggerClientEvent(player,"draw:infobox",root,"error","Du bist kein Pizzalieferant!")
			else
				if(isElement(pizzaObject[player])or pizzaFirst[player]==true)then
					if(isTimer(pizzaTimer[source]))then
						killTimer(pizzaTimer[source])
					end
					setElementFrozen(source,false)
					if(isElement(pizzaObject[player]))then
						destroyElement(pizzaObject[player])
					end
					if(pizzaLoaded[player]==true and isPizzaMarker[player]~=true)then
						triggerClientEvent(player,"createPizzaMarker",player,"create")
						isPizzaMarker[player]=true
					end
					pizzaFirst[player]=true
				else
					removePedFromVehicle(player)
					pizzaFirst[player]=false
					triggerClientEvent(player,"draw:infobox",root,"warning","Hole zuerst eine Pizza\naus der Küche!")
				end
			end
		end
	end
	if(getElementData(source,"veh:jobtaxi")==true)then
		if(getPedOccupiedVehicleSeat(player)==0)then
			if(syncGetElementData(player,"Job")~="Taxidriver")then
				removePedFromVehicle(player)
				triggerClientEvent(player,"draw:infobox",root,"error","Du bist kein Taxifahrer!")
			else
				setElementFrozen(source,false)
				setElementData(player,"ImTaxijob",true)
			end
		else
			if(getElementType(player)=="player")then
				local veh=getPedOccupiedVehicle(player)
				taxiPayTimer[player]=setTimer(function(player)
					local driver=getVehicleOccupant(veh,0)
					if(driver)then
						if(tonumber(syncGetElementData(player,"Money"))>=11)then
							syncSetElementData(player,"Money",tonumber(syncGetElementData(player,"Money"))-11)
							syncSetElementData(driver,"Jobmoney",tonumber(syncGetElementData(driver,"Jobmoney"))+11)
							infoShow(driver,"plus","Du erhälst $11 auf dein Jobgehalt.")
						else
							removePedFromVehicle(player)
							triggerClientEvent(player,"draw:infobox",root,"error","Du hast nicht genug Bargeld! ($11)")
						end
					end
				end,3000,0,player)
			end
		end
	end
	if(getElementData(source,"veh:holztruck")==true)then
		if(getPedOccupiedVehicleSeat(player)==0)then
			if(syncGetElementData(player,"Job")~="Holzfaeller")then
				removePedFromVehicle(player)
				triggerClientEvent(player,"draw:infobox",root,"error","Du bist kein Holzfäller!")
			else
				--if(isTimer(HolzfaellerTruckDespawn[source]))then
				--	HolzfaellerTruckDespawn[source]:destroy()
				--end
			end
		end
	end
end)
addEventHandler("onVehicleExit",root,function(player)
	if(getElementData(source,"veh:jobbus")==true)then
		if(getElementData(player,"ImBusjob")==true)then
			respawnVehicle(source)
			fixVehicle(source)
			setElementFrozen(source,true)
			setVehicleEngineState(source,false)
			setElementData(source,"engine",false)
			setElementData(source,"Fuel",100)
			setElementData(player,"ImBusjob",false)
			triggerClientEvent(player,"createBusMarker",player)
			triggerClientEvent(player,"refreshBusMarker",player)
		end
	end
	if(getElementData(source,"veh:jobpizza")==true)then
		if(syncGetElementData(player,"Job")=="Pizzaboy")then
			if(not isTimer(pizzaTimer[source]))then
				pizzaTimer[source]=setTimer(function(source)
					respawnVehicle(source)
					fixVehicle(source)
					setElementFrozen(source,true)
					setVehicleEngineState(source,false)
					setElementData(source,"engine",false)
					setElementData(source,"Fuel",100)
					pizzaFirst[player]=false
					triggerClientEvent(player,"draw:infobox",root,"info","Pizzaroller respawnt!")
				end,2*60*1000,1,source)
				if(pizzaLoaded[player]==true)then
					createPlayerPizza(player)
				end
			end
		end
	end
	if(getElementData(source,"veh:jobtaxi")==true)then
		if(getElementData(player,"ImTaxijob")==true)then
			respawnVehicle(source)
			fixVehicle(source)
			setElementFrozen(source,true)
			setVehicleEngineState(source,false)
			setElementData(source,"engine",false)
			setElementData(source,"Fuel",100)
		end
	end
	if(getElementData(source,"veh:holztruck")==true)then
		--HolzfaellerTruckDespawn[source]=setTimer(function(source)
		--	HolzfaellerDestroy(player)
		--end,5*60*1000,1,source)
	end
	if(isTimer(taxiPayTimer[player]))then
		taxiPayTimer[player]:destroy()
	end
end)

addEventHandler("onVehicleExplode",root,function()
	if(isTimer(pizzaTimer[source]))then
		pizzaTimer[source]:destroy()
	end
	if(isTimer(taxiPayTimer[source]))then
		taxiPayTimer[source]:destroy()
	end
	--if(isTimer(HolzfaellerTruckDespawn[source]))then
	--	HolzfaellerTruckDespawn[source]:destroy()
	--end
end)

function giveJobMoney(typ,amount)
	if(typ)then
		if(amount)then
			if(typ=="Busdriver" or typ=="Pizzaboy" or typ=="Taxidriver" or typ=="Holzfaeller")then
				syncSetElementData(client,"Jobmoney",tonumber(syncGetElementData(client,"Jobmoney"))+amount)
				uLevel(client,"Job")
				infoShow(client,"plus","Du erhälst $"..amount.." auf dein Jobgehalt.")
				if(typ=="Holzfaeller")then
					local rdmexp=math.random(22,40)
					uEXP(client,"Job",rdmexp)
					uLevel(client,"Job")
				end
				if(typ=="Busdriver")then
					local rdmexp=math.random(9,22)
					uEXP(client,"Job",rdmexp)
					uLevel(client,"Job")
				end
				if(typ=="Taxidriver")then
					local rdmexp=math.random(6,22)
					uEXP(client,"Job",rdmexp)
					uLevel(client,"Job")
				end
				if(typ=="Pizzaboy")then
					local rdmexp=math.random(6,15)
					uEXP(client,"Job",rdmexp)
					uLevel(client,"Job")
				end
			end
		end
	end
end
addEvent("give:jobmoney",true)
addEventHandler("give:jobmoney",root,giveJobMoney)


function setPlayerJob(player,typ)
	if(syncGetElementData(player,"Ausweis")==1)then
		if(typ=="Busdriver")then
			if(syncGetElementData(player,"Joblevel")>=2)then
				HolzfaellerDestroy(player)
				syncSetElementData(player,"Job","Busdriver")
				triggerClientEvent(player,"draw:infobox",root,"success","Du hast den Job als Busfahrer angenommen!")
			else
				triggerClientEvent(player,"draw:infobox",root,"error","Du benötigst Joblevel 2+")
			end
		elseif(typ=="Holzfaeller")then
			if(syncGetElementData(player,"Joblevel")>=3)then
				syncSetElementData(player,"Job","Holzfaeller")
				triggerClientEvent(player,"draw:infobox",root,"success","Du hast den Job als Holzfäller angenommen!")
			else
				triggerClientEvent(player,"draw:infobox",root,"error","Du benötigst Joblevel 3+")
			end
		elseif(typ=="Pizzaboy")then
			HolzfaellerDestroy(player)
			syncSetElementData(player,"Job","Pizzaboy")
			triggerClientEvent(player,"draw:infobox",root,"success","Du hast den Job als Pizzalieferant angenommen!")
		elseif(typ=="Taxidriver")then
			HolzfaellerDestroy(player)
			syncSetElementData(player,"Job","Taxidriver")
			triggerClientEvent(player,"draw:infobox",root,"success","Du hast den Job als Taxifahrer angenommen!")
		end
	else
		triggerClientEvent(player,"draw:infobox",root,"error","Du besitzt keinen Ausweis!")
	end
end
addEvent("set:job",true)
addEventHandler("set:job",root,setPlayerJob)