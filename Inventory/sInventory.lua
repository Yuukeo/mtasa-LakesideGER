--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

local destroyItemAfterUsing={}

addEvent("use:item",true)
addEventHandler("use:item",root,function(item,amount)
		if(not isPedDead(client))then
			if(not isTimer(ATMrobTimer[client])and not isTimer(FallingOutofVehicleTimer[client])and not isTimer(GangtagPlayerTimer[client])and not isTimer(TazerTimer[client]))then
				if(getElementData(client,"AFK")==false)then
					if(tonumber(syncGetElementData(client,item))>=amount)then
						if(not isTimer(destroyItemAfterUsing[client]))then
							if(item=="Apfel")then
								if(not gotLastHit[client]or gotLastHit[client]+lastHitTimer<=getTickCount())then
									local BurgerItem=createObject(2880,0,0,0)
									setElementDimension(BurgerItem,getElementDimension(client))
									setElementInterior(BurgerItem,getElementInterior(client))
									attachElementToBone(BurgerItem,client,12,-0.05,0.02,0.02,20,-90,-10)
									setPedAnimation(client,"food","EAT_Burger",-1,false,false,false,false)
									destroyItemAfterUsing[client]=setTimer(function()
										if(isElement(BurgerItem))then
											detachElementFromBone(BurgerItem)
											destroyElement(BurgerItem)
											if(isTimer(destroyItemAfterUsing[client]))then
												destroyItemAfterUsing[client]:destroy()
											end
										end
									end,3400,1)
									setElementHealth(client,getElementHealth(client)+10*amount)
									syncSetElementData(client,"Hunger",tonumber(syncGetElementData(client,"Hunger"))+15*amount)
									syncSetElementData(client,item,tonumber(syncGetElementData(client,item))-amount)
									triggerClientEvent(client,"draw:infobox",root,"info","Du isst "..item.." x"..amount.."!")
									meCMD_func(client,"meCMD"," isst "..item.." x"..amount.."!")
									outputLog(getPlayerName(client).." isst "..item.." x"..amount.."!","Heal")
									
									if(tonumber(syncGetElementData(client,"Hunger"))>=100)then
										syncSetElementData(client,"Hunger",100)
									end
								else
									triggerClientEvent(client,"draw:infobox",root,"warning","Warte 2 Minuten nach dem letzten schlag/schuss!")
								end
								triggerClientEvent(client,"refresh:inventory",client)
							elseif(item=="Burger")then
								if(not gotLastHit[client]or gotLastHit[client]+lastHitTimer<=getTickCount())then
									local BurgerItem=createObject(2880,0,0,0)
									setElementDimension(BurgerItem,getElementDimension(client))
									setElementInterior(BurgerItem,getElementInterior(client))
									attachElementToBone(BurgerItem,client,12,-0.05,0.02,0.02,20,-90,-10)
									setPedAnimation(client,"food","EAT_Burger",-1,false,false,false,false)
									destroyItemAfterUsing[client]=setTimer(function()
										if(isElement(BurgerItem))then
											detachElementFromBone(BurgerItem)
											destroyElement(BurgerItem)
											if(isTimer(destroyItemAfterUsing[client]))then
												destroyItemAfterUsing[client]:destroy()
											end
										end
									end,3400,1)
									setElementHealth(client,getElementHealth(client)+10*amount)
									syncSetElementData(client,"Hunger",tonumber(syncGetElementData(client,"Hunger"))+15*amount)
									syncSetElementData(client,item,tonumber(syncGetElementData(client,item))-amount)
									triggerClientEvent(client,"draw:infobox",root,"info","Du isst "..item.." x"..amount.."!")
									meCMD_func(client,"meCMD"," isst "..item.." x"..amount.."!")
									outputLog(getPlayerName(client).." isst "..item.." x"..amount.."!","Heal")
									
									if(tonumber(syncGetElementData(client,"Hunger"))>=100)then
										syncSetElementData(client,"Hunger",100)
									end
								else
									triggerClientEvent(client,"draw:infobox",root,"warning","Warte 2 Minuten nach dem letzten schlag/schuss!")
								end
								triggerClientEvent(client,"refresh:inventory",client)
							elseif(item=="Pizza")then
								if(not gotLastHit[client]or gotLastHit[client]+lastHitTimer<=getTickCount())then
									local PizzaItem=createObject(2881,0,0,0)
									setElementDimension(PizzaItem,getElementDimension(client))
									setElementInterior(PizzaItem,getElementInterior(client))
									attachElementToBone(PizzaItem,client,12,-0.05,0.02,0.02,20,-90,-10)
									setPedAnimation(client,"food","EAT_Burger",-1,false,false,false,false)
									destroyItemAfterUsing[client]=setTimer(function()
										if(isElement(PizzaItem))then
											detachElementFromBone(PizzaItem)
											destroyElement(PizzaItem)
											if(isTimer(destroyItemAfterUsing[client]))then
												destroyItemAfterUsing[client]:destroy()
											end
										end
									end,3400,1)
									setElementHealth(client,getElementHealth(client)+12*amount)
									syncSetElementData(client,"Hunger",tonumber(syncGetElementData(client,"Hunger"))+17*amount)
									syncSetElementData(client,item,tonumber(syncGetElementData(client,item))-amount)
									triggerClientEvent(client,"draw:infobox",root,"info","Du isst "..item.." x"..amount.."!")
									meCMD_func(client,"meCMD"," isst "..item.." x"..amount.."!")
									outputLog(getPlayerName(client).." isst "..item.." x"..amount.."!","Heal")
									
									if(tonumber(syncGetElementData(client,"Hunger"))>=100)then
										syncSetElementData(client,"Hunger",100)
									end
								else
									triggerClientEvent(client,"draw:infobox",root,"warning","Warte 2 Minuten nach dem letzten schlag/schuss!")
								end
								triggerClientEvent(client,"refresh:inventory",client)
							elseif(item=="Forelle")then
								if(not gotLastHit[client]or gotLastHit[client]+lastHitTimer<=getTickCount())then
									setPedAnimation(client,"food","EAT_Burger",-1,false,false,false,false)
									setElementHealth(client,getElementHealth(client)+12*amount)
									syncSetElementData(client,"Hunger",tonumber(syncGetElementData(client,"Hunger"))+15*amount)
									syncSetElementData(client,item,tonumber(syncGetElementData(client,item))-amount)
									triggerClientEvent(client,"draw:infobox",root,"info","Du isst "..item.." x"..amount.."!")
									executeCommandHandler("me",client," isst "..item.." x"..amount.."!")
									outputLog(getPlayerName(client).." isst "..item.." x"..amount.."!","Heal")
									
									if(tonumber(syncGetElementData(client,"Hunger"))>=100)then
										syncSetElementData(client,"Hunger",100)
									end
								else
									triggerClientEvent(client,"draw:infobox",root,"warning","Warte 2 Minuten nach dem letzten schlag/schuss!")
								end
								triggerClientEvent(client,"refresh:inventory",client)
							elseif(item=="Zuckerstange")then
								if(not gotLastHit[client]or gotLastHit[client]+lastHitTimer<=getTickCount())then
									setPedAnimation(client,"food","EAT_Burger",-1,false,false,false,false)
									setElementHealth(client,getElementHealth(client)+12*amount)
									syncSetElementData(client,"Hunger",tonumber(syncGetElementData(client,"Hunger"))+17*amount)
									syncSetElementData(client,item,tonumber(syncGetElementData(client,item))-amount)
									triggerClientEvent(client,"draw:infobox",root,"info","Du isst "..item.." x"..amount.."!")
									meCMD_func(client,"meCMD"," isst "..item.." x"..amount.."!")
									outputLog(getPlayerName(client).." isst "..item.." x"..amount.."!","Heal")
									
									if(tonumber(syncGetElementData(client,"Hunger"))>=100)then
										syncSetElementData(client,"Hunger",100)
									end
								else
									triggerClientEvent(client,"draw:infobox",root,"warning","Warte 2 Minuten nach dem letzten schlag/schuss!")
								end
								triggerClientEvent(client,"refresh:inventory",client)
							elseif(item=="Cola")then
								if(not gotLastHit[client]or gotLastHit[client]+lastHitTimer<=getTickCount())then
									local ColaItem=createObject(1546,0,0,0)
									setElementDimension(ColaItem,getElementDimension(client))
									setElementInterior(ColaItem,getElementInterior(client))
									attachElementToBone(ColaItem,client,11,-0.02,0.06,0.14,20,90,-10)
									setPedAnimation(client,"vending","vend_drink2_p",-1,false,false,false,false)
									destroyItemAfterUsing[client]=setTimer(function()
										if(isElement(ColaItem))then
											detachElementFromBone(ColaItem)
											destroyElement(ColaItem)
											if(isTimer(destroyItemAfterUsing[client]))then
												destroyItemAfterUsing[client]:destroy()
											end
										end
									end,3400,1)
									setElementHealth(client,getElementHealth(client)+12*amount)
									syncSetElementData(client,"Hunger",tonumber(syncGetElementData(client,"Hunger"))+8*amount)
									syncSetElementData(client,item,tonumber(syncGetElementData(client,item))-amount)
									triggerClientEvent(client,"draw:infobox",root,"info","Du drinkst "..item.." x"..amount.."!")
									meCMD_func(client,"meCMD"," drinkt "..item.." x"..amount.."!")
									outputLog(getPlayerName(client).." drinkt "..item.." x"..amount.."!","Heal")
									
									if(tonumber(syncGetElementData(client,"Hunger"))>=100)then
										syncSetElementData(client,"Hunger",100)
									end
								else
									triggerClientEvent(client,"draw:infobox",root,"warning","Warte 2 Minuten nach dem letzten schlag/schuss!")
								end
								triggerClientEvent(client,"refresh:inventory",client)
							elseif(item=="Zigarette")then
								if(not gotLastHit[client]or gotLastHit[client]+lastHitTimer<=getTickCount())then
									--[[local CigaretteItem=createObject(3027,0,0,0)
									setElementDimension(CigaretteItem,getElementDimension(client))
									setElementInterior(CigaretteItem,getElementInterior(client))
									attachElementToBone(CigaretteItem,client,11,-0.02,0.06,0.14,20,90,-10)]]
									setPedAnimation(client,"smoking","M_smkstnd_loop",-1,false,false,false,false)
									destroyItemAfterUsing[client]=setTimer(function()
										if(isElement(CigaretteItem))then
											detachElementFromBone(CigaretteItem)
											destroyElement(CigaretteItem)
											if(isTimer(destroyItemAfterUsing[client]))then
												destroyItemAfterUsing[client]:destroy()
											end
										end
									end,3700,1)
									setElementHealth(client,getElementHealth(client)+8*amount)
									syncSetElementData(client,item,tonumber(syncGetElementData(client,item))-amount)
									triggerClientEvent(client,"draw:infobox",root,"info","Du rauchst "..item.." x"..amount.."!")
									meCMD_func(client,"meCMD"," raucht "..item.." x"..amount.."!")
									outputLog(getPlayerName(client).." raucht "..item.." x"..amount.."!","Heal")
								else
									triggerClientEvent(client,"draw:infobox",root,"warning","Warte 2 Minuten nach dem letzten schlag/schuss!")
								end
								triggerClientEvent(client,"refresh:inventory",client)
							elseif(item=="Kokain")then
								if(not gotLastHit[client]or gotLastHit[client]+lastHitTimer<=getTickCount())then
									if(tonumber(syncGetElementData(client,item))>=amount)then
										syncSetElementData(client,item,tonumber(syncGetElementData(client,item))-amount)
										executeCommandHandler("me",client," zieht "..item.."!")
										outputLog(getPlayerName(client).." zieht "..item.."!","Heal")
										setPedAnimation(client,"smoking","M_smkstnd_loop",-1,false,false,false,false)
										triggerClientEvent(client,"use:cocaineeffect",client)
										triggerClientEvent(client,"refresh:inventory",client)
									else
										triggerClientEvent(client,"draw:infobox",root,"error","Du brauchst dieses Item x"..amount.."!")
									end
								else
									triggerClientEvent(client,"draw:infobox",root,"warning","Warte 2 Minuten nach dem letzten schlag/schuss!")
								end
							elseif(item=="Weed")then
								if(not gotLastHit[client]or gotLastHit[client]+lastHitTimer<=getTickCount())then
									if(tonumber(syncGetElementData(client,item))>=amount)then
										syncSetElementData(client,item,tonumber(syncGetElementData(client,item))-amount)
										executeCommandHandler("me",client," raucht "..item.."!")
										outputLog(getPlayerName(client).." raucht "..item.."!","Heal")
										setPedAnimation(client,"smoking","M_smkstnd_loop",-1,false,false,false,false)
										triggerClientEvent(client,"use:weedeffect",client)
										triggerClientEvent(client,"refresh:inventory",client)
									else
										triggerClientEvent(client,"draw:infobox",root,"error","Du brauchst dieses Item x"..amount.."!")
									end
								else
									triggerClientEvent(client,"draw:infobox",root,"warning","Warte 2 Minuten nach dem letzten schlag/schuss!")
								end
							elseif(item=="Hanfsamen")then
								createPlant(client,item)
								triggerClientEvent(client,"refresh:inventory",client)
							elseif(item=="Apfelsamen")then
								createPlant(client,item)
								triggerClientEvent(client,"refresh:inventory",client)
							elseif(item=="Weste")then
								if(not gotLastHit[client]or gotLastHit[client]+lastHitTimer<=getTickCount())then
									syncSetElementData(client,item,tonumber(syncGetElementData(client,item))-1)
									setPedArmor(client,100)
								else
									triggerClientEvent(client,"draw:infobox",root,"warning","Warte 2 Minuten nach dem letzten schlag/schuss!")
								end
								triggerClientEvent(client,"refresh:inventory",client)
							elseif(item=="Brechstange")then
								setElementData(client,"SprengsatzState",true)
								triggerClientEvent(client,"draw:infobox",root,"info","Klicke nun auf einen Automaten\num diesen aufzubrechen!")
							elseif(item=="ChestWood")then
								syncSetElementData(client,item,tonumber(syncGetElementData(client,item))-1)
								executeCommandHandler("me",client," öffnet eine "..item.." x1")
								local rdm=math.random(1,350)
								
								if(rdm>=1 and rdm<=100)then
									local burger=math.random(1,10)
									syncSetElementData(client,"Burger",tonumber(syncGetElementData(client,"Burger"))+burger)
									triggerClientEvent(client,"draw:infobox",root,"info","Du erhälst x"..burger.." Burger aus dieser Holzkiste!")
									if(tonumber(syncGetElementData(client,"Burger"))>=50)then
										syncSetElementData(client,"Burger",50)
									end
								elseif(rdm>=101 and rdm<=220)then
									local money=math.random(1000,3500)
									syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))+money)
									triggerClientEvent(client,"draw:infobox",root,"info","Du erhälst $"..money.." aus dieser Holzkiste!")
								elseif(rdm>=221 and rdm<=245)then
									local ticket=math.random(1,1)
									local ticket2=math.random(1,2)
									if(ticket2==1)then
										syncSetElementData(client,"TicketBronze",tonumber(syncGetElementData(client,"TicketBronze"))+ticket)
										triggerClientEvent(client,"draw:infobox",root,"info","Du erhälst x"..ticket.." Bronzeticket(s) aus dieder Holzkiste!")
									elseif(ticket2==2)then
										syncSetElementData(client,"TicketSilver",tonumber(syncGetElementData(client,"TicketSilver"))+ticket)
										triggerClientEvent(client,"draw:infobox",root,"info","Du erhälst x"..ticket.." Silverticket(s) aus dieder Holzkiste!")
									end
								elseif(rdm>=246 and rdm<=350)then
									triggerClientEvent(client,"draw:infobox",root,"info","You get nothing out of the wood chest!")
								end
								triggerClientEvent(client,"refresh:inventory",client)
							elseif(item=="ChestIron")then
								syncSetElementData(client,item,tonumber(syncGetElementData(client,item))-1)
								executeCommandHandler("me",client," öffnet eine "..item.." x1")
								local rdm=math.random(1,300)
								
								if(rdm>=1 and rdm<=100)then
									local burger=math.random(3,15)
									syncSetElementData(client,"Burger",tonumber(syncGetElementData(client,"Burger"))+burger)
									triggerClientEvent(client,"draw:infobox",root,"info","Du erhälst x"..burger.." Burger aus dieser Eisenkiste!")
									if(tonumber(syncGetElementData(client,"Burger"))>=50)then
										syncSetElementData(client,"Burger",50)
									end
								elseif(rdm>=101 and rdm<=280)then
									local money=math.random(2000,6500)
									syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))+money)
									triggerClientEvent(client,"draw:infobox",root,"info","Du erhälst $"..money.." aus dieser Eisenkiste!")
								elseif(rdm>=281 and rdm<=300)then
									local ticket=math.random(1,3)
									local ticket2=math.random(1,2)
									if(ticket2==1)then
										syncSetElementData(client,"TicketBronze",tonumber(syncGetElementData(client,"TicketBronze"))+ticket)
										triggerClientEvent(client,"draw:infobox",root,"info","Du erhälst x"..ticket.." Bronzeticket(s) aus dieder Eisenkiste!")
									elseif(ticket2==2)then
										syncSetElementData(client,"TicketSilver",tonumber(syncGetElementData(client,"TicketSilver"))+ticket)
										triggerClientEvent(client,"draw:infobox",root,"info","Du erhälst x"..ticket.." Silverticket(s) aus dieder Eisenkiste!")
									end
								end
								triggerClientEvent(client,"refresh:inventory",client)
							elseif(item=="Geschenk")then
								if(settings.general.christmas==true)then
									syncSetElementData(client,item,tonumber(syncGetElementData(client,item))-1)
									executeCommandHandler("me",client," öffnet "..item.." x1")
									local rdm=math.random(1,300)
									
									if(rdm>=1 and rdm<=100)then
										local money=math.random(1000,3500)
										syncSetElementData(client,"Money",tonumber(syncGetElementData(client,"Money"))+money)
										triggerClientEvent(client,"draw:infobox",root,"info","Du erhälst $"..money.." aus dem Geschenk!")
									elseif(rdm>=101 and rdm<=200)then
										local ticket=math.random(1,1)
										local ticket2=math.random(1,2)
										if(ticket2==1)then
											syncSetElementData(client,"TicketBronze",tonumber(syncGetElementData(client,"TicketBronze"))+ticket)
											triggerClientEvent(client,"draw:infobox",root,"info","Du erhälst x"..ticket.." Bronzeticket(s) aus dem Geschenk!")
										elseif(ticket2==2)then
											syncSetElementData(client,"TicketSilver",tonumber(syncGetElementData(client,"TicketSilver"))+ticket)
											triggerClientEvent(client,"draw:infobox",root,"info","Du erhälst x"..ticket.." Silverticket(s) aus dem Geschenk!")
										end
									elseif(rdm>=201 and rdm<=205)then
										local rdmcode=math.random(1000000,9999999)
										outputChatbox("You have won a Hotring Racer 1. CODE: "..rdmcode..". Contact an admin!",client,255,0,0)
									elseif(rdm>=206 and rdm<=300)then
										local weed=math.random(3,10)
										syncSetElementData(client,"Weed",tonumber(syncGetElementData(client,"Weed"))+weed)
										triggerClientEvent(client,"draw:infobox",root,"info","Du erhälst x"..weed.." Weed aus dem Geschenk!")
									end
									triggerClientEvent(client,"refresh:inventory",client)
								else
									triggerClientEvent(client,"draw:infobox",root,"error","Die Weihnachtszeit ist abgelaufen!")
								end
							elseif(item=="Repairkit")then
								if(not isPedInVehicle(client))then
									for _,v in pairs(getElementsByType("vehicle"))do
										local x,y,z=getElementPosition(v)
										local px,py,pz=getElementPosition(client)
										
										if(getDistanceBetweenPoints3D(x,y,z,px,py,pz)<=3)then
											syncSetElementData(client,item,syncGetElementData(client,item)-amount)
											executeCommandHandler("me",client," using a "..item)
											setPedAnimation(client,"graffiti","spraycan_fire")
											fixVehicle(v)
											finisRepairkit(client)
											if(tonumber(getElementData(v,"Totalloss"))==1)then
												setElementData(v,"Totalloss",0)
												handler:exec("UPDATE ?? SET ??=? WHERE ??=? AND ??=?","uservehicles","Totalloss",0,"Owner",getElementData(v,"Owner"),"Slot",getElementData(v,"Slot"))
												setVehicleDamageProof(v,false)
											end
										end
									end
								else
									triggerClientEvent(client,"draw:infobox",root,"error","Stelle dich vor oder neben das Fahrzeug!")
								end
							elseif(item=="Ausweis")then
								triggerClientEvent(client,"open:idcard",client)
							elseif(item=="Fahrzeugschlüssel")then
								openVehpanel(client)
							elseif(item=="Mondstein")then
								outputChatBox("Du kannst es nur auf dem Mond verkaufen!",client,200,0,0)
							elseif(item=="Benzinkanister")then
								if(isPedInVehicle(client))then
									local veh=getPedOccupiedVehicle(client)
									if(tonumber(getElementData(veh,"Fuel"))<100)then
										setElementData(veh,"Fuel",tonumber(getElementData(veh,"Fuel"))+25)
										if(tonumber(getElementData(veh,"Fuel"))>=100)then
											setElementData(veh,"Fuel",100)
										end
										syncSetElementData(client,item,syncGetElementData(client,item)-amount)
										triggerClientEvent(client,"refresh:inventory",client)
									end
								end
							elseif(item=="Barrikade")then
								if(not isPedInVehicle(client))then
									executeCommandHandler("placebarricade",client)
								end
							end
						end
					end
				end
			end
		end
	--else
	--	triggerClientEvent(client,"draw:infobox",root,"warning","Warte 2 Minuten nach dem letzten hit/schuss!")
	--end
end)
addEvent("destroy:item",true)
addEventHandler("destroy:item",root,function(item,amount)
	if(not isPedDead(client))then
		if(tonumber(syncGetElementData(client,item))>=amount)then
			if(item~="TicketBronze" and item~="TicketSilver" and item~="TicketGold" and item~="Ausweis" and item~="Fahrzeugschlüssel")then
				syncSetElementData(client,item,tonumber(syncGetElementData(client,item))-amount)
				triggerClientEvent(client,"refresh:inventory",client)
				executeCommandHandler("mee",client," hat "..item.." x"..amount.." weggeworfen!")
			else
				triggerClientEvent(client,"draw:infobox",root,"warning","Du kannst dieses Item nicht löschen!")
			end
		end
	end
end)

function finisRepairkit(player)
	setTimer(function()
		triggerClientEvent(player,"draw:infobox",root,"success","Das Fahrzeug wurde erfolgreich repariert!")
		setPedAnimation(player)
	end,6500,1)
end





function getTrunkItems(player)
	local veh=getPedOccupiedVehicle(player)
	if(veh)then
		local trunk=getVVdata("uservehicles","Owner",getElementData(veh,"Owner"),"Slot",getElementData(veh,"Slot"),"Trunk")
		if(trunk)then
			local tbl={}
			table.insert(tbl,{"Burger",gettok(trunk,1,string.byte("|"))})
			table.insert(tbl,{"Pizza",gettok(trunk,2,string.byte("|"))})
			table.insert(tbl,{"Cola",gettok(trunk,3,string.byte("|"))})
			table.insert(tbl,{"Repairkit",gettok(trunk,8,string.byte("|"))})
			table.insert(tbl,{"Weed",gettok(trunk,9,string.byte("|"))})
			table.insert(tbl,{"Hanfsamen",gettok(trunk,10,string.byte("|"))})
			table.insert(tbl,{"Apfelsamen",gettok(trunk,11,string.byte("|"))})
			table.insert(tbl,{"Zigarette",gettok(trunk,12,string.byte("|"))})
			table.insert(tbl,{"Weste",gettok(trunk,13,string.byte("|"))})
			table.insert(tbl,{"Kokain",gettok(trunk,14,string.byte("|"))})
			table.insert(tbl,{"Mats",gettok(trunk,15,string.byte("|"))})
			triggerClientEvent(player,"set:trunkitems",player,tbl)
		end
	end
end
addEvent("get:trunkitems",true)
addEventHandler("get:trunkitems",root,getTrunkItems)


addEvent("trunk:putin",true)
addEventHandler("trunk:putin",root,function(owner,item,amount)
	local veh=getPedOccupiedVehicle(client)
	local amount=tonumber(amount)
	if(veh)then
		if(amount)then
			if(owner==getElementData(veh,"Owner"))then
				if(tonumber(syncGetElementData(client,item))>=amount)then
					local trunk=getVVdata("uservehicles","Owner",getElementData(veh,"Owner"),"Slot",getElementData(veh,"Slot"),"Trunk")
					if(trunk)then
						if(item=="Burger" or item=="Pizza" or item=="Cola" or item=="Repairkit" or item=="Weed" or item=="Hanfsamen" or item=="Apfelsamen" or item=="Zigarette" or item=="Weste" or item=="Kokain" or item=="Mats")then
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
							syncSetElementData(client,item,tonumber(syncGetElementData(client,item))-amount)
							
							
							if(item=="Burger")then
								Burger=Burger+amount
							elseif(item=="Pizza")then
								Pizza=Pizza+amount
							elseif(item=="Cola")then
								Cola=Cola+amount
							elseif(item=="Repairkit")then
								Repairkit=Repairkit+amount
							elseif(item=="Weed")then
								Weed=Weed+amount
							elseif(item=="Hanfsamen")then
								Hanfsamen=Hanfsamen+amount
							elseif(item=="Apfelsamen")then
								Apfelsamen=Apfelsamen+amount
							elseif(item=="Zigarette")then
								Zigarette=Zigarette+amount
							elseif(item=="Weste")then
								Weste=Weste+amount
							elseif(item=="Kokain")then
								Kokain=Kokain+amount
							elseif(item=="Mats")then
								Mats=Mats+amount
							else
								triggerClientEvent(client,"draw:infobox",root,"error","Du kannst dieses Item nicht einlagern!")
							end
							local string=Burger.."|"..Pizza.."|"..Cola.."|0|0|0|0|"..Repairkit.."|"..Weed.."|"..Hanfsamen.."|"..Apfelsamen.."|"..Zigarette.."|"..Weste.."|"..Kokain.."|"..Mats.."|0|0|0|0|0|0|0|0|0|0"
							
							handler:exec("UPDATE ?? SET ??=? WHERE ??=? AND ??=?","uservehicles","Trunk",string,"Owner",getElementData(veh,"Owner"),"Slot",getElementData(veh,"Slot"))
							getTrunkItems(client)
						else
							triggerClientEvent(client,"draw:infobox",root,"error","Du kannst dieses Item nicht einlagern!")
						end
					else
						triggerClientEvent(client,"draw:infobox",root,"error","Dieses Fahrzeug hat keinen Kofferraum!")
					end
				else
					triggerClientEvent(client,"draw:infobox",root,"error","Du hast dieses Item nicht so oft! (x"..amount..")")
				end
			end
		end
	end
end)
addEvent("trunk:putout",true)
addEventHandler("trunk:putout",root,function(owner,item,amount)
	local amount=tonumber(amount)
	local veh=getPedOccupiedVehicle(client)
	if(veh)then
		if(item)then
			if(amount)then
				if(owner==getElementData(veh,"Owner"))then
					local trunk=getVVdata("uservehicles","Owner",getElementData(veh,"Owner"),"Slot",getElementData(veh,"Slot"),"Trunk")
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
						
						if(item=="Burger")then
							if(Burger<amount)then
								triggerClientEvent(client,"draw:infobox",root,"error","In dem Kofferraum sind nicht so viele Items! (x"..amount..")")
								return false
							end
						elseif(item=="Pizza")then
							if(Pizza<amount)then
								triggerClientEvent(client,"draw:infobox",root,"error","In dem Kofferraum sind nicht so viele Items! (x"..amount..")")
								return false
							end
						elseif(item=="Cola")then
							if(Cola<amount)then
								triggerClientEvent(client,"draw:infobox",root,"error","In dem Kofferraum sind nicht so viele Items! (x"..amount..")")
								return false
							end
						elseif(item=="Repairkit")then
							if(Repairkit<amount)then
								triggerClientEvent(client,"draw:infobox",root,"error","In dem Kofferraum sind nicht so viele Items! (x"..amount..")")
								return false
							end
						elseif(item=="Weed")then
							if(Weed<amount)then
								triggerClientEvent(client,"draw:infobox",root,"error","In dem Kofferraum sind nicht so viele Items! (x"..amount..")")
								return false
							end
						elseif(item=="Hanfsamen")then
							if(Hanfsamen<amount)then
								triggerClientEvent(client,"draw:infobox",root,"error","In dem Kofferraum sind nicht so viele Items! (x"..amount..")")
								return false
							end
						elseif(item=="Apfelsamen")then
							if(Apfelsamen<amount)then
								triggerClientEvent(client,"draw:infobox",root,"error","In dem Kofferraum sind nicht so viele Items! (x"..amount..")")
								return false
							end
						elseif(item=="Zigarette")then
							if(Zigarette<amount)then
								triggerClientEvent(client,"draw:infobox",root,"error","In dem Kofferraum sind nicht so viele Items! (x"..amount..")")
								return false
							end
						elseif(item=="Weste")then
							if(Weste<amount)then
								triggerClientEvent(client,"draw:infobox",root,"error","In dem Kofferraum sind nicht so viele Items! (x"..amount..")")
								return false
							end
						elseif(item=="Kokain")then
							if(Kokain<amount)then
								triggerClientEvent(client,"draw:infobox",root,"error","In dem Kofferraum sind nicht so viele Items! (x"..amount..")")
								return false
							end
						elseif(item=="Mats")then
							if(Mats<amount)then
								triggerClientEvent(client,"draw:infobox",root,"error","In dem Kofferraum sind nicht so viele Items! (x"..amount..")")
								return false
							end
						end
						syncSetElementData(client,item,tonumber(syncGetElementData(client,item))+amount)
						
						if(item=="Burger")then
							Burger=Burger-amount
						elseif(item=="Pizza")then
							Pizza=Pizza-amount
						elseif(item=="Cola")then
							Cola=Cola-amount
						elseif(item=="Repairkit")then
							Repairkit=Repairkit-amount
						elseif(item=="Weed")then
							Weed=Weed-amount
						elseif(item=="Hanfsamen")then
							Hanfsamen=Hanfsamen-amount
						elseif(item=="Apfelsamen")then
							Apfelsamen=Apfelsamen-amount
						elseif(item=="Zigarette")then
							Zigarette=Zigarette-amount
						elseif(item=="Weste")then
							Weste=Weste-amount
						elseif(item=="Kokain")then
							Kokain=Kokain-amount
						elseif(item=="Mats")then
							Mats=Mats-amount
						end
						
						local string=Burger.."|"..Pizza.."|"..Cola.."|0|0|0|0|"..Repairkit.."|"..Weed.."|"..Hanfsamen.."|"..Apfelsamen.."|"..Zigarette.."|"..Weste.."|"..Kokain.."|"..Mats.."|0|0|0|0|0|0|0|0|0|0"
						handler:exec("UPDATE ?? SET ??=? WHERE ??=? AND ??=?","uservehicles","Trunk",string,"Owner",getElementData(veh,"Owner"),"Slot",getElementData(veh,"Slot"))
						getTrunkItems(client)
					end
				else
					triggerClientEvent(client,"draw:infobox",root,"error","Dieses Fahrzeug gehört dir nicht!")
				end
			end
		end
	end
end)