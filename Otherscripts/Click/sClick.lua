--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

addEventHandler("onPlayerClick",root,function(btn,state,elem)
	if(isLoggedin(source))then
		if(not isPedDead(source))then
			if(state=="down" and btn=="left")then
				if(elem and isElement(elem))then
					if(getElementData(source,"ElementClicked")==false)then
						local x,y,z=getElementPosition(source)
						local ox,oy,oz=getElementPosition(elem)
						local model=getElementModel(elem)
						if(getDistanceBetweenPoints3D(ox,oy,oz,x,y,z)<=3.5)then
							if(getElementDimension(source)==getElementDimension(elem))then
								if(getElementType(elem)=="ped")then
									if(getElementData(elem,"scooterPED")==true)then
										triggerClientEvent(source,"open:vehiclerental",source)
									elseif(getElementData(elem,"townhallPED")==true)then
										triggerClientEvent(source,"open:townhall",source)
									elseif(getElementData(elem,"townhallPinPED")==true)then
										triggerClientEvent(source,"open:townhallpin",source)
									elseif(getElementData(elem,"tankstationPED")==true)then
										triggerClientEvent(source,"open:tankstation",source)
									elseif(getElementData(elem,"mechtow:buyoutcarPED")==true)then
										openTowedVehpanel(source)
									--//Job peds
									elseif(getElementData(elem,"jobPED")==true)then
										triggerClientEvent(source,"open:job",source)
									elseif(getElementData(elem,"job:busPED")==true)then
										triggerClientEvent(source,"open:busjob",source)
									elseif(getElementData(elem,"job:pizzaPED")==true)then
										triggerClientEvent(source,"open:pizzajob",source)
									elseif(getElementData(elem,"job:taxiPED")==true)then
										triggerClientEvent(source,"open:taxijob",source)
									elseif(getElementData(elem,"job:holzPED")==true)then
										triggerClientEvent(source,"open:holzjob",source)
									--//Christmas peds
									elseif(getElementData(elem,"Christmas1PED")==true)then
										triggerClientEvent(source,"open:christmas1_UI",source)
									--//Shop peds
									elseif(getElementData(elem,"shop:burgershotPED")==true)then
										triggerClientEvent(source,"open:burgershotUI",source)
									elseif(getElementData(elem,"shop:pizzastackPED")==true)then
										triggerClientEvent(source,"open:pizzastackUI",source)
									elseif(getElementData(elem,"shop:chestdealerPED")==true)then
										triggerClientEvent(source,"open:chestdealer",source)
									elseif(getElementData(elem,"shop:moonstonedealerPED")==true)then
										triggerClientEvent(source,"open:moonstonedealer",source)
									elseif(getElementData(elem,"shop:fishingPED")==true)then
										triggerClientEvent(source,"open:fishingUI",source)
									elseif(getElementData(elem,"shop:farmPED")==true)then
										triggerClientEvent(source,"open:farmsellUI",source)
									elseif(getElementData(elem,"shop:electroPED")==true)then
										triggerClientEvent(source,"open:electroUI",source)
									elseif(getElementData(elem,"shop:normalPED")==true)then
										triggerClientEvent(source,"open:normalshopUI",source)
									elseif(getElementData(elem,"shop:ammunationPED")==true)then
										triggerClientEvent(source,"open:ammunationshopUI",source)
									elseif(getElementData(elem,"shop:skinPED")==true)then
										if(syncGetElementData(source,"DrivingschoolDuty")==false and syncGetElementData(source,"MechTowDuty")==false and syncGetElementData(source,"CopDuty")==false and syncGetElementData(source,"RescueDuty")==false)then
											triggerClientEvent(source,"open:skinshopUI",source)
										else
											triggerClientEvent(source,"draw:infobox",root,"error","Du bist noch im Dienst!")
										end
									elseif(getElementData(elem,"shop:factionPED")==true)then
										if(isEVIL(source))then
											triggerClientEvent(source,"shop:gangUI",source)
										end
									elseif(getElementData(elem,"shop:gangcardealerPED")==true)then
										if(isEVIL(source))then
											triggerClientEvent(source,"shop:gangcardealerUI",source)
										end
									elseif(getElementData(elem,"dealer:buybrechstangePED")==true)then
										triggerClientEvent(source,"open:buybrechstangepedUI",source,brechstangeBuyPrice,brechstangeBuyAmount)
									elseif(getElementData(elem,"dealer:buyweedPED")==true)then
										triggerClientEvent(source,"open:buyweedpedUI",source,weedBuyPrice,weedBuyAmount)
									elseif(getElementData(elem,"dealer:sellweedPED")==true)then
										triggerClientEvent(source,"open:sellweedpedUI",source,weedSellPrice,weedSellAmount)
									end
								elseif(getElementType(elem)=="player")then
									if(tonumber(getElementData(elem,"Wanteds"))>=1)then
										if(isTimer(TazerTimer[elem])and isSTATE(source))then
											if(isPedInVehicle(source)and getPedOccupiedVehicleSeat(source)==0)then
												local veh=getPedOccupiedVehicle(source)
												for i=1,3 do
													if(getVehicleOccupant(veh,i)==false)then
														if(isTimer(TazerTimer[elem]))then
															killTimer(TazerTimer[elem])
														end
														toggleAllControls(elem,false,true,false) 
														warpPedIntoVehicle(elem,veh,i)
														takeAllWeapons(elem)
														setElementData(elem,"tied",true)
														break
													end
												end
											end
										end
									end
									if(not isTimer(TazerTimer[elem]))then
										if(elem~=source)then
											setElementData(source,"set:clickedplayer",getPlayerName(elem))
											triggerClientEvent(source,"open:interactionUI",source)
										end
									end
								elseif(getElementType(elem)=="object")then
									if(getElementData(elem,"PlantID"))then
										local plantID=getElementData(elem,"PlantID")
										local plantIDTime=getData("userplants","ID",plantID,"Time")
										local rdm=math.random(8,11)
										if(plantIDTime~=0 and plantIDTime-getSecTime(0)<=0 or tonumber(syncGetElementData(source,"AdminLvL"))>=3)then
											local model=getElementModel(elem)
											syncSetElementData(source,plantItemID[model],syncGetElementData(source,plantItemID[model])+rdm)
											triggerClientEvent(source,"draw:infobox",root,"info","Du hast die Pflanze geerntet. (x"..rdm..")")
											handler:exec("DELETE FROM ?? WHERE ??=?","userplants","ID",plantID)
											destroyElement(elem)
										else
											triggerClientEvent(source,"draw:infobox",root,"error","Diese Pflanze kann noch nicht geerntet werden!")
											--triggerClientEvent(source,"draw:infobox",root,"error","This plant needs "..math.floor(((plantIDTime-getSecTime(0))/60)*100)/100 .." hours to grow until it can be harvested!",8000)
										end
									end
									if(model==2977 and getElementData(elem,"weaponbox")==true)then
										openWeaponbox(source)
									elseif(model==2332 and getElementData(elem,"factiondepot")==true)then
										if(tonumber(syncGetElementData(source,"Faction"))>=1)then
											loadFactionDepotState(source)
										end
									elseif(model==2332 and getElementData(elem,"companydepot")==true)then
										if(tonumber(syncGetElementData(source,"Company"))>=1)then
											loadCompanyDepotState(source)
										end
									end
									if(model==2942)then
										setElementData(source,"AtmID",getElementData(elem,"AtmID"))
										local ATMID=getElementData(source,"AtmID")
										if(getElementData(source,"SprengsatzState")==true)then
											if(getElementData(elem,"AlreadyExploded")~=true)then
												local x,y,z=getElementPosition(elem)
												local location=getZoneName(x,y,z)
												local location2=getZoneName(x,y,z,true)
												sendMSGForFaction("#008cff[DEPARTMENT] #c80000Ein ATM in "..location2.."("..location..") wird ausgeraubt!",1,200,200,0)
												sendMSGForFaction("#008cff[DEPARTMENT] #c80000Ein ATM in "..location2.."("..location..") wird ausgeraubt!",2,200,200,0)
												
												toggleAllControls(source,false)
												setElementFrozen(source,true)
												setPedAnimation(source,"BOMBER","BOM_Plant_Loop")
												ATMrobTimer[source]=setTimer(function(source,ATMID)
													local rdm=math.random(2500,15000)
													syncSetElementData(source,"Money",tonumber(syncGetElementData(source,"Money"))+rdm)
													triggerClientEvent(source,"draw:infobox",root,"success","Du konntest erfolgreich $"..rdm.." erbeuten!")
													setPedAnimation(source)
													setElementFrozen(source,false)
													toggleAllControls(source,true)
													sendMSGForFaction("#008cff[DEPARTMENT] #c80000Der ATM in "..location2.."("..location..") wurde erfolgreich ausgeraubt!",1,200,200,0)
													sendMSGForFaction("#008cff[DEPARTMENT] #c80000Der ATM in "..location2.."("..location..") wurde erfolgreich ausgeraubt!",2,200,200,0)
												end,55*1000,1,source,ATMID)
												setElementData(elem,"AlreadyExploded",true)
												setElementData(source,"SprengsatzState",false)
												syncSetElementData(source,"Brechstange",tonumber(syncGetElementData(source,"Brechstange"))-1)
											else
												
											end
										end
									end
								elseif(getElementType(elem)=="vehicle")then
									if(isSTATE(source)and syncGetElementData(source,"CopDuty")==true)then
										if(isVehicleLocked(elem)==false)then
											local trunk=getVVdata("uservehicles","Owner",getElementData(elem,"Owner"),"Slot",getElementData(elem,"Slot"),"Trunk")
											if(trunk)then
												local Burger=tonumber(gettok(trunk,1,string.byte("|")))
												local Pizza=tonumber(gettok(trunk,2,string.byte("|")))
												local Cola=tonumber(gettok(trunk,3,string.byte("|")))
												local Repairkit=tonumber(gettok(trunk,8,string.byte("|")))
												local Weed=tonumber(gettok(trunk,9,string.byte("|")))
												local Hanfsamen=tonumber(gettok(trunk,10,string.byte("|")))
												local Apfelsamen=tonumber(gettok(trunk,11,string.byte("|")))
												local Zigarette=tonumber(gettok(trunk,12,string.byte("|")))
												local Weste=tonumber(gettok(trunk,13,string.byte("|")))
												local Kokain=tonumber(gettok(trunk,14,string.byte("|")))
												local Mats=tonumber(gettok(trunk,15,string.byte("|")))
												
												if(Weed>=1)then
													triggerClientEvent(source,"draw:infobox",root,"info","x"..Weed.." Weed aus dem Fahrzeug entfernt!")
													syncSetElementData(source,"Weed",tonumber(syncGetElementData(source,"Weed"))+Weed)
													Weed=Weed-Weed
												end
												if(Mats>=1)then
													triggerClientEvent(source,"draw:infobox",root,"info","x"..Mats.." Mats aus dem Fahrzeug entfernt!")
													syncSetElementData(source,"Mats",tonumber(syncGetElementData(source,"Mats"))+Mats)
													Mats=Mats-Mats
												end
												if(Kokain>=1)then
													triggerClientEvent(source,"draw:infobox",root,"info","x"..Kokain.." Kokain aus dem Fahrzeug entfernt!")
													syncSetElementData(source,"Kokain",tonumber(syncGetElementData(source,"Kokain"))+Kokain)
													Kokain=Kokain-Kokain
												end
												
												
												local string=Burger.."|"..Pizza.."|"..Cola.."|0|0|0|0|"..Repairkit.."|"..Weed.."|"..Hanfsamen.."|"..Apfelsamen.."|"..Zigarette.."|"..Weste.."|"..Kokain.."|"..Mats.."|0|0|0|0|0|0|0|0|0|0"
												handler:exec("UPDATE ?? SET ??=? WHERE ??=? AND ??=?","uservehicles","Trunk",string,"Owner",getElementData(elem,"Owner"),"Slot",getElementData(elem,"Slot"))
											else
												triggerClientEvent(source,"draw:infobox",root,"error","Das Fahrzeug hat keinen Kofferraum!")
											end
										else
											triggerClientEvent(source,"draw:infobox",root,"error","Das Fahrzeug ist abgeschlossen!")
										end
									end
								end
							end
						end
						if(model==615 and getElementData(elem,"fallen")==true)then
							if(getDistanceBetweenPoints3D(ox,oy,oz,x,y,z)<=15)then
								if(isPedInVehicle(source))then
									if(getElementData(getPedOccupiedVehicle(source),"veh:holztruck")==true)then
										if(getElementData(elem,"baumOwner")==getPlayerName(source))then
											destroyElement(elem)
											HolzfaellerTakeTree(source)
										else
											triggerClientEvent(source,"draw:infobox",root,"error","Du hast diesen Baum nicht gefällt!")
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end)

function ATMrobDestroyElements(player)
	setElementData(player,"SprengsatzState",false)
	if(isTimer(ATMrobTimer[player]))then
		ATMrobTimer[player]:destroy()
	end
end
addEventHandler("onPlayerQuit",root,function()
	ATMrobDestroyElements(source)
end)
addEventHandler("onPlayerWasted",root,function()
	ATMrobDestroyElements(source)
end)




--//Barrikade
local objects={}
local count=0
local maxCount=35

function startPlaceObject(player)
	if(isSTATE(player)and syncGetElementData(player,"CopDuty")==true)then
		if(count<=maxCount)then
			triggerClientEvent(player,"place:barricade",player)
		end 
	end
end
addCommandHandler("placebarricade",startPlaceObject)

function createNewsObject(id,x,y,z,rx,ry,rz)
	local object=createObject(id,x,y,z,rx,ry,rz)
	setElementFrozen(object,true)
	setElementCollisionsEnabled(object,true)
	for _,v in ipairs(getElementsByType("player"))do
		triggerClientEvent(v,"set:barricadeunbreakable",v,object)
	end
	count=count+1
	objects[object]=true
end
addEvent("createNewsObject",true)
addEventHandler("createNewsObject",root,createNewsObject)

addEventHandler("onPlayerJoin",root,function()
	triggerClientEvent(source,"set:barricadeunbreakable",source,object)
end)

function newsPlayerClick(btn,state,elem)
	if(isSTATE(source)and syncGetElementData(source,"CopDuty")==true)then
		if(btn=="left" and state=="down")then
			if(objects[elem]==true)then
				objects[elem]=nil
				count=count-1
				destroyElement(elem)
				syncSetElementData(source,"Barrikade",tonumber(syncGetElementData(source,"Barrikade"))+1)
				triggerClientEvent(source,"draw:infobox",root,"success","Barrikade erfolgreich aufgehoben!")
			end
		end
	end
end
addEventHandler("onPlayerClick", root, newsPlayerClick)