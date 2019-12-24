--//                                              \\--
--||   Project: Lakeside RP - MTA:SA Roleplay     ||--
--||   Developers: DorteY(Lorenzo)                ||--
--||   2019 - All rights reserved.                ||--
--\\                                              //--

DutyFBI=createPickup(327,307,998.9,3,1275,50)
setElementInterior(DutyFBI,5)
setElementDimension(DutyFBI,18)

function openFbiDutyUI(player)
	if(isLoggedin(player))then
		if(isFBI(player))then
			triggerClientEvent(player,"open:dutyfbiUI",player)
		else
			triggerClientEvent(player,"draw:infobox",root,"error","Du bist keiner vom FBI!")
		end
	end
end
addEventHandler("onPickupHit",DutyFBI,openFbiDutyUI)

function goOnOffDuty(typ)
	if(isLoggedin(client))then
		if(typ=="Onduty")then
			if(isFBI(client))then
				if(syncGetElementData(client,"CopDuty")==false)then
					syncSetElementData(client,"CopDuty",true)
					syncSetElementData(client,"Hunger",100)
					setElementHealth(client,100)
					triggerClientEvent(client,"draw:infobox",root,"success","Du hast den Dienst betreten!")
					if(syncGetElementData(client,"Gender")=="Male")then
						setElementModel(client,286)
					elseif(syncGetElementData(client,"Gender")=="Female")then
						setElementModel(client,211)
					end
				else
					triggerClientEvent(client,"draw:infobox",root,"error","Du bist bereits im Dienst!")
				end
			end
		elseif(typ=="Offduty")then
			if(syncGetElementData(client,"CopDuty")==true)then
				setElementModel(client,syncGetElementData(client,"SkinID"))
				takeAllWeapons(client)
				syncSetElementData(client,"CopDuty",false)
				triggerClientEvent(client,"draw:infobox",root,"success","Du hast den Dienst verlassen!")
			else
				triggerClientEvent(client,"draw:infobox",root,"error","Du bist nicht im Dienst!")
			end
		end
	end
end
addEvent("gofbi:onoffduty",true)
addEventHandler("gofbi:onoffduty",root,goOnOffDuty)