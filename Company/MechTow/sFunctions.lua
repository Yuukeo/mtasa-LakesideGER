--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local MechTow_TowedMarker=createMarker(862.5,-1255.5,13.7,"cylinder",4,255,255,255,100)
local towedDIM=999

function openTowedVehpanel(player)
	local tbl={}
	local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","uservehicles","UID",playerUID[getPlayerName(player)]),-1)
	if(#result>=1)then
		for _,v in pairs(result)do
			if(v["Towed"]==1)then
				table.insert(tbl,{getVehicleNameFromModel(v["VehID"]),v["Slot"]})
			end
		end
		triggerClientEvent(player,"open:towedvehiclelist",player,tbl)
	end
end
addEvent("load:towedvehicle",true)
addEventHandler("load:towedvehicle",root,openTowedVehpanel)

addEvent("buyfree:vehicle",true)
addEventHandler("buyfree:vehicle",root,function(slot)
	if(tonumber(syncGetElementData(client,"Money"))>=1500)then
		local pname=getPlayerName(client)
		
		if(isElement(Vehicles[pname..slot]))then
			setElementPosition(Vehicles[pname..slot],920.4,-1167.7,18)
			setElementRotation(Vehicles[pname..slot],0,0,180)
			setElementDimension(Vehicles[pname..slot],0)
			setElementFrozen(Vehicles[pname..slot],false)
			
			setElementData(Vehicles[pname..slot],"Towed",0)
			handler:exec("UPDATE ?? SET ??=? WHERE ??=? AND ??=?","uservehicles","Towed",0,"UID",playerUID[pname],"Slot",slot)
			
			syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))-1500)
			
			triggerClientEvent(client,"draw:infobox",root,"info","Fahrzeug erfolgreich freigekauft!")
		end
	end
end)


addEventHandler("onMarkerHit",MechTow_TowedMarker,function(hitElement)
	if(getElementType(hitElement)=="vehicle")then
		local veh=hitElement
		local player=getVehicleOccupant(hitElement)
		if(isElement(player))then
			if(isMECHTOW(player)and syncGetElementData(player,"MechTowDuty")==true)then
				if(getElementModel(veh)==525)then
					local vehicleTowing=getVehicleTowedByVehicle(veh)
					if(vehicleTowing~=false)then
						if(getElementData(vehicleTowing,"Owner")and getElementData(vehicleTowing,"Owner")~="none" and getElementData(vehicleTowing,"Slot"))then
							if(getElementData(vehicleTowing,"Towed")==0)then
								local vehowner=getPlayerFromName(getElementData(vehicleTowing,"Owner"))
								
								setElementFrozen(vehicleTowing,true)
								towedDIM=towedDIM+1
								setElementDimension(vehicleTowing,towedDIM)
								
								setElementData(vehicleTowing,"Towed",1)
								handler:exec("UPDATE ?? SET ??=? WHERE ??=? AND ??=?","uservehicles","Towed",1,"Owner",getElementData(vehicleTowing,"Owner"),"Slot",getElementData(vehicleTowing,"Slot"))
								syncSetElementData(player,"Money",tonumber(syncGetElementData(player,"Money"))+65)
								triggerClientEvent(player,"draw:infobox",root,"success","Du erhälst für's Abschleppen $65")
								
								local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","companydepots","Company",tonumber(syncGetElementData(player,"Company"))),-1)
								if(result and result[1])then
									handler:exec("UPDATE ?? SET ??=? WHERE ??=?","companydepots","Money",tonumber(result[1]["Money"])+65,"Company",tonumber(syncGetElementData(player,"Company")))
								end
								
								if(isElement(vehowner))then
									outputChatBox("Dein Fahrzeug in Slot "..slot.." wurde abgeschleppt!",vehowner,255,255,255)
								else
									offlineMSG(owner,"Dein Fahrzeug in Slot "..slot.." wurde abgeschleppt!")
								end
							end
						else
							triggerClientEvent(player,"draw:infobox",root,"error","Du kannst nur Privat Fahrzeuge abschleppen!")
						end
					end
				end
			end
		end
	end
end)


MechTowDuty=createPickup(-2033.6,-117.6,1034.9,3,1275,50)
setElementInterior(MechTowDuty,3)
setElementDimension(MechTowDuty,100)

function openMechTowDutyUI(player)
	if(isLoggedin(player))then
		if(isMECHTOW(player))then
			triggerClientEvent(player,"open:mechdutyUI",player)
		else
			triggerClientEvent(player,"draw:infobox",root,"error","Du bist kein Mech&Tow Member!")
		end
	end
end
addEventHandler("onPickupHit",MechTowDuty,openMechTowDutyUI)

function goMechTowOnOffDuty(typ)
	if(isLoggedin(client))then
		if(typ=="Onduty")then
			if(isMECHTOW(client))then
				if(syncGetElementData(client,"MechTowDuty")==false)then
					syncSetElementData(client,"MechTowDuty",true)
					triggerClientEvent(client,"draw:infobox",root,"success","Du hast den Dienst betreten!")
					if(syncGetElementData(client,"Gender")=="Male")then
						setElementModel(client,50)
					elseif(syncGetElementData(client,"Gender")=="Female")then
						setElementModel(client,192)
					end
				else
					triggerClientEvent(client,"draw:infobox",root,"error","Du bist bereits im Dienst!")
				end
			end
		elseif(typ=="Offduty")then
			if(syncGetElementData(client,"MechTowDuty")==true)then
				setElementModel(client,syncGetElementData(client,"SkinID"))
				takeAllWeapons(client)
				syncSetElementData(client,"MechTowDuty",false)
				triggerClientEvent(client,"draw:infobox",root,"success","Du hast den Dienst verlassen!")
			else
				triggerClientEvent(client,"draw:infobox",root,"error","Du bist nicht im Dienst!")
			end
		end
	end
end
addEvent("go:mechonoffduty",true)
addEventHandler("go:mechonoffduty",root,goMechTowOnOffDuty)



--//Tuning system
local TuningTimer={}

local MechTow_Tuningmarker1=createMarker(900.4,-1164.4,16,"cylinder",1.2,255,255,255,100)
local MechTow_TuningColshape1=createColSphere(902.2,-1165.9,17,10)
local MechTow_TuningColshape11=createColSphere(902.2,-1165.9,17,2.5)

addEventHandler("onMarkerHit",MechTow_Tuningmarker1,function(hitElement)
    if(getElementType(hitElement)=="player" and isPedInVehicle(hitElement)==false and(isMECHTOW(hitElement)))then
        local veh=getElementsWithinColShape(MechTow_TuningColshape11,"vehicle")
		
        triggerClientEvent(hitElement,"open:mechTuningUI",hitElement,veh)
    end
end)

local function sendMessageForAllInGarage(text)
    local players=getElementsWithinColShape(MechTow_TuningColshape1,"player")
    for i=1,#players do
        outputChatBox("[INFO]: "..text,players[i],200,200,0)
    end
end

function mechtowTuningFunction(vehicle,tuning,price)
	if(syncGetElementData(client,"MechTowDuty")==true)then
		if(vehicle)then
			if(not isTimer(TuningTimer[vehicle]))then
				local money=tonumber(syncGetElementData(client,"Money"))
				if(money>=price)then
					if(tuning=="Sportmotor")then
						if(tonumber(syncGetElementData(client,"Companyrank"))<2)then
							outputChatBox("Erst ab Rang 2!",client,150,0,0)
							return
						else
							if(getElementData(vehicle,"Owner")and getElementData(vehicle,"Owner")~="none" and getElementData(vehicle,"Slot"))then
								if(getElementData(vehicle,"Sportmotor")<3)then
									sendMessageForAllInGarage("Das Fahrzeug "..getVehicleNameFromModel(getElementModel(vehicle)).." wird bearbeitet!")
									setElementFrozen(vehicle,true)
									syncSetElementData(client,"Money",money-price)
									local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","companydepots","Company",tonumber(syncGetElementData(player,"Company"))),-1)
									if(result and result[1])then
										handler:exec("UPDATE ?? SET ??=? WHERE ??=?","companydepots","Money",tonumber(result[1]["Money"])+4000,"Company",tonumber(syncGetElementData(player,"Company")))
									end
									TuningTimer[vehicle]=setTimer(function(vehicle)
										setElementFrozen(vehicle,false)
										setElementData(vehicle,"Sportmotor",getElementData(vehicle,"Sportmotor")+1)
										handler:exec("UPDATE ?? SET ??=? WHERE ??=? AND ??=?","uservehicles","Sportmotor",getElementData(vehicle,"Sportmotor"),"Owner",getElementData(vehicle,"Owner"),"Slot",getElementData(vehicle,"Slot"))
										sendMessageForAllInGarage("Der Sportmotor wurd erfolgreich in den " ..getVehicleNameFromModel(getElementModel(vehicle)).." gebaut! (Stufe: "..getElementData(vehicle,"Sportmotor")..")!")
										giveVehicleSpecialUpgrade(vehicle)
									end,15000,1,vehicle)
								else
									triggerClientEvent(client,"draw:infobox",root,"error","Das Fahrzeug hat bereits die maximale Sportmotorstufe!")
								end
							end
						end
					elseif(tuning=="Lowering")then
						if(tonumber(syncGetElementData(client,"Companyrank"))<2)then
							outputChatBox("Erst ab Rang 2!",client,150,0,0)
							return
						else
							if(getElementData(vehicle,"Owner")and getElementData(vehicle,"Owner")~="none" and getElementData(vehicle,"Slot"))then
								if(getElementData(vehicle,"Lowering")<3)then
									sendMessageForAllInGarage("Das Fahrzeug "..getVehicleNameFromModel(getElementModel(vehicle)).." wird bearbeitet!")
									setElementFrozen(vehicle,true)
									syncSetElementData(client,"Money",money-price)
									local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","companydepots","Company",tonumber(syncGetElementData(player,"Company"))),-1)
									if(result and result[1])then
										handler:exec("UPDATE ?? SET ??=? WHERE ??=?","companydepots","Money",tonumber(result[1]["Money"])+2500,"Company",tonumber(syncGetElementData(player,"Company")))
									end
									TuningTimer[vehicle]=setTimer(function(vehicle)
										setElementFrozen(vehicle,false)
										setElementData(vehicle,"Lowering",getElementData(vehicle,"Lowering")+1)
										handler:exec("UPDATE ?? SET ??=? WHERE ??=? AND ??=?","uservehicles","Lowering",getElementData(vehicle,"Lowering"),"Owner",getElementData(vehicle,"Owner"),"Slot",getElementData(vehicle,"Slot"))
										sendMessageForAllInGarage("Die Tieferlegerung wurd erfolgreich in den " ..getVehicleNameFromModel(getElementModel(vehicle)).." gebaut! (Stufe: "..getElementData(vehicle,"Lowering")..")!")
										giveVehicleSpecialUpgrade(vehicle)
									end,13000,1,vehicle)
								else
									triggerClientEvent(client,"draw:infobox",root,"error","Das Fahrzeug hat bereits die maximale Tieferlegerung!")
								end
							end
						end
					elseif(tuning=="Totalloss")then
						if(tonumber(syncGetElementData(client,"Companyrank"))<1)then
							outputChatBox("Only allowed from rank 1!",client,150,0,0)
							return
						else
							if(getElementData(vehicle,"Owner")and getElementData(vehicle,"Owner")~="none" and getElementData(vehicle,"Slot"))then
								if(getElementData(vehicle,"Totalloss")==1)then
									sendMessageForAllInGarage("Das Fahrzeug "..getVehicleNameFromModel(getElementModel(vehicle)).." wird bearbeitet!")
									setElementFrozen(vehicle,true)
									syncSetElementData(client,"Money",money-price)
									local result=dbPoll(dbQuery(handler,"SELECT * FROM ?? WHERE ??=?","companydepots","Company",tonumber(syncGetElementData(player,"Company"))),-1)
									if(result and result[1])then
										handler:exec("UPDATE ?? SET ??=? WHERE ??=?","companydepots","Money",tonumber(result[1]["Money"])+1000,"Company",tonumber(syncGetElementData(player,"Company")))
									end
									TuningTimer[vehicle]=setTimer(function(vehicle)
										setElementFrozen(vehicle,false)
										fixVehicle(vehicle)
										handler:exec("UPDATE ?? SET ??=? WHERE ??=? AND ??=?","uservehicles","Totalloss",0,"Owner",getElementData(vehicle,"Owner"),"Slot",getElementData(vehicle,"Slot"))
										setElementData(vehicle,"Totalloss",0)
										sendMessageForAllInGarage("Der Totalschaden wurde im "..getVehicleNameFromModel(getElementModel(vehicle)).." behoben!")
									end,10000,1,vehicle)
								else
									triggerClientEvent(client,"draw:infobox",root,"error","Das Fahrzeug hat keinen Totalschaden!")
								end
							end
						end
					end
				else
					triggerClientEvent(client,"draw:infobox",root,"error","Du hast nicht genug Bargeld! ($"..money..")")
				end
			else
				outputChatBox("Das Fahrzeug wird bereits getunt!",client,180,0,0)
			end
		end
	else
		triggerClientEvent(client,"draw:infobox",root,"error","Du bist nicht im Dienst!")
	end
end
addEvent("tune:privcar",true)
addEventHandler("tune:privcar",root,mechtowTuningFunction)


